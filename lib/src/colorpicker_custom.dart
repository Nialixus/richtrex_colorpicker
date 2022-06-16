import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:richtrex_colorpicker/src/colorpicker_model.dart';

import 'colorpicker_state.dart';

export 'colorpicker_custom.dart' hide ColorPickerCustom;

class ColorPickerCustom extends StatelessWidget {
  const ColorPickerCustom({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ColorPickerState, ColorPickerModel>(
        builder: (context, model) {
      return Container(
        decoration: BoxDecoration(
            color: Colors.black.withOpacity(0.05),
            border: Border(bottom: BorderSide(width: 3, color: model.color))),
        height: 35,
        child: TextField(
          decoration: InputDecoration(
              contentPadding: const EdgeInsets.all(8.0),
              isDense: true,
              hintText: model.color.value.toRadixString(16).toUpperCase(),
              border: InputBorder.none),
        ),
      );
    });
  }
}
