import 'package:flutter/material.dart';

class Globals {
  static double blockHeight;
  static double blockWidth;
  static Color mainColor = Color(0xfff5c22f);

  static addBlockHeightAndWidth(double height, double width) {
    blockHeight = height;
    blockWidth = width;
  }
}
