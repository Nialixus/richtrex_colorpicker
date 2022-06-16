import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:richtrex_colorpicker/src/colorpicker_model.dart';
import 'package:richtrex_colorpicker/src/colorpicker_slider.dart';
import 'package:richtrex_colorpicker/src/colorpicker_transparent_background.dart';

import 'colorpicker_state.dart';

export 'colorpicker_opacity.dart' hide ColorPickerOpacity;

class ColorPickerOpacity extends StatelessWidget {
  const ColorPickerOpacity({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double opacity(Offset offset, Size size) {
      if (offset.dy < 0) {
        return 1;
      } else if (offset.dy > size.height) {
        return 0;
      } else {
        return 1 - offset.dy / size.height;
      }
    }

    return BlocBuilder<ColorPickerState, ColorPickerModel>(builder: (_, model) {
      return Stack(children: [
        Positioned.fill(
            child: CustomPaint(
                painter: TransparentBackground(size: const Size(7.5, 7.5)))),
        Container(
            width: 30,
            decoration: BoxDecoration(
                gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [model.color, Colors.transparent]))),
        Positioned.fill(
            child: LayoutBuilder(
                builder: (_, size) => GestureDetector(
                    onVerticalDragUpdate: (drag) {
                      double value = opacity(drag.localPosition, size.biggest);

                      context.read<ColorPickerState>().setModel(opacity: value);
                    },
                    child: CustomPaint(
                        painter: ColorPickerSlider(
                            offset: Offset(
                                0, (1 - model.opacity) * size.biggest.height),
                            color:
                                Color.lerp(Colors.black, model.color, 0.5)!)))))
      ]);
    });
  }
}
