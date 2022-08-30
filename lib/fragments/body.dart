import 'package:flutter/material.dart';
import 'package:glossary/entities/glossary.dart';
import 'package:google_fonts/google_fonts.dart';

class Body extends StatefulWidget {
  final Map<String, double> size;
  final List<Glossary> glossaries;

  Body({
    Key? key,
    required this.size,
    required this.glossaries,
  }) : super(key: key);

  @override
  State<Body> createState() => _BodyState();
}

class _BodyState extends State<Body> {
  late List<Glossary> _glossaries;

  @override
  void initState() {
    setState(() {
      _glossaries = widget.glossaries;
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(right: 30.0, left: 30.0, bottom: 10.0),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(
            height: 60,
          ),
          Text(
            'Glosari Falsafah',
            style: GoogleFonts.openSans(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: Colors.purple.shade900),
          ),
          const SizedBox(
            height: 13,
          ),
          Flexible(
            fit: FlexFit.loose,
            child: SizedBox(
              height: 300,
              child: ListView.builder(
                physics: const BouncingScrollPhysics(),
                itemBuilder: (context, index) {
                  return ListTile(
                    trailing: const Icon(
                      Icons.navigate_next,
                      size: 16,
                    ),
                    title: Text(
                      _glossaries[index].term,
                      style: GoogleFonts.openSans(
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    subtitle: Text(
                      _glossaries[index].definition,
                      maxLines: 2,
                      style: GoogleFonts.openSans(),
                    ),
                    minVerticalPadding: 10.0,
                    onTap: () {
                      showModalBottomSheet<void>(
                          context: context,
                          builder: (BuildContext context) {
                            return Container(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 25),
                              height: 250,
                              color: Colors.white,
                              child: Column(
                                mainAxisSize: MainAxisSize.min,
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: <Widget>[
                                  Text(
                                    _glossaries[index].term,
                                    style: GoogleFonts.openSans(
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  Text(
                                    _glossaries[index].definition,
                                    style: GoogleFonts.openSans(),
                                  ),
                                  ElevatedButton(
                                    style: ButtonStyle(
                                      backgroundColor:
                                          MaterialStateColor.resolveWith(
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
                  );
                },
                itemCount: _glossaries.length,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
