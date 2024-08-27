import 'package:flutter/material.dart';
import 'package:todo_demo_app/utils/app_color.dart';

ThemeData appTheme() {
  return ThemeData(
    fontFamily: 'Roboto',
    useMaterial3: false,
    appBarTheme: const AppBarTheme(
      titleTextStyle: TextStyle(
        fontSize: 17,
        fontWeight: FontWeight.w800,
        color: AppColors.black,
      ),
      backgroundColor: AppColors.primary,
      elevation: 1,
      iconTheme: IconThemeData(
        color: AppColors.black,
      ),
    ),
    primaryColor: AppColors.primary,
    scaffoldBackgroundColor: AppColors.background,
    textTheme: const TextTheme(
      labelLarge: TextStyle(
        fontSize: 14,
        color: AppColors.white,
        fontWeight: FontWeight.w500,
      ),
    ),
    textButtonTheme: const TextButtonThemeData(
      style: ButtonStyle(
        textStyle: WidgetStatePropertyAll(
          TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w500,
            color: AppColors.primary,
          ),
        ),
      ),
    ),
  );
}
