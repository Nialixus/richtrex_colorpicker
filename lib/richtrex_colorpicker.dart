library richtrex_colorpicker;

import 'package:flutter/material.dart';
import 'src/richtrex_colorpicker_basic.dart';
import 'src/richtrex_colorpicker_custom.dart';
import 'src/richtrex_colorpicker_gradient.dart';
import 'src/richtrex_colorpicker_background.dart';
import 'src/richtrex_colorpicker_opacity.dart';

class RichTrexColorPicker extends StatefulWidget {
  const RichTrexColorPicker({Key? key, this.color = Colors.black, this.painter})
      : super(key: key);

  /// Default color.
  final Color color;

  /// [RichTrexColorPicker] background.
  final CustomPainter? painter;

  @override
  State<RichTrexColorPicker> createState() => _RichTrexColorPickerState();

  /// Open [RichTrexColorPicker] as Bottom Sheet.
  static Future openBottomSheet(BuildContext context,
          {EdgeInsetsGeometry? padding}) =>
      showModalBottomSheet(
        context: context,
        barrierColor: Colors.transparent,
        backgroundColor: Colors.transparent,
        isScrollControlled: true,
        builder: (_) => WillPopScope(
          onWillPop: () async {
            return true;
          },
          child: Padding(
            padding: EdgeInsets.only(
              bottom: MediaQuery.of(context).viewInsets.bottom,
            ),
            child: GestureDetector(
              onTap: () => Navigator.pop(_),
              child: Container(
                color: Colors.transparent,
                alignment: Alignment.bottomCenter,
                padding:
                    padding ?? const EdgeInsets.only(bottom: kToolbarHeight),
                child: GestureDetector(
                    onTap: () {
                      // do nothing
                    },
                    child: ConstrainedBox(
                        constraints: const BoxConstraints(
                            maxWidth: (30 * 7) + (15 * 4) + 6,
                            maxHeight: (30 * 6) + (15 * 3) + 35),
                        child: RichTrexColorPicker(
                            painter: ColorPickerBackground()))),
              ),
            ),
          ),
        ),
      );

  /// Open [RichTrexColorPicker] as Dialog.
  static Future openDialog(BuildContext context) => showDialog(
      context: context,
      builder: (_) => Center(
            child: Material(
              child: Container(
                constraints: const BoxConstraints(
                  maxWidth: (30 * 7) + (15 * 4) + 6,
                  maxHeight: (30 * 6) + (15 * 3) + 35,
                ),
                child: const RichTrexColorPicker(),
                color: Colors.transparent,
                alignment: Alignment.center,
              ),
            ),
          ));
}

class _RichTrexColorPickerState extends State<RichTrexColorPicker> {
  @override
  Widget build(BuildContext context) {
    double bottom = widget.painter is ColorPickerBackground ? 25 : 15;
    return CustomPaint(
        painter: widget.painter,
        child: Padding(
            padding: EdgeInsets.fromLTRB(15, 15, 15, bottom),
            child: Column(children: [
              Flexible(
                  child: Row(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                    // Basic ColorPicker
                    ColoredBox(
                      color: Colors.black12,
                      child: RawScrollbar(
                          thumbColor: Colors.black,
                          isAlwaysShown: true,
                          child: SingleChildScrollView(
                              padding: const EdgeInsets.only(right: 6.0),
                              child: ConstrainedBox(
                                child: const ColorPickerBasic(),
                                constraints:
                                    const BoxConstraints(maxWidth: 30 * 5),
                              ))),
                    ),

                    // Gradient ColorPicker
                    const ColorPickerGradient(),

                    // Gradient ColorPicker
                    const ColorPickerOpacity()
                  ])),
              const Padding(
                  padding: EdgeInsets.only(top: 15.0),
                  child: ColorPickerCustom())
            ])));
  }
}
