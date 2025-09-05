import 'package:flutter/material.dart';
import 'package:translator/screens%20/splash.dart';

void main() {
  runApp(const TranslatorApp());
}

class TranslatorApp extends StatelessWidget {
  const TranslatorApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'African Languages Translator',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        fontFamily: 'Inter',
        useMaterial3: true,
      ),
      home: LanguageSplashScreen(),
      debugShowCheckedModeBanner: false,
    );
  }
}

