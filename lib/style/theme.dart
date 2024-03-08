import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'app_colors.dart';

final theme = ThemeData(
  textTheme: TextTheme(
    bodySmall: _normalText(14.0),
    bodyMedium: _normalText(16.0),
    bodyLarge: _normalText(18.0),
    headlineSmall: _boldText(16.0),
    headlineMedium: _boldText(18.0),
    headlineLarge: _boldText(21.0),
  ),
  appBarTheme: const AppBarTheme(
    systemOverlayStyle: SystemUiOverlayStyle(
      systemNavigationBarIconBrightness: Brightness.dark,
      statusBarIconBrightness: Brightness.dark,
    ),
  ),
  iconTheme: const IconThemeData(color: Colors.white),
  colorScheme: const ColorScheme.light(primary: Colors.white),
  radioTheme: RadioThemeData(
    overlayColor: MaterialStateColor.resolveWith(
      (states) => AppColors.GREY_NORMAL_COLOR,
    ),
    fillColor: MaterialStateColor.resolveWith(
      (states) => AppColors.PRIMARY_COLOR,
    ),
  ),
);

TextStyle _boldText(double size) {
  return TextStyle(
    color: AppColors.TEXT_DARK,
    fontWeight: FontWeight.bold,
    fontSize: size,
  );
}

TextStyle _normalText(double size) {
  return TextStyle(
    color: AppColors.TEXT_DARK,
    fontWeight: FontWeight.w400,
    fontSize: size,
  );
}

const navbarHeight = 100.0;
