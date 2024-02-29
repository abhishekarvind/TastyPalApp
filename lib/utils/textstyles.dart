import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class CustomTextStyles {
  static head(String content, double? size) {
    return Text(
      content,
      style: GoogleFonts.manrope(
          color: Colors.black, fontSize: size, fontWeight: FontWeight.w900),
    );
  }

  static subtext(content, size, align) {
    return Text(
      content,
      style:
          GoogleFonts.manrope(color: const Color(0xff4F7396), fontSize: size),
      textAlign: align,
    );
  }
}
