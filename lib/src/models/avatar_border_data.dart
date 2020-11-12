import 'package:flutter/material.dart';

class AvatarBorderData {
  final double borderWidth;
  final Color borderColor;

  /// [borderWidth] use this to set the border thickness, default is 0.0.
  /// [borderColor] use this to set the border color, default is transparent color.
  AvatarBorderData(
      {this.borderWidth = 0.0, this.borderColor = Colors.transparent});
}
