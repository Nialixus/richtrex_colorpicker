import 'package:flutter/material.dart';
import 'colorpicker_model.dart';

class ColorPickerState with ChangeNotifier {
  ColorPickerState({required Color color})
      : model = ColorPickerModel(
            color: color, opacity: color.opacity, gradient: 0.5);
  ColorPickerModel model;

  void setModel({Color? color, double? opacity, double? gradient}) {
    model = ColorPickerModel(
        color: color ?? model.color,
        opacity: opacity ?? model.opacity,
        gradient: gradient ?? model.gradient);

    notifyListeners();
  }
}
