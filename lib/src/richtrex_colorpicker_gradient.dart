import 'package:flutter/material.dart';

export 'richtrex_colorpicker_gradient.dart' hide ColorPickerGradient;

class ColorPickerGradient extends StatelessWidget {
  const ColorPickerGradient({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(left: 15.0),
      width: 30,
      decoration: BoxDecoration(
          gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [
            Color.lerp(Colors.blue, Colors.black, 1.0)!,
            Colors.blue,
            Color.lerp(Colors.blue, Colors.white, 1.0)!
          ])),
    );
  }
}
