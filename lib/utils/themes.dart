import 'package:flutter/material.dart';
import 'constants.dart';

class AppThemes {

  static ThemeData lightTheme = ThemeData(

    useMaterial3: true,

    primaryColor: AppColors.primary,

    scaffoldBackgroundColor: const Color(0xFFF5F7FA),

    fontFamily: 'Roboto',

    colorScheme: ColorScheme.fromSeed(
      seedColor: AppColors.primary,
    ),

    appBarTheme: const AppBarTheme(
      backgroundColor: AppColors.primary,
      foregroundColor: Colors.white,
      elevation: 0,
      centerTitle: true,
    ),

    elevatedButtonTheme:
    ElevatedButtonThemeData(

      style: ElevatedButton.styleFrom(

        backgroundColor: AppColors.primary,

        foregroundColor: Colors.white,

        padding: const EdgeInsets.symmetric(
          vertical: 16,
        ),

        shape: RoundedRectangleBorder(
          borderRadius:
          BorderRadius.circular(14),
        ),
      ),
    ),

    inputDecorationTheme:
    InputDecorationTheme(

      filled: true,

      fillColor: Colors.white,

      contentPadding:
      const EdgeInsets.symmetric(
        horizontal: 20,
        vertical: 18,
      ),

      border: OutlineInputBorder(
        borderRadius:
        BorderRadius.circular(14),

        borderSide: BorderSide.none,
      ),

      enabledBorder: OutlineInputBorder(
        borderRadius:
        BorderRadius.circular(14),

        borderSide: BorderSide.none,
      ),

      focusedBorder: OutlineInputBorder(
        borderRadius:
        BorderRadius.circular(14),

        borderSide: const BorderSide(
          color: AppColors.primary,
          width: 2,
        ),
      ),
    ),

    cardTheme: CardThemeData(
      elevation: 3,
      shadowColor: Colors.black12,

      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(18),
      ),
    ),
  );
}