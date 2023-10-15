import 'package:flutter/material.dart';

class ColorManager {
  static Color primary = HexColor.fromHex("#F9EDED");
  static Color onboardingCircle = HexColor.fromHex("#C5BAEF");
  static Color onboardingCircleoverlap = HexColor.fromHex("#b0a4de");
  static Color white = HexColor.fromHex("#FFFFFF");
  static Color black = HexColor.fromHex("#000000");
  static Color appbarColor = HexColor.fromHex("#6760cb");
  static Color dashboardTitleColor = HexColor.fromHex("#0d094d");

  static Color grammarbox = Color.fromARGB(218, 204, 193, 231);
  // rgba(218, 216, 255, 1);
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
