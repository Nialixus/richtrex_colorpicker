import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'colorpicker_state.dart';
import 'colorpicker_slider.dart';
import 'colorpicker_transparent_background.dart';

export 'colorpicker_opacity.dart' hide ColorPickerOpacity;

class ColorPickerOpacity extends StatelessWidget {
  const ColorPickerOpacity({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var model = context.select((ColorPickerState state) => state.model);
    double opacity(Offset offset, Size size) {
      if (offset.dy < 0) {
        return 1;
      } else if (offset.dy > size.height) {
        return 0;
      } else {
        return 1 - offset.dy / size.height;
      }
    }

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
                  onTapDown: (tap) => context.read<ColorPickerState>().setModel(
                      opacity: opacity(tap.localPosition, size.biggest)),
                  onVerticalDragUpdate: (drag) => context
                      .read<ColorPickerState>()
                      .setModel(
                          opacity: opacity(drag.localPosition, size.biggest)),
                  child: CustomPaint(
                      painter: ColorPickerSlider(
                          offset: Offset(
                              0, (1 - model.opacity) * size.biggest.height),
                          color:
                              Color.lerp(Colors.black, model.color, 0.5)!)))))
    ]);
  }
}
