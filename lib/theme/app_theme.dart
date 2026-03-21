import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AppColors {
  // Palette professionnelle assurance
  static const Color primary = Color(0xFF1B3A5C);       // Bleu marine profond
  static const Color primaryLight = Color(0xFF2A5298);   // Bleu royal
  static const Color accent = Color(0xFFE8A838);         // Or / Ambre
  static const Color accentLight = Color(0xFFFFC857);    // Or clair
  static const Color background = Color(0xFFF8F9FC);     // Gris très clair
  static const Color surface = Colors.white;
  static const Color textPrimary = Color(0xFF1A1A2E);
  static const Color textSecondary = Color(0xFF6B7280);
  static const Color success = Color(0xFF10B981);
  static const Color gradient1 = Color(0xFF1B3A5C);
  static const Color gradient2 = Color(0xFF2A5298);
  static const Color gradient3 = Color(0xFF3B82F6);

  // Dark mode colors
  static const Color darkBackground = Color(0xFF0F172A);  // Slate 900
  static const Color darkSurface = Color(0xFF1E293B);    // Slate 800
  static const Color darkTextPrimary = Colors.white;
  static const Color darkTextSecondary = Color(0xFF94A3B8); // Slate 400
}

class AppTheme {
  static ThemeData get lightTheme {
    return ThemeData(
      useMaterial3: true,
      colorScheme: ColorScheme.fromSeed(
        seedColor: AppColors.primary,
        brightness: Brightness.light,
      ),
      textTheme: GoogleFonts.interTextTheme(),
      scaffoldBackgroundColor: AppColors.background,
    );
  }

  static ThemeData get darkTheme {
    return ThemeData(
      useMaterial3: true,
      colorScheme: ColorScheme.fromSeed(
        seedColor: AppColors.primary,
        brightness: Brightness.dark,
      ),
      textTheme: GoogleFonts.interTextTheme().apply(
        bodyColor: AppColors.darkTextPrimary,
        displayColor: AppColors.darkTextPrimary,
      ),
      scaffoldBackgroundColor: AppColors.darkBackground,
    );
  }
}
