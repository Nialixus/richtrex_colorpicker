import 'package:flutter/material.dart';

class ColorPickerModel {
  final Color color;
  final double opacity;
  final double gradient;
  final Color output;

  ColorPickerModel(
      {required this.color, required this.opacity, required this.gradient})
      : output = (gradient < 0.5
                ? Color.lerp(Colors.black, color, gradient * 2)!
                : gradient > 0.5
                    ? Color.lerp(color, Colors.white, (gradient - 0.5) * 2)!
                    : color)
            .withOpacity(opacity);

  @override
  String toString() =>
      "ColorPickerModel(color: $color, opacity: $opacity, gradient: $gradient)";
}
