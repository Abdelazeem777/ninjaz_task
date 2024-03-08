import 'package:flutter/material.dart';

abstract class AppColors {
  static const PRIMARY_COLOR = Color(0xFF583B8A);
  static const SECONDARY_COLOR = Color(0xFFFFDA04);
  static const ACCENT_COLOR = Color(0xFF08201F);
  static const GREY_LIGHT_COLOR = Color(0xFFE2E2E2);
  static const GREY_NORMAL_COLOR = Color(0xFFB9B9B9);
  static const GREY_DARK_COLOR = Color(0xFF707070);

  static const TEXT_LIGHT = Color(0xFFFFFFFF);
  static const TEXT_DARK = Color(0xFF000000);

  static const SHADOW = [
    BoxShadow(
      color: Color(0x99000000),
      spreadRadius: 0.03,
      blurRadius: 6,
    ),
  ];

  static const SHADOW_LIGHT = [
    BoxShadow(
      color: Color(0x44000000),
      spreadRadius: 0.03,
      blurRadius: 6,
    ),
  ];
}
