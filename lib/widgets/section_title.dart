import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class SectionTitle extends StatelessWidget {
  const SectionTitle({
    super.key,
    required this.sectionTitle,
    required this.color,
    required this.howMuch,
    required this.numColor,
  });
  final String sectionTitle;
  final Color color;
  final Color numColor;
  final num howMuch;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Text(
          sectionTitle,
          style: GoogleFonts.poppins(fontSize: 25, fontWeight: FontWeight.w600),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8.0),
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 2),
            decoration: BoxDecoration(
                color: color.withOpacity(0.2),
                borderRadius: BorderRadius.circular(8)),
            child: Text(
              howMuch.toString(),
              style: GoogleFonts.poppins(
                  fontSize: 15, fontWeight: FontWeight.w600, color: numColor),
            ),
          ),
        )
      ],
    );
  }
}
