import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class CustomButton {
  static button(text, color1, color2, void Function()? function) {
    return Center(
      child: SizedBox(
          width: 241,
          height: 50,
          child: ElevatedButton(
              onPressed: function,
              style: ElevatedButton.styleFrom(
                  backgroundColor: color1,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30))),
              child: Text(
                text,
                style: GoogleFonts.manrope(
                    color: color2, fontWeight: FontWeight.bold),
              ))),
    );
  }
}
