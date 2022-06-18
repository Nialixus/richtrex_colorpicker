/// Library of `RichTrex` extended package `ColorPicker`
library richtrex_colorpicker;

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'src/state/colorpicker_state.dart';
import 'src/widget/colorpicker_basic.dart';
import 'src/widget/colorpicker_custom.dart';
import 'src/widget/colorpicker_opacity.dart';
import 'src/widget/colorpicker_gradient.dart';
import 'src/paint/colorpicker_background.dart';

/// Extended package of `RichTrex` to pick [Color].
class RichTrexColorPicker extends StatelessWidget {
  /// Initial color.
  final Color color;

  /// [Scrollbar] thickness, by default is `6.0`.
  final double scrollThickness;

  /// Size of each color box, by default is `30 x 30`.
  final Size colorBox;

  /// Space range between one picker to another.
  final EdgeInsetsGeometry? padding;

  /// Color output when user interact with [RichTrexColorPicker].
  final void Function(Color color)? onChanged;

  /// Display [RichTrexColorPicker] as widget in tree.
  const RichTrexColorPicker({
    Key? key,
    this.padding,
    this.onChanged,
    required this.color,
    this.scrollThickness = 6.0,
    this.colorBox = const Size(30, 30),
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ConstrainedBox(
        constraints: BoxConstraints(
            maxWidth: (colorBox.width * 7) +
                (padding?.horizontal ?? 15 * 2) +
                scrollThickness,
            maxHeight: (colorBox.height * 7) +
                (padding != null ? padding!.vertical * 2 : 15 * 4)),
        child: ChangeNotifierProvider(
            create: (_) => ColorPickerState(color: color),
            builder: (state, child) {
              onChanged!(
                  state.select((ColorPickerState state) => state.model.output));
              return child!;
            },
            child: _build(
                color: color,
                colorBox: colorBox,
                padding: padding,
                painter: null,
                scrollThickness: scrollThickness)));
  }

  /// UI core of [RichTrexColorPicker].
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
                        child: const ColorPickerOpacity(),
                        padding:
                            EdgeInsets.only(left: newPadding.horizontal / 2)),
                  ])),

              // Gradient Color Picker
              Padding(
                  child: const ColorPickerGradient(),
                  padding:
                      EdgeInsets.symmetric(vertical: newPadding.vertical / 2)),

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
