import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

var radius = BorderRadius.circular(25.r);
var horizontalPadding = 20.w;
var verticalPadding = 10.h;

/// Colors
Color primary = const Color(0xFFE4BB49);
Color onPrimary = const Color(0xFFAB7D01);
Color borderFieldGrey = const Color(0xff787878);
Color textGrey = const Color(0xFF6A707C);
Color hintColor = const Color(0xFF8391A1);
Color textBlack = const Color(0xFF1E232C);
Color buttonBgColor = const Color(0xFF35310C);
Color red = const Color(0xFFD9001B);
Color blue = const Color(0xFF0000FF);
Color fillFieldColor = const Color(0xFFF7F8F9);
Color iconFieldColor = const Color(0xFF4D4D4D);
Color white = Colors.white;

LinearGradient gradientPrimary = LinearGradient(
  begin: Alignment.topCenter,
  end: Alignment.bottomCenter,
  colors: [primary, onPrimary],
);

LinearGradient btnGradient = LinearGradient(
  begin: Alignment.topCenter,
  end: Alignment.bottomCenter,
  colors: [buttonBgColor, buttonBgColor],
);
