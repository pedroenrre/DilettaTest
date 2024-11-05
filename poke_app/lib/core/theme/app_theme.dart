import 'package:flutter/material.dart';
import 'package:poke_app/core/constants/app_colors.dart';

ThemeData appTheme = ThemeData(
  appBarTheme: const AppBarTheme(
    backgroundColor: AppColors.darkBlue,
    titleTextStyle: TextStyle(
      color: Colors.white,
      fontSize: 20.0,
      fontWeight: FontWeight.bold,
    ),
    iconTheme: IconThemeData(
      color: Colors.white,
    ),
  ),
  scaffoldBackgroundColor: AppColors.background,
  useMaterial3: true,
  cardTheme: const CardTheme(
    color: Colors.white,
  ),
);
