import 'package:flutter/material.dart';
import 'colorpicker_model.dart';

class ColorPickerState with ChangeNotifier {
  ColorPickerState({required this.model});
  ColorPickerModel model;

  void setModel({Color? color, double? opacity, double? gradient}) {
    model = ColorPickerModel(
        color: color ?? model.color,
        opacity: opacity ?? model.opacity,
        gradient: gradient ?? model.gradient);

    notifyListeners();
  }
}
