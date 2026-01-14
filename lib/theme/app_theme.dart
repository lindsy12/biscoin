import 'package:flutter/material.dart';

class AppTheme {
  static const Color primaryLilac = Color(0xFF8E7AFE);
  static const Color lightLilac = Color(0xFFEDE9FF);
  static const Color darkText = Color(0xFF333333);
  static const Color greyText = Color(0xFF6B6B6B);

  static ThemeData lightTheme = ThemeData(
    useMaterial3: true,

    // 🌸 App background
    scaffoldBackgroundColor: const Color(0xFFF7F6FB),

    // 🎨 Primary color
    colorScheme: ColorScheme.fromSeed(
      seedColor: primaryLilac,
      primary: primaryLilac,
    ),

    // 🧭 AppBar style
    appBarTheme: const AppBarTheme(
      backgroundColor: lightLilac,
      elevation: 0,
      centerTitle: true,
      titleTextStyle: TextStyle(
        color: greyText,
        fontSize: 22,
        fontWeight: FontWeight.w600,
        letterSpacing: 0.5,
      ),
      iconTheme: IconThemeData(color: greyText),
    ),

    // ✏️ Text fields
    inputDecorationTheme: InputDecorationTheme(
      filled: true,
      fillColor: Colors.white,
      contentPadding: const EdgeInsets.symmetric(
        horizontal: 16,
        vertical: 12,
      ),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(14),
        borderSide: BorderSide.none,
      ),
      hintStyle: const TextStyle(color: greyText),
    ),

    // 🔘 Buttons
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        backgroundColor: primaryLilac,
        foregroundColor: Colors.white,
        elevation: 0,
        padding: const EdgeInsets.symmetric(vertical: 14),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
        ),
        textStyle: const TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.w600,
        ),
      ),
    ),

    // 🧾 Cards
    cardTheme: CardThemeData(

      color: Colors.white,
      elevation: 3,
      shadowColor: Colors.black12,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
      margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 4),
    ),

    // 🅰 Text styles
    textTheme: const TextTheme(
      headlineMedium: TextStyle(
        fontSize: 24,
        fontWeight: FontWeight.bold,
        color: darkText,
      ),
      bodyMedium: TextStyle(
        fontSize: 16,
        color: darkText,
      ),
      bodySmall: TextStyle(
        fontSize: 14,
        color: greyText,
      ),
    ),
  );
}
