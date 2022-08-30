import 'package:flutter/material.dart';
import 'package:glossary/fragments/header.dart';
import 'package:glossary/fragments/body.dart';
import 'package:glossary/entities/glossary.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:glossary/globals.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final List<Glossary> _glossaries = <Glossary>[];
  final List<Glossary> _filteredGlossaries = <Glossary>[];

  Future fetchGlossary() async {
    var url = Uri.https('amlxv.github.io', 'e-glosari_falsafah/glosari.json');
    var response = await http.get(url);
    var glossaries = <Glossary>[];

    if (response.statusCode == 200) {
      var glossariesJson = json.decode(response.body);
      for (var glossaryJson in glossariesJson) {
        glossaries.add(Glossary.fromJson(glossaryJson));
      }
    }

    if (response.statusCode != 200) {
      final SnackBar snackBar = SnackBar(
        content: Text(
          'Berlaku ralat semasa memuatkan data!',
          style: GoogleFonts.openSans(),
        ),
        duration: const Duration(seconds: 16),
      );
      snackbarKey.currentState?.showSnackBar(snackBar);
    }

    return glossaries;
  }

  filterGlossary(keyword) {
    var result = _glossaries
        .where((g) =>
            g.term.toLowerCase().contains(keyword.toString().toLowerCase()))
        .toList();
    setState(() {
      if (result.isNotEmpty) {
        _filteredGlossaries.clear();
        _filteredGlossaries.addAll(result);
      } else {
        _filteredGlossaries.clear();
        _filteredGlossaries.addAll(_glossaries);
      }
    });
  }

  @override
  void initState() {
    fetchGlossary().then((value) {
      setState(() {
        _glossaries.addAll(value);
        _glossaries.sort((a, b) => a.term.compareTo(b.term));
        _filteredGlossaries.addAll(_glossaries);
      });
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Map<String, double> size = {
      'height': MediaQuery.of(context).size.height,
      'width': MediaQuery.of(context).size.width
    };
    return GestureDetector(
      onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
      child: Scaffold(
        body: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Header(
                size: size,
                glossaries: _glossaries,
                filterGlossary: filterGlossary,
              ),
              Body(
                size: size,
                glossaries: _filteredGlossaries,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
