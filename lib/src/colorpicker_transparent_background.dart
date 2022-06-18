import 'package:flutter/material.dart';

export 'colorpicker_transparent_background.dart' hide TransparentBackground;

/// Squares background below transparent color.
class TransparentBackground extends CustomPainter {
  /// Display background below transparent color.
  TransparentBackground({this.size = const Size(20, 20)});

  /// Size each square in [TransparentBackground], by default is `20 x 20`.
  final Size size;

  @override
  void paint(Canvas canvas, Size size) {
    Path path(int x, int y) => Path()
      ..moveTo(this.size.width * x, this.size.height * y)
      ..lineTo(this.size.width * (x + 1), this.size.height * y)
      ..lineTo(this.size.width * (x + 1), this.size.height * (y + 1))
      ..lineTo(this.size.width * x, this.size.height * (y + 1))
      ..close();

    for (int vertical = 0;
        vertical < size.height / this.size.height;
        vertical++) {
      for (int horizontal = 0;
          horizontal < size.width / this.size.width;
          horizontal++) {
        canvas.drawPath(
            path(horizontal, vertical),
            Paint()
              ..color = (vertical.isEven && horizontal.isEven
                      ? Colors.black
                      : vertical.isEven && horizontal.isOdd
                          ? Colors.white
                          : vertical.isOdd && horizontal.isOdd
                              ? Colors.black
                              : Colors.white)
                  .withOpacity(0.1));
      }
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) =>
      oldDelegate != this;
}
