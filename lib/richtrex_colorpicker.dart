library richtrex_colorpicker;

import 'package:flutter/material.dart';
import 'src/richtrex_colorpicker_basic.dart';
import 'src/richtrex_colorpicker_custom.dart';
import 'src/richtrex_colorpicker_gradient.dart';
import 'src/richtrex_colorpicker_background.dart';
import 'src/richtrex_colorpicker_transparency.dart';

class RichTrexColorPicker extends StatefulWidget {
  const RichTrexColorPicker({
    Key? key,
    this.color = Colors.black,
  }) : super(key: key);
  final Color color;

  @override
  State<RichTrexColorPicker> createState() => _RichTrexColorPickerState();
}

class _RichTrexColorPickerState extends State<RichTrexColorPicker> {
  @override
  Widget build(BuildContext context) {
    return CustomPaint(
        painter: ColorPickerBackground(),
        child: Padding(
            padding: const EdgeInsets.fromLTRB(15, 15, 15, 25),
            child: Column(children: [
              Flexible(
                  child: Row(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                    // Basic ColorPicker
                    Scrollbar(
                        child: SingleChildScrollView(
                            child: ConstrainedBox(
                      child: const ColorPickerBasic(),
                      constraints: const BoxConstraints(maxWidth: 30 * 5),
                    ))),

                    // Gradient ColorPicker
                    const ColorPickerGradient()
                  ])),
              Padding(
                  padding: const EdgeInsets.only(top: 15.0),
                  child: Row(children: const [
                    // Custom ColorPicker
                    Expanded(child: ColorPickerCustom()),

                    // Transparency ColorPicker
                    Expanded(child: ColorPickerTransparency()),
                  ]))
            ])));
  }
}

extension ShowColorPicker on RichTrexColorPicker {
  /// Open [RichTrexColorPicker] from bottom.
  Future open(BuildContext context) => showModalBottomSheet(
      context: context,
      enableDrag: false,
      isScrollControlled: true,
      barrierColor: Colors.transparent,
      backgroundColor: Colors.transparent,
      builder: (_) => GestureDetector(
          onTap: () => Navigator.pop(_),
          child: Container(
            child: this,
            color: Colors.transparent,
            alignment: Alignment.bottomCenter,
            padding: const EdgeInsets.only(bottom: 45.0),
          )),
      constraints: const BoxConstraints(
        maxWidth: (30 * 6) + (15 * 3),
        maxHeight: (30 * 6) + (15 * 3) + 35,
      ));
}
