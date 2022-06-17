library richtrex_colorpicker;

import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'src/colorpicker_basic.dart';
import 'src/colorpicker_custom.dart';
import 'src/colorpicker_gradient.dart';
import 'src/colorpicker_background.dart';
import 'src/colorpicker_opacity.dart';
import 'src/colorpicker_state.dart';

class RichTrexColorPicker extends StatelessWidget {
  final Color color;
  final CustomPainter? painter;
  final double scrollThickness;
  final Size colorBox;
  final EdgeInsetsGeometry? padding;

  const RichTrexColorPicker(
      {Key? key,
      required this.color,
      this.painter,
      this.scrollThickness = 6.0,
      this.colorBox = const Size(30, 30),
      this.padding})
      : super(key: key);

  @override
  Widget build(BuildContext context) => ChangeNotifierProvider(
        create: (_) => ColorPickerState(color: color),
        child: _build(
            color: color,
            colorBox: colorBox,
            padding: padding,
            painter: painter,
            scrollThickness: scrollThickness),
      );

  static Widget _build(
      {required Color color,
      CustomPainter? painter,
      double scrollThickness = 6.0,
      Size colorBox = const Size(30, 30),
      EdgeInsetsGeometry? padding}) {
    double bottom = painter is ColorPickerBackground ? 10 : 0;

    EdgeInsetsGeometry newPadding =
        padding?.add(EdgeInsets.only(bottom: bottom)) ??
            EdgeInsets.fromLTRB(15, 15, 15, 15 + bottom);

    return CustomPaint(
        painter: painter,
        child: Padding(
            padding: newPadding,
            child: IntrinsicWidth(
                child: Column(children: [
              Flexible(
                  child: Row(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                    // Basic Color Picker
                    ColoredBox(
                        color: Colors.black12,
                        child: RawScrollbar(
                            interactive: false,
                            isAlwaysShown: true,
                            thumbColor: Colors.black,
                            thickness: scrollThickness,
                            child: SingleChildScrollView(
                                padding:
                                    EdgeInsets.only(right: scrollThickness),
                                child: ConstrainedBox(
                                    child: const ColorPickerBasic(),
                                    constraints: BoxConstraints(
                                        maxWidth: colorBox.width * 5))))),

                    // Opacity Color Picker
                    Padding(
                        padding:
                            EdgeInsets.only(left: newPadding.horizontal / 2),
                        child: const ColorPickerOpacity()),
                  ])),

              // Gradient Color Picker
              const Padding(
                  padding: EdgeInsets.symmetric(vertical: 15.0),
                  child: ColorPickerGradient()),

              // Text Color Picker
              const ColorPickerCustom()
            ]))));
  }

  /// Open [RichTrexColorPicker] as Bottom Sheet.
  static Future<Color> openBottomSheet(BuildContext context,
      {required Color color,
      EdgeInsetsGeometry? margin,
      EdgeInsetsGeometry? padding,
      double scrollThickness = 6.0,
      Size colorBox = const Size(30, 30)}) {
    return showModalBottomSheet<Color>(
            context: context,
            barrierColor: Colors.transparent,
            backgroundColor: Colors.transparent,
            isScrollControlled: true,
            builder: (_) => Padding(
                padding: EdgeInsets.only(
                    bottom: MediaQuery.of(context).viewInsets.bottom),
                child: ChangeNotifierProvider(
                    create: (_) => ColorPickerState(color: color),
                    builder: (state, child) => WillPopScope(
                          onWillPop: () async {
                            Navigator.pop(
                                _, state.read<ColorPickerState>().model.output);
                            return true;
                          },
                          child: GestureDetector(
                            onTap: () => Navigator.pop(
                                _, state.read<ColorPickerState>().model.output),
                            child: child,
                          ),
                        ),
                    child: Container(
                        color: Colors.transparent,
                        alignment: Alignment.bottomCenter,
                        padding: margin ??
                            const EdgeInsets.only(bottom: kToolbarHeight),
                        child: GestureDetector(
                            onTap: () {
                              // do nothing
                            },
                            child: ConstrainedBox(
                                constraints: BoxConstraints(
                                    maxWidth: (colorBox.width * 8) +
                                        (padding != null
                                            ? padding.horizontal * 1.5
                                            : 15 * 3) +
                                        scrollThickness,
                                    maxHeight: (colorBox.height * 7) +
                                        (padding != null
                                            ? padding.vertical * 2
                                            : 15 * 4)),
                                child: _build(
                                    color: color,
                                    painter: ColorPickerBackground())))))))
        .then((value) => value ?? color);
  }

  /// Open [RichTrexColorPicker] as Dialog.
  static Future<Color> openDialog(BuildContext context,
      {required Color color,
      EdgeInsetsGeometry? margin,
      EdgeInsetsGeometry? padding,
      double scrollThickness = 6.0,
      Size colorBox = const Size(30, 30)}) {
    return showDialog<Color>(
            context: context,
            builder: (_) => ChangeNotifierProvider(
                create: (_) => ColorPickerState(color: color),
                builder: (context, child) => WillPopScope(
                    child: child!,
                    onWillPop: () async {
                      Navigator.pop(
                          _, context.read<ColorPickerState>().model.output);
                      return true;
                    }),
                child: Padding(
                    padding: EdgeInsets.only(
                        bottom: MediaQuery.of(_).viewInsets.bottom),
                    child: Center(
                        child: Material(
                            color: Colors.white,
                            child: Container(
                                constraints: BoxConstraints(
                                    maxWidth: (colorBox.width * 7) +
                                        (padding?.horizontal ?? 15 * 2) +
                                        scrollThickness,
                                    maxHeight: (colorBox.height * 7) +
                                        (padding != null
                                            ? padding.vertical * 2
                                            : 15 * 4)),
                                child: _build(color: color),
                                color: Colors.transparent,
                                alignment: Alignment.center))))))
        .then((value) => value ?? color);
  }
}
