import 'package:flutter/material.dart';

class AppTheme {
  static const Color ink = Color(0xFF111827);
  static const Color paper = Color(0xFFF7F8FB);
  static const Color night = Color(0xFF0E1117);
  static const Color mint = Color(0xFF2DD4BF);
  static const Color coral = Color(0xFFFF7A59);
  static const Color violet = Color(0xFF8B5CF6);
  static const Color sky = Color(0xFF38BDF8);

  static ThemeData get light {
    final base = ThemeData(
      useMaterial3: true,
      brightness: Brightness.light,
      fontFamily: 'Inter',
      colorScheme: ColorScheme.fromSeed(
        seedColor: mint,
        brightness: Brightness.light,
        primary: const Color(0xFF0F766E),
        secondary: coral,
        surface: Colors.white,
      ),
    );

    return base.copyWith(
      scaffoldBackgroundColor: paper,
      textTheme: _textTheme(base.textTheme, ink),
      dividerColor: const Color(0xFFE5E7EB),
      cardColor: Colors.white.withValues(alpha: .76),
    );
  }

  static ThemeData get dark {
    final base = ThemeData(
      useMaterial3: true,
      brightness: Brightness.dark,
      fontFamily: 'Inter',
      colorScheme: ColorScheme.fromSeed(
        seedColor: mint,
        brightness: Brightness.dark,
        primary: mint,
        secondary: coral,
        surface: const Color(0xFF151922),
      ),
    );

    return base.copyWith(
      scaffoldBackgroundColor: night,
      textTheme: _textTheme(base.textTheme, Colors.white),
      dividerColor: Colors.white.withValues(alpha: .10),
      cardColor: Colors.white.withValues(alpha: .08),
    );
  }

  static TextTheme _textTheme(TextTheme base, Color color) {
    return base.copyWith(
      displayLarge: base.displayLarge?.copyWith(
        fontSize: 72,
        height: .98,
        fontWeight: FontWeight.w800,
        letterSpacing: 0,
        color: color,
      ),
      displayMedium: base.displayMedium?.copyWith(
        fontSize: 48,
        height: 1.05,
        fontWeight: FontWeight.w800,
        letterSpacing: 0,
        color: color,
      ),
      headlineMedium: base.headlineMedium?.copyWith(
        fontSize: 30,
        height: 1.15,
        fontWeight: FontWeight.w800,
        letterSpacing: 0,
        color: color,
      ),
      titleLarge: base.titleLarge?.copyWith(
        fontSize: 22,
        height: 1.25,
        fontWeight: FontWeight.w700,
        letterSpacing: 0,
        color: color,
      ),
      bodyLarge: base.bodyLarge?.copyWith(
        fontSize: 17,
        height: 1.65,
        letterSpacing: 0,
        color: color.withValues(alpha: .78),
      ),
      bodyMedium: base.bodyMedium?.copyWith(
        fontSize: 15,
        height: 1.55,
        letterSpacing: 0,
        color: color.withValues(alpha: .70),
      ),
      labelLarge: base.labelLarge?.copyWith(
        fontSize: 14,
        fontWeight: FontWeight.w700,
        letterSpacing: 0,
      ),
    );
  }
}
