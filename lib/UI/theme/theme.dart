import 'package:flutter/material.dart';

ThemeData lightMode = ThemeData(
  brightness: Brightness.light,
  primaryColor: Colors.red,
  colorScheme: ColorScheme.fromSeed(seedColor: Colors.white,background: Colors.grey[200], secondary: Colors.grey[350], onSecondary: Colors.grey[600]),
  textTheme: const TextTheme(displayMedium: TextStyle(color: Colors.black87)),
  useMaterial3: true,
);

ThemeData darkMode = ThemeData(
  brightness: Brightness.light,
  primaryColor: Colors.red,
  textTheme: const TextTheme(displayMedium: TextStyle(color: Colors.white)),
  colorScheme: ColorScheme.fromSeed(background: Colors.grey[900], seedColor: Colors.black, secondary: Colors.grey[700],onSecondary: Colors.grey[100]),
  useMaterial3: true,
);
