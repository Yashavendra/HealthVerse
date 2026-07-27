import 'package:flutter/material.dart';
import 'router.dart';
import 'theme.dart';

class HealthVerseApp extends StatelessWidget {
  const HealthVerseApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      debugShowCheckedModeBanner: false,
      title: 'HealthVerse',
      theme: AppTheme.lightTheme,
      routerConfig: appRouter,
    );
  }
}