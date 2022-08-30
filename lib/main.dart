import 'package:flutter/material.dart';
import 'package:glossary/screens/home_screen.dart';
import 'package:glossary/globals.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      scaffoldMessengerKey: snackbarKey,
      debugShowCheckedModeBanner: false,
      title: 'Glossary',
      theme: ThemeData(primarySwatch: Colors.purple),
      home: const SafeArea(child: HomeScreen()),
    );
  }
}
