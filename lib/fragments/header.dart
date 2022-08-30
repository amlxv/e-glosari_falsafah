import 'package:flutter/material.dart';
import 'package:glossary/components/custom_background_clipper.dart';
import 'package:glossary/entities/glossary.dart';
import 'package:google_fonts/google_fonts.dart';
import 'dart:math';
import 'package:glossary/globals.dart';

class Header extends StatefulWidget {
  final Map<String, double> size;
  final List<Glossary> glossaries;
  final Function filterGlossary;

  const Header({Key? key, required this.size, required this.glossaries, required this.filterGlossary})
      : super(key: key);

  @override
  State<Header> createState() => _HeaderState();
}

class _HeaderState extends State<Header> {
  late List<Glossary> _glossaries;
  late Function _filterGlossary;
  late int randomGlossaryIndex = widget.glossaries.isNotEmpty
      ? Random().nextInt(max(0, widget.glossaries.length - 1))
      : 0;

  @override
  void initState() {
    setState(() {
      _glossaries = widget.glossaries;
      _filterGlossary = widget.filterGlossary;
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final double? height = widget.size['height'];
    final double? width = widget.size['width'];

    var randomGlossaryTerm = _glossaries.isNotEmpty
        ? _glossaries[randomGlossaryIndex].term
        : '';
    randomGlossaryTerm = randomGlossaryTerm.length > 12
        ? '${randomGlossaryTerm.substring(0, 12)}...'
        : randomGlossaryTerm;

    return Stack(
      clipBehavior: Clip.none,
      children: [
        ClipPath(
          clipper: CustomBackgroundClipper(),
          child: Container(
            color: const Color(0xFFC6B6F5),
            height: (height! * 0.03) + 260,
          ),
        ),
        Positioned(
          width: width,
          height: 260,
          top: height * 0.033,
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 36),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Glosari Falsafah',
                  style: GoogleFonts.playfairDisplay(
                    fontSize: 30,
                    fontWeight: FontWeight.bold,
                    color: Colors.purple.shade900,
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                Text(
                  'App Glosari Falsafah dibangunkan dengan tujuan membantu para pelajar secara khususnya dan masyarakat di luar amnya untuk lebih mudah memahami ilmu falsafah dan istilah-istilah yang terkandung dalam ilmu falsafah.',
                  style: GoogleFonts.openSans(
                    color: Colors.purple.shade900,
                    fontStyle: FontStyle.italic,
                  ),
                ),
                const SizedBox(
                  height: 15,
                ),
                TextField(
                  onChanged: (text) => _filterGlossary(text),
                  autofocus: false,
                  style: GoogleFonts.openSans(color: Colors.purple.shade900),
                  decoration: InputDecoration(
                    prefixIcon: const Icon(Icons.search),
                    hintText: 'Carian...',
                    contentPadding: const EdgeInsets.all(20),
                    filled: true,
                    fillColor: Colors.white,
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(16),
                      borderSide: const BorderSide(color: Colors.white),
                    ),
                    enabledBorder: UnderlineInputBorder(
                      borderRadius: BorderRadius.circular(16),
                      borderSide: const BorderSide(color: Colors.white),
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
        Positioned(
          left: 0,
          right: 0,
          bottom: -40,
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 50),
            child: GestureDetector(
              behavior: HitTestBehavior.opaque,
              onTap: () {
                if (_glossaries.isEmpty) {
                  final SnackBar snackBar = SnackBar(
                    content: Text(
                      'Berlaku ralat semasa memuatkan data!',
                      style: GoogleFonts.openSans(),
                    ),
                  );
                  snackbarKey.currentState?.showSnackBar(snackBar);
                  return;
                }
                showModalBottomSheet<void>(
                    context: context,
                    builder: (BuildContext context) {
                      return Container(
                        padding: const EdgeInsets.symmetric(horizontal: 25),
                        height: 250,
                        color: Colors.white,
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: <Widget>[
                            Text(
                              _glossaries[randomGlossaryIndex].term,
                              style: GoogleFonts.openSans(
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            Text(
                              _glossaries[randomGlossaryIndex].definition,
                              style: GoogleFonts.openSans(),
                            ),
                            ElevatedButton(
                              style: ButtonStyle(
                                backgroundColor: MaterialStateColor.resolveWith(
                                    (states) => Colors.red),
                              ),
                              onPressed: () => Navigator.pop(context),
                              child: Text(
                                'Tutup Paparan',
                                style: GoogleFonts.openSans(),
                              ),
                            )
                          ],
                        ),
                      );
                    });
              },
              child: Card(
                shadowColor: Colors.purple,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15),
                ),
                child: Container(
                  padding:
                      const EdgeInsets.symmetric(vertical: 20, horizontal: 25),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Apakah Definisi',
                            style: GoogleFonts.openSans(
                              fontSize: 14,
                              fontWeight: FontWeight.bold,
                              color: Colors.purple.shade700,
                            ),
                          ),
                          const SizedBox(
                            height: 4,
                          ),
                          Text(
                            randomGlossaryTerm,
                            style: GoogleFonts.openSans(
                              color: const Color(0XFF505050),
                            ),
                          ),
                        ],
                      ),
                      Icon(
                        Icons.question_mark_rounded,
                        color: Colors.purple.shade700,
                        size: 26,
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
