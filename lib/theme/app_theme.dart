// theme/app_theme.dart
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final themeProvider = Provider<AppTheme>((ref) => AppTheme());

class AppTheme {
  final ThemeData lightTheme = ThemeData(
    primarySwatch: Colors.teal,
    textTheme: const TextTheme(
      displayLarge: TextStyle(fontSize: 72, fontWeight: FontWeight.bold),
      titleLarge: TextStyle(fontSize: 36, color: Colors.black87),
      bodyMedium: TextStyle(fontSize: 16, height: 1.5),
    ),
    visualDensity: VisualDensity.adaptivePlatformDensity,
  );

  final ThemeData darkTheme = ThemeData.dark().copyWith(
    primaryColor: Colors.teal,
    textTheme: const TextTheme(
      displayLarge: TextStyle(fontSize: 72, fontWeight: FontWeight.bold),
      titleLarge: TextStyle(fontSize: 36, color: Colors.white),
      bodyMedium: TextStyle(fontSize: 16, height: 1.5),
    ),
  );
}
