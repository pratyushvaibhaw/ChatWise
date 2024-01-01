import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

googleaBeeZee(Color color,double size,FontWeight fw,{double spacing=3,Shadow sh= const Shadow()}) {
  return GoogleFonts.aBeeZee(
    shadows: [
     sh
    ],
    letterSpacing: spacing,
    color: color,
    fontWeight: fw,
    fontSize: size,
  );
}
