import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AppTheme {
  // Custom light color scheme
  static final _lightColors = ColorScheme.fromSeed(
    seedColor: Colors.teal,
    brightness: Brightness.light,
  ).copyWith(
    primary: Colors.teal.shade600,
    secondary: Colors.orangeAccent,
    surface: Colors.white,
  );

  // Custom dark color scheme
  static final _darkColors = ColorScheme.fromSeed(
    seedColor: Colors.teal,
    brightness: Brightness.dark,
  ).copyWith(
    primary: Colors.tealAccent.shade200,
    secondary: Colors.deepOrangeAccent,
    surface: const Color(0xFF1E1E1E),
  );

  // Typography with Google Fonts
  static final _textTheme = GoogleFonts.poppinsTextTheme().copyWith(
    titleLarge: GoogleFonts.poppins(
      fontSize: 22,
      fontWeight: FontWeight.w600,
    ),
    titleMedium: GoogleFonts.poppins(
      fontSize: 18,
      fontWeight: FontWeight.w500,
    ),
    bodyLarge: GoogleFonts.poppins(
      fontSize: 16,
      fontWeight: FontWeight.w400,
    ),
    bodyMedium: GoogleFonts.poppins(
      fontSize: 14,
      color: Colors.grey.shade700,
    ),
    labelLarge: GoogleFonts.poppins(
      fontSize: 14,
      fontWeight: FontWeight.w500,
      letterSpacing: 0.5,
    ),
  );

  // Light Theme
  static ThemeData get light => ThemeData(
        useMaterial3: true,
        colorScheme: _lightColors,
        textTheme: _textTheme,
        appBarTheme: AppBarTheme(
          backgroundColor: _lightColors.primary,
          foregroundColor: Colors.white,
          centerTitle: true,
          elevation: 3,
          titleTextStyle: GoogleFonts.poppins(
            fontSize: 20,
            fontWeight: FontWeight.w600,
            color: Colors.white,
          ),
        ),
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            backgroundColor: _lightColors.primary,
            foregroundColor: Colors.white,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(14),
            ),
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 14),
            elevation: 3,
          ),
        ),
        cardTheme: CardTheme(
          color: _lightColors.surface,
          elevation: 2,
          margin: const EdgeInsets.all(8),
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        ),
        inputDecorationTheme: InputDecorationTheme(
          filled: true,
          fillColor: Colors.grey.shade100,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: BorderSide.none,
          ),
          hintStyle: TextStyle(color: Colors.grey.shade500),
        ),
      );

  // Dark Theme
  static ThemeData get dark => ThemeData(
        useMaterial3: true,
        colorScheme: _darkColors,
        textTheme: _textTheme.apply(bodyColor: Colors.white),
        appBarTheme: AppBarTheme(
          backgroundColor: _darkColors.surface,
          foregroundColor: Colors.white,
          centerTitle: true,
          elevation: 0,
          titleTextStyle: GoogleFonts.poppins(
            fontSize: 20,
            fontWeight: FontWeight.w600,
            color: Colors.white,
          ),
        ),
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            backgroundColor: _darkColors.primary,
            foregroundColor: Colors.black,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(14),
            ),
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 14),
            elevation: 2,
          ),
        ),
        cardTheme: CardTheme(
          color: _darkColors.surface,
          elevation: 1,
          margin: const EdgeInsets.all(8),
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        ),
        inputDecorationTheme: InputDecorationTheme(
          filled: true,
          fillColor: Colors.grey.shade800,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: BorderSide.none,
          ),
          hintStyle: TextStyle(color: Colors.grey.shade400),
        ),
      );
}
