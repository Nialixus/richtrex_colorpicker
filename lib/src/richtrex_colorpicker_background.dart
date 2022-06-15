import 'dart:ui';
import 'package:flutter/material.dart';

export 'richtrex_colorpicker_background.dart' hide ColorPickerBackground;

class ColorPickerBackground extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    Path path = Path()
      ..moveTo(0, 0)
      ..lineTo(size.width, 0)
      ..lineTo(size.width, size.height - 10.0)
      ..lineTo(size.width / 2 + 5, size.height - 10)
      ..lineTo(size.width / 2, size.height)
      ..lineTo(size.width / 2 - 5, size.height - 10)
      ..lineTo(0, size.height - 10)
      ..close();

    Paint paint = Paint()..color = Colors.white;
    Paint shadow = Paint()
      ..color = Colors.black12
      ..imageFilter =
          ImageFilter.blur(sigmaX: 10, sigmaY: 10, tileMode: TileMode.decal);

    canvas.drawPath(path, shadow);
    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) =>
      oldDelegate != this;
}