import 'package:flutter/material.dart';

class ColorPickerSlider extends CustomPainter {
  ColorPickerSlider(
      {required this.offset,
      this.thickness = 10.0,
      this.scrollDirection = Axis.vertical,
      this.color = Colors.black});
  final double thickness;
  final Offset offset;
  final Axis scrollDirection;
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
