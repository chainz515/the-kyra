import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';

class AppTheme {
  AppTheme._();

  // Brand colors
  static const _greenLight = Color(0xFF2E7D32);
  static const _accent = Color(0xFFF57C00);
  static const _felt = Color(0xFF1A3320);
  static const _feltDark = Color(0xFF0D1F13);

  static ThemeData get light {
    final cs = ColorScheme.fromSeed(
      seedColor: _greenLight,
      brightness: Brightness.light,
      primary: _greenLight,
      secondary: _accent,
      surface: const Color(0xFFF5F5F5),
    );
    return _base(cs).copyWith(
      scaffoldBackgroundColor: const Color(0xFFF0F4F0),
      appBarTheme: AppBarTheme(
        backgroundColor: _greenLight,
        foregroundColor: Colors.white,
        elevation: 0,
        systemOverlayStyle: SystemUiOverlayStyle.light,
        titleTextStyle: GoogleFonts.outfit(
          fontSize: 20,
          fontWeight: FontWeight.w700,
          color: Colors.white,
        ),
      ),
    );
  }

  static ThemeData get dark {
    final cs = ColorScheme.fromSeed(
      seedColor: _greenLight,
      brightness: Brightness.dark,
      primary: const Color(0xFF66BB6A),
      secondary: const Color(0xFFFFB74D),
      surface: const Color(0xFF1C2A1E),
      onSurface: Colors.white,
    );
    return _base(cs).copyWith(
      scaffoldBackgroundColor: _feltDark,
      appBarTheme: AppBarTheme(
        backgroundColor: _felt,
        foregroundColor: Colors.white,
        elevation: 0,
        systemOverlayStyle: SystemUiOverlayStyle.light,
        titleTextStyle: GoogleFonts.outfit(
          fontSize: 20,
          fontWeight: FontWeight.w700,
          color: Colors.white,
        ),
      ),
    );
  }

  static ThemeData _base(ColorScheme cs) => ThemeData(
        useMaterial3: true,
        colorScheme: cs,
        textTheme: GoogleFonts.outfitTextTheme(
          cs.brightness == Brightness.light
              ? ThemeData.light().textTheme
              : ThemeData.dark().textTheme,
        ),
        cardTheme: CardThemeData(
          elevation: 2,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
          margin: const EdgeInsets.symmetric(vertical: 4, horizontal: 0),
        ),
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12)),
            padding:
                const EdgeInsets.symmetric(horizontal: 24, vertical: 14),
            textStyle: GoogleFonts.outfit(
                fontSize: 15, fontWeight: FontWeight.w600),
          ),
        ),
        filledButtonTheme: FilledButtonThemeData(
          style: FilledButton.styleFrom(
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12)),
            padding:
                const EdgeInsets.symmetric(horizontal: 20, vertical: 14),
            textStyle: GoogleFonts.outfit(
                fontSize: 14, fontWeight: FontWeight.w600),
          ),
        ),
        inputDecorationTheme: InputDecorationTheme(
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          filled: true,
        ),
      );
}
