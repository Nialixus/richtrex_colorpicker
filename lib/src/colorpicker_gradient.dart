import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'colorpicker_model.dart';
import 'colorpicker_slider.dart';
import 'colorpicker_state.dart';

export 'colorpicker_gradient.dart' hide ColorPickerGradient;

class ColorPickerGradient extends StatelessWidget {
  const ColorPickerGradient({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double gradient(Offset offset, Size size) {
      if (offset.dx < 0) {
        return 1;
      } else if (offset.dx > size.width) {
        return 0;
      } else {
        return 1 - offset.dx / size.width;
      }
    }

    Color color(Color color, double gradient) {
      if (gradient < 0.5) {
        return Color.lerp(Colors.white, color, gradient)!;
      } else if (gradient > 0.5) {
        return Color.lerp(color, Colors.black, gradient)!;
      } else {
        return color;
      }
    }

    return BlocBuilder<ColorPickerState, ColorPickerModel>(builder: (_, model) {
      Color newColor = color(model.color, 0.5);
      return Stack(
        children: [
          Container(
              height: 30,
              decoration: BoxDecoration(
                  gradient: LinearGradient(
                      begin: Alignment.centerLeft,
                      end: Alignment.centerRight,
                      colors: [
                    Color.lerp(newColor.withOpacity(1), Colors.white, 1.0)!,
                    newColor.withOpacity(1),
                    Color.lerp(newColor.withOpacity(1), Colors.black, 1.0)!,
                  ]))),
          /*  Positioned.fill(
              child: LayoutBuilder(
                  builder: (_, size) => GestureDetector(
                      onHorizontalDragUpdate: (drag) {
                        double value =
                            gradient(drag.localPosition, size.biggest);

                        context
                            .read<ColorPickerState>()
                            .setModel(gradient: value);
                      },
                      child: CustomPaint(
                          painter: ColorPickerSlider(
                              scrollDirection: Axis.horizontal,
                              offset: Offset(
                                  (1 - model.gradient) * size.biggest.width, 0),
                              color: Color.lerp(
                                  Colors.black, model.color, 0.5)!)))))*/
        ],
      );
    });
  }
}
