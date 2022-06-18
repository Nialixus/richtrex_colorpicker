import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'colorpicker_state.dart';
import 'colorpicker_slider.dart';
import '../richtrex_colorpicker.dart';

export 'colorpicker_gradient.dart' hide ColorPickerGradient;

/// Pick color gradient in [RichTrexColorPicker].
class ColorPickerGradient extends StatelessWidget {
  /// Widget to set color gradient.
  const ColorPickerGradient({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var model = context.select((ColorPickerState state) => state.model);
    double gradient(Offset offset, Size size) {
      if (offset.dx < 0) {
        return 1;
      } else if (offset.dx > size.width) {
        return 0;
      } else {
        return 1 - offset.dx / size.width;
      }
    }

    return Stack(children: [
      Container(
          height: 30,
          decoration: BoxDecoration(
              gradient: LinearGradient(
                  begin: Alignment.centerLeft,
                  end: Alignment.centerRight,
                  colors: [
                Color.lerp(Colors.white, model.color, 0)!,
                model.color,
                Color.lerp(model.color, Colors.black, 1.0)!,
              ]))),
      Positioned.fill(
          child: LayoutBuilder(
              builder: (_, size) => GestureDetector(
                  onTapDown: (tap) => context.read<ColorPickerState>().setModel(
                      gradient: gradient(tap.localPosition, size.biggest)),
                  onHorizontalDragUpdate: (drag) => context
                      .read<ColorPickerState>()
                      .setModel(
                          gradient: gradient(drag.localPosition, size.biggest)),
                  child: CustomPaint(
                      painter: ColorPickerSlider(
                          scrollDirection: Axis.horizontal,
                          offset: Offset(
                              (1 - model.gradient) * size.biggest.width, 0),
                          color:
                              Color.lerp(Colors.black, model.color, 0.5)!)))))
    ]);
  }
}
