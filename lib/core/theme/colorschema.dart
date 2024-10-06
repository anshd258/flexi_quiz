import 'package:flexi_quiz/core/constants/colors.dart';
import 'package:flutter/material.dart';

abstract class Colorschema{
  static final  colorSchema = ColorScheme(
        brightness: Brightness.light,
        primary: AppColors.primaryColor,
        onPrimary: AppColors.surfaceColorLight.withOpacity(0.3),
        secondary: AppColors.surfaceColorLight,
        onSecondary: AppColors.surfaceColorLight,
        error: AppColors.errorColor,
        onError: AppColors.errorColor.withOpacity(0.3),
        surface: AppColors.backgroundColorLight,
        onSurface: AppColors.darkText,
      );
}