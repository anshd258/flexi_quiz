import 'package:flexi_quiz/core/constants/colors.dart';
import 'package:flexi_quiz/core/theme/colorschema.dart';
import 'package:flexi_quiz/core/theme/texttheme.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AppTheme {
  static ThemeData lightTheme = ThemeData(
      colorScheme: Colorschema.colorSchema,
      //* textfield theme
      inputDecorationTheme: InputDecorationTheme(
          isDense: true,
          hintStyle: GoogleFonts.poppins(
              fontWeight: FontWeight.w500,
              color: AppColors.darkText,
              fontSize: 14),
          filled: true,
          fillColor: AppColors.surfaceColorLight,
          contentPadding:
              const EdgeInsets.symmetric(vertical: 6, horizontal: 8),
          enabledBorder: OutlineInputBorder(
              borderSide: const BorderSide(color: Colors.transparent),
              borderRadius: BorderRadius.circular(6))),
      //* elevated button global theme
      elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
        backgroundColor: AppColors.primaryColor,
        fixedSize: const Size.fromWidth(200),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      )),
      textTheme: Texttheme.textTheme);
}
