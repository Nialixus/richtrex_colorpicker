import 'package:flutter/material.dart';

import '../widget/colorpicker_opacity.dart';
import '../widget/colorpicker_gradient.dart';

export 'colorpicker_slider.dart' hide ColorPickerSlider;

/// Custom slider to set [ColorPickerOpacity] or [ColorPickerGradient] value.
class ColorPickerSlider extends CustomPainter {
  /// Default slider of [ColorPickerOpacity] and [ColorPickerGradient].
  ColorPickerSlider(
      {required this.offset,
      this.thickness = 10.0,
      this.scrollDirection = Axis.vertical,
      this.color = Colors.black});

  /// Slider's thickness, by default is `10.0`.
  final double thickness;

  /// Slider's position.
  final Offset offset;

  /// Slider's direction, by default is [Axis.vertical].
  final Axis scrollDirection;

  /// Slider's color, by default is [Colors.black].
  final Color color;

  @override
  void paint(Canvas canvas, Size size) {
    Paint background = Paint()
      ..color = color
      ..style = PaintingStyle.fill;
    Paint border = Paint()
      ..color = Colors.white
      ..strokeWidth = thickness * 0.5
      ..style = PaintingStyle.stroke;

    if (scrollDirection == Axis.vertical) {
      Offset newOffset = Offset(offset.dx, offset.dy - (thickness * 0.25));

      Path vertical = Path()
        ..moveTo(0, newOffset.dy)
        ..lineTo(size.width, newOffset.dy)
        ..lineTo(size.width, newOffset.dy + thickness * 0.5)
        ..lineTo(0, newOffset.dy + thickness * 0.5)
        ..close();

      canvas.drawPath(vertical, border);
      canvas.drawPath(vertical, background);
    } else {
      Offset newOffset = Offset(offset.dx - (thickness * 0.25), offset.dy);

      Path horizontal = Path()
        ..moveTo(newOffset.dx, 0)
        ..lineTo(newOffset.dx + thickness * 0.5, 0)
        ..lineTo(newOffset.dx + thickness * 0.5, size.height)
        ..lineTo(newOffset.dx, size.height)
        ..close();

      canvas.drawPath(horizontal, border);
      canvas.drawPath(horizontal, background);
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) =>
      oldDelegate != this;
}
