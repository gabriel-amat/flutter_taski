import 'package:flutter/material.dart';

class AppTheme {
  static double defaultBorder = 20.0;

  static final theme = ThemeData(
    colorScheme: ColorScheme.fromSeed(
      seedColor: Colors.blueAccent,
    ),
    inputDecorationTheme: InputDecorationTheme(
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(defaultBorder),
      ),
    ),
  );
}
