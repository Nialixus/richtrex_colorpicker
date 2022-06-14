import 'package:flutter/material.dart';

export 'richtrex_colorpicker_custom.dart' hide ColorPickerCustom;

class ColorPickerCustom extends StatelessWidget {
  const ColorPickerCustom({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
          border: Border(bottom: BorderSide(width: 3, color: Colors.black))),
      margin: const EdgeInsets.only(right: 15.0),
      height: 35,
      child: const TextField(
        decoration: InputDecoration(isDense: true, labelText: "#012AAF"),
      ),
    );
  }
}
