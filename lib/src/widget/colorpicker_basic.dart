import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../state/colorpicker_state.dart';
import '../../richtrex_colorpicker.dart';

export 'colorpicker_basic.dart' hide ColorPickerBasic, colors;

/// Basic color picker in [RichTrexColorPicker].
class ColorPickerBasic extends StatelessWidget {
  /// Widget to set color based on color box.
  const ColorPickerBasic({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Wrap(
        children: List.from(colors.map((color) => Material(
            color: color,
            child: InkWell(
                onTap: () => context
                    .read<ColorPickerState>()
                    .setModel(color: color, opacity: 1.0, gradient: 0.5),
                child: const SizedBox(
                  width: 30,
                  height: 30,
                ))))));
  }
}

/// Default basic color used in [ColorPickerBasic].
List<Color> colors = [
  Colors.pink,
  Colors.pinkAccent,
  Colors.red,
  Colors.redAccent,
  Colors.deepOrange,
  Colors.deepOrangeAccent,
  Colors.orange,
  Colors.orangeAccent,
  Colors.amber,
  Colors.amberAccent,
  Colors.yellow,
  Colors.yellowAccent,
  Colors.lime,
  Colors.limeAccent,
  Colors.lightGreen,
  Colors.lightGreenAccent,
  Colors.green,
  Colors.greenAccent,
  Colors.teal,
  Colors.tealAccent,
  Colors.cyan,
  Colors.cyanAccent,
  Colors.lightBlue,
  Colors.lightBlueAccent,
  Colors.blue,
  Colors.blueAccent,
  Colors.indigo,
  Colors.indigoAccent,
  Colors.purple,
  Colors.purpleAccent,
  Colors.deepPurple,
  Colors.deepPurpleAccent,
  Colors.blueGrey,
  Colors.brown,
  Colors.grey,
];
