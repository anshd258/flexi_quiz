import 'package:flexi_quiz/core/constants/colors.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

abstract class Texttheme {
 static final  textTheme =  TextTheme(
          labelMedium:
              GoogleFonts.poppins(fontWeight: FontWeight.w500, fontSize: 16),
          titleMedium:
              GoogleFonts.poppins(fontWeight: FontWeight.bold, fontSize: 24),
          titleSmall:
              GoogleFonts.poppins(fontWeight: FontWeight.bold, fontSize: 18),
          bodyMedium:
              GoogleFonts.poppins(fontWeight: FontWeight.w700, fontSize: 16),
          bodySmall:
              GoogleFonts.poppins(fontWeight: FontWeight.w500, fontSize: 14),
          labelSmall: GoogleFonts.poppins(
              fontSize: 10, fontWeight: FontWeight.normal, color: AppColors.grayText));
}