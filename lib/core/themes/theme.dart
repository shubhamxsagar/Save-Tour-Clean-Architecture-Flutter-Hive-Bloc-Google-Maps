import 'package:arpan/core/themes/app_pallete.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class AppTheme {
  static _border([Color color = AppPallete.borderColor]) => OutlineInputBorder(
        borderSide: BorderSide(
          color: color,
          width: 3,
        ),
        borderRadius: BorderRadius.circular(10),
      );
  static final lightThemeMode = ThemeData.light().copyWith(
    scaffoldBackgroundColor: AppPallete.whiteColor,
    appBarTheme: AppBarTheme(
      backgroundColor: AppPallete.whiteColor,
      systemOverlayStyle: SystemUiOverlayStyle.light,
      
    ),
    chipTheme: ChipThemeData(
      color: MaterialStatePropertyAll(
        AppPallete.whiteColor,
      ),
      side: BorderSide.none,
    ),
    inputDecorationTheme: InputDecorationTheme(
      contentPadding: const EdgeInsets.all(27),
      border: _border(),
      enabledBorder: _border(),
      focusedBorder: _border(AppPallete.gradient2!),
      errorBorder: _border(AppPallete.errorColor),
    ),
  );
}
