import 'package:flutter/material.dart';

class ColorPickerModel {
  final Color color;
  final double opacity;
  final double gradient;

  ColorPickerModel(
      {required this.color, required this.opacity, required this.gradient});

  @override
  String toString() =>
      "ColorPickerModel(color: $color, opacity: $opacity, gradient: $gradient)";

  ColorPickerModel copyWith({
    Color? color,
    double? opacity,
    double? gradient,
  }) {
    return ColorPickerModel(
      color: color ?? this.color,
      opacity: opacity ?? this.opacity,
      gradient: gradient ?? this.gradient,
    );
  }
}
