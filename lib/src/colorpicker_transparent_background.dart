import 'package:flutter/material.dart';

class TransparentBackground extends CustomPainter {
  TransparentBackground({this.size = const Size(20, 20)});
  final Size size;

  @override
  void paint(Canvas canvas, Size oldSize) {
    Path path(int x, int y) => Path()
      ..moveTo(size.width * x, size.height * y)
      ..lineTo(size.width * (x + 1), size.height * y)
      ..lineTo(size.width * (x + 1), size.height * (y + 1))
      ..lineTo(size.width * x, size.height * (y + 1))
      ..close();

    for (int vertical = 0;
        vertical < oldSize.height / size.height;
        vertical++) {
      for (int horizontal = 0;
          horizontal < oldSize.width / size.width;
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
