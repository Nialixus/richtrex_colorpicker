import 'package:flutter/material.dart';
import 'package:richtrex_colorpicker/src/richtrex_colorpicker_transparent_background.dart';

export 'richtrex_colorpicker_opacity.dart' hide ColorPickerOpacity;

class ColorPickerOpacity extends StatelessWidget {
  const ColorPickerOpacity({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Positioned.fill(
            child: CustomPaint(
                painter: TransparentBackground(size: const Size(7.5, 7.5)))),
        Container(
          width: 30,
          decoration: const BoxDecoration(
              gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [Colors.blue, Colors.transparent])),
        ),
        Positioned.fill(
            child: GestureDetector(
          onVerticalDragUpdate: (details) => print(details.localPosition.dy),
          child: ColoredBox(
            color: Colors.orange,
          ),
        ))
      ],
    );
  }
}
