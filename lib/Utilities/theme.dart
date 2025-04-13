import 'package:flutter/material.dart';

ThemeData lightTheme() {
  return ThemeData(
    colorScheme: ColorScheme.fromSeed(
      seedColor: Colors.blueAccent,
      brightness: Brightness.light,
      ),
      textTheme: const TextTheme(
        displayLarge: TextStyle(fontSize: 32, fontWeight: FontWeight.bold),
        bodyLarge: TextStyle(fontSize: 18),
      ),
  );
}

ThemeData darkTheme() {
  return ThemeData(
    colorScheme: ColorScheme.fromSeed(
      seedColor: Colors.blueAccent,
      brightness: Brightness.dark,
    ),
    textTheme: const TextTheme(
      displayLarge: TextStyle(fontSize: 32, fontWeight: FontWeight.bold),
      bodyLarge: TextStyle(fontSize: 18),
    ),
  );
}

ThemeData rusticTheme() {
  return ThemeData(
    colorScheme: ColorScheme.fromSeed(
      seedColor: Colors.brown,
      brightness: Brightness.light,
    ).copyWith(
      primary: Colors.brown,
      secondary: Colors.orangeAccent,
      surface: Colors.brown.shade100, // Replacing background
    ),
    textTheme: const TextTheme(
      displayLarge: TextStyle(fontSize: 32, fontWeight: FontWeight.bold, color: Colors.brown),
      bodyLarge: TextStyle(fontSize: 18, color: Colors.black87),
    ),
    appBarTheme: const AppBarTheme(
      backgroundColor: Colors.brown,
      foregroundColor: Colors.white,
    ),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        backgroundColor: Colors.orangeAccent,
        foregroundColor: Colors.white,
      ),
    ),
  );
}

ThemeData pinkTheme() {
  return ThemeData(
    colorScheme: ColorScheme.fromSeed(
      seedColor: Colors.pink,
      brightness: Brightness.light,
    ).copyWith(
      primary: Colors.pinkAccent,
      secondary: Colors.deepPurpleAccent,
      surface: Colors.pink.shade50, // Replacing background
    ),
    textTheme: const TextTheme(
      displayLarge: TextStyle(fontSize: 32, fontWeight: FontWeight.bold, color: Colors.pink),
      bodyLarge: TextStyle(fontSize: 18, color: Colors.black),
    ),
    appBarTheme: const AppBarTheme(
      backgroundColor: Colors.pinkAccent,
      foregroundColor: Colors.white,
    ),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        backgroundColor: Colors.pink,
        foregroundColor: Colors.white,
      ),
    ),
  );
}

ThemeData modernTheme() {
  return ThemeData(
    colorScheme: ColorScheme.fromSeed(
      seedColor: Colors.blueGrey,
      brightness: Brightness.dark,
    ).copyWith(
      primary: Colors.blueGrey,
      secondary: Colors.tealAccent,
      surface: Colors.blueGrey.shade900, // Replacing background
    ),
    textTheme: const TextTheme(
      displayLarge: TextStyle(fontSize: 32, fontWeight: FontWeight.bold, color: Colors.white),
      bodyLarge: TextStyle(fontSize: 18, color: Colors.white70),
    ),
    appBarTheme: const AppBarTheme(
      backgroundColor: Colors.black,
      foregroundColor: Colors.white,
    ),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        backgroundColor: Colors.tealAccent,
        foregroundColor: Colors.black,
      ),
    ),
  );
}