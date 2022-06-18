import 'package:flutter/material.dart';

import '../../richtrex_colorpicker.dart';

export 'colorpicker_model.dart' hide ColorPickerModel;

/// Default model used in [RichTrexColorPicker].
class ColorPickerModel {
  /// Basic color.
  final Color color;

  /// Opacity of [color].
  final double opacity;

  /// Gradient of [color], by default is `0.5`.
  final double gradient;

  /// Color result of mixing [color], [opacity], and [gradient].
  final Color output;

  /// Model to generate [output] by requiring [color], [opacity] and [gradient].
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
