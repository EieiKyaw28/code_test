import 'package:flutter/material.dart';

final colorScheme = ColorScheme.fromSeed(
  seedColor: const Color(0xFFFFE142),
  brightness: Brightness.light,
  primary: const Color(0xFFFFE142),
  onPrimary: Colors.black,
  surface: Colors.white,
  onSurface: Colors.black,
);

final appTextTheme = TextTheme(
  headlineLarge: TextStyle(
      fontSize: 28, fontWeight: FontWeight.bold, color: colorScheme.onPrimary),
  titleMedium: TextStyle(fontSize: 20, color: colorScheme.onSurface),
  bodyLarge: TextStyle(
      fontSize: 18, fontWeight: FontWeight.bold, color: colorScheme.surface),
  bodyMedium: TextStyle(fontSize: 14, color: colorScheme.surface),
  labelMedium: const TextStyle(color: Colors.black54),
);

final appTheme = ThemeData(
  colorScheme: colorScheme,
  textTheme: appTextTheme,
  scaffoldBackgroundColor: colorScheme.primary,
  appBarTheme: AppBarTheme(
    backgroundColor: colorScheme.primary,
    foregroundColor: colorScheme.onPrimary,
    elevation: 0,
  ),
  iconTheme: IconThemeData(color: colorScheme.onPrimary),
  useMaterial3: true,
);

