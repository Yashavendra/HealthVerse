import 'package:flutter/material.dart';

void main() {
  runApp(const HealthVerseApp());
}

class HealthVerseApp extends StatelessWidget {
  const HealthVerseApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'HealthVerse',
      home: Scaffold(
        appBar: AppBar(
          title: const Text("HealthVerse"),
          centerTitle: true,
        ),
        body: const Center(
          child: Text(
            "Welcome to HealthVerse 🚀",
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ),
    );
  }
}