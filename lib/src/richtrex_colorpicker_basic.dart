import 'package:flutter/material.dart';
import 'richtrex_colorpicker_colors.dart';

export 'richtrex_colorpicker_basic.dart' hide ColorPickerBasic;

class ColorPickerBasic extends StatelessWidget {
  const ColorPickerBasic({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Wrap(
      children: List.from(colors.map((color) => DecoratedBox(
            position: DecorationPosition.foreground,
            decoration: BoxDecoration(
                border: color == Colors.white
                    ? Border.all(color: Colors.black26, width: 1)
                    : null),
            child: Material(
              color: color,
              child: InkWell(
                onTap: () {},
                child: const SizedBox(
                  width: 30,
                  height: 30,
                ),
              ),
            ),
          ))),
    );
  }
}
