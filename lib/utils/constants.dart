import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

const kRoseColor = Color(0xfff778ba);
final kPurpleColor = const Color.fromARGB(255, 141, 107, 235).withOpacity(0.7);

final kProjectNameFontStyle = GoogleFonts.poppins(
    fontSize: 16,
    color: Colors.black.withOpacity(0.5),
    fontWeight: FontWeight.w400);

TextStyle kTaskNameFontStyle(
    {Color color = Colors.black,
    double fontSize = 22,
    FontWeight fontWeight = FontWeight.w500}) {
  return GoogleFonts.poppins(
      fontSize: fontSize, fontWeight: fontWeight, color: color);
}
