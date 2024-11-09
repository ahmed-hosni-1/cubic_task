import 'package:cubic_task/core/theme/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AppTheme {
  static ThemeData lightTheme = ThemeData(
      fontFamily: GoogleFonts.cairo().fontFamily,
      useMaterial3: false,
      scaffoldBackgroundColor: AppColors.instance.backgroundColor,
      primaryColor: AppColors.instance.primaryColor,
      colorScheme: ColorScheme.light(
        primary: AppColors.instance.primaryColor,
        secondary: AppColors.instance.secondaryColor,
      ),
      appBarTheme: AppBarTheme(
          backgroundColor: AppColors.instance.primaryColor, centerTitle: true),
      textTheme: TextTheme(
        bodySmall: GoogleFonts.cairo(
          fontSize: 14,
          fontWeight: FontWeight.w400,
          color: AppColors.instance.primaryColor,
        ),
        bodyMedium: GoogleFonts.cairo(
          fontSize: 16,
          fontWeight: FontWeight.w400,
          color: AppColors.instance.primaryColor,
        ),
        bodyLarge: GoogleFonts.cairo(
          fontSize: 18,
          fontWeight: FontWeight.w400,
          color: AppColors.instance.primaryColor,
        ),
      ));
}
