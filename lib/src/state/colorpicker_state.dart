import 'package:flutter/material.dart';

import 'colorpicker_model.dart';
import '../../richtrex_colorpicker.dart';

export 'colorpicker_state.dart' hide ColorPickerState;

/// State to pass [ColorPickerModel] in [RichTrexColorPicker].
class ColorPickerState with ChangeNotifier {
  /// Require [color] to generate end result as [ColorPickerModel.output].
  ColorPickerState({required Color color})
      : model = ColorPickerModel(
            color: color.withOpacity(1.0),
            opacity: color.opacity,
            gradient: 0.5);

  /// Model used in [RichTrexColorPicker] state.
  ColorPickerModel model;

  /// Update [model] in [RichTrexColorPicker].
  void setModel({Color? color, double? opacity, double? gradient}) {
    model = ColorPickerModel(
        color: color ?? model.color,
        opacity: opacity ?? model.opacity,
        gradient: gradient ?? model.gradient);

    notifyListeners();
  }
}
