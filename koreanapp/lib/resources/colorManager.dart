import 'package:flutter/material.dart';

class ColorManager {
  static Color primary = HexColor.fromHex("#F9EDED");
  static Color onboardingCircle = HexColor.fromHex("#C5BAEF");
  static Color onboardingCircleoverlap = HexColor.fromHex("#b0a4de");
  static Color white = HexColor.fromHex("#FFFFFF");
  static Color appbarColor = HexColor.fromHex("#6760cb");
}



extension HexColor on Color {
  static Color fromHex(String hexColorString) {
    hexColorString = hexColorString.replaceAll('#', '');
    if (hexColorString.length == 6) {
      hexColorString = "FF$hexColorString"; // 8 char with opacity 100%
    }
    return Color(int.parse(hexColorString, radix: 16));
  }
}
