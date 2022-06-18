import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

import '../state/colorpicker_state.dart';
import '../../richtrex_colorpicker.dart';

export 'colorpicker_custom.dart' hide ColorPickerCustom;

/// Set color by text in [RichTrexColorPicker].
class ColorPickerCustom extends StatelessWidget {
  /// Widget to set color by text.
  const ColorPickerCustom({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    TextEditingController controller = TextEditingController();
    var model = context.select((ColorPickerState state) => state.model);

    return SizedBox(
        height: 35,
        child: Row(crossAxisAlignment: CrossAxisAlignment.stretch, children: [
          Expanded(
              child: DecoratedBox(
                  decoration: BoxDecoration(
                      color: Colors.grey.shade200,
                      border: Border(
                          bottom: BorderSide(width: 3, color: model.output))),
                  child: TextField(
                    controller: controller,
                    maxLength: 8,
                    inputFormatters: [
                      FilteringTextInputFormatter.allow(RegExp(r'[a-fA-F0-9]'))
                    ],
                    decoration: InputDecoration(
                        counterText: "",
                        contentPadding: const EdgeInsets.all(8.0),
                        isDense: true,
                        hintText:
                            model.output.value.toRadixString(16).toUpperCase(),
                        border: InputBorder.none),
                  ))),
          Material(
              color: model.output,
              child: InkWell(
                  onTap: () {
                    if (controller.text.isNotEmpty) {
                      Color color = Color(int.parse("0x${controller.text}"));
                      double opacity = color.opacity;
                      context.read<ColorPickerState>().setModel(
                          color: color, opacity: opacity, gradient: 0.5);
                    }
                  },
                  child: Container(
                      alignment: Alignment.center,
                      padding: const EdgeInsets.symmetric(horizontal: 8.0),
                      child: Icon(
                        Icons.send,
                        size: 20.0,
                        color: model.gradient > 0.5
                            ? Colors.black
                            : model.opacity < 0.5
                                ? Colors.black
                                : Colors.white,
                      ))))
        ]));
  }
}
