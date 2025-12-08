// lib/main.dart
import 'package:flutter/material.dart';
import 'package:flutter_gemini/flutter_gemini.dart';
import 'app.dart';



void main() {
  Gemini.init(apiKey:'AIzaSyAn8e0voES4ltGeuOSK78Th5f79BdAfahA'); 
  runApp(const VerdantViewApp());
}

class VerdantViewApp extends StatelessWidget {
  const VerdantViewApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Verdant View',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.green,
        scaffoldBackgroundColor: const Color(0xFFF8F9F8),
        fontFamily: 'Inter',
        appBarTheme: const AppBarTheme(
          backgroundColor: Colors.white,
          elevation: 0,
          centerTitle: false,
        ),
      ),
      home: SafeArea(child: const App()),
    );
  }
}