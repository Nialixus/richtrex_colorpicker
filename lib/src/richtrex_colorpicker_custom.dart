import 'package:flutter/material.dart';

export 'richtrex_colorpicker_custom.dart' hide ColorPickerCustom;

class ColorPickerCustom extends StatelessWidget {
  const ColorPickerCustom({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          color: Colors.black.withOpacity(0.05),
          border:
              const Border(bottom: BorderSide(width: 3, color: Colors.black))),
      height: 35,
      child: const TextField(
        decoration: InputDecoration(
            contentPadding: EdgeInsets.all(8.0),
            isDense: true,
            hintText: "#012AAF",
            border: InputBorder.none),
      ),
    );
  }
}
