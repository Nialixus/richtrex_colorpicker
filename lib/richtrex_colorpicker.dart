library richtrex_colorpicker;

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:richtrex_colorpicker/src/colorpicker_model.dart';
import 'src/colorpicker_basic.dart';
import 'src/colorpicker_custom.dart';
import 'src/colorpicker_gradient.dart';
import 'src/colorpicker_background.dart';
import 'src/colorpicker_opacity.dart';
import 'src/colorpicker_state.dart';

class RichTrexColorPicker extends StatelessWidget {
  const RichTrexColorPicker(
      {Key? key,
      this.color = Colors.black,
      this.painter,
      this.scrollThickness = 6.0,
      this.colorBox = const Size(30, 30),
      this.padding})
      : super(key: key);

  /// Default color.
  final Color color;

  final EdgeInsetsGeometry? padding;

  /// [RichTrexColorPicker] background.
  final CustomPainter? painter;

  /// Thickness of [Scrollbar], by default is 6.0.
  final double scrollThickness;

  /// [ColoredBox]'s Size, by default is `30 x 30`.
  final Size colorBox;

  @override
  Widget build(BuildContext context) {
    double bottom = painter is ColorPickerBackground ? 10 : 0;

    EdgeInsetsGeometry newPadding =
        padding?.add(EdgeInsets.only(bottom: bottom)) ??
            EdgeInsets.fromLTRB(15, 15, 15, 15 + bottom);

    return BlocProvider(
        create: (_) => ColorPickerState(
            model: ColorPickerModel(color: color, opacity: 1.0, gradient: 0.5)),
        child: CustomPaint(
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
                        // Basic ColorPicker
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
                                        maxWidth: colorBox.width * 5),
                                  ))),
                        ),

                        Padding(
                          padding:
                              EdgeInsets.only(left: newPadding.horizontal / 2),
                          child: const ColorPickerOpacity(),
                        )
                      ])),
                  const Padding(
                      padding: EdgeInsets.symmetric(vertical: 15.0),
                      child: ColorPickerGradient()),
                  const ColorPickerCustom()
                ])))));
  }

  /// Open [RichTrexColorPicker] as Bottom Sheet.
  static Future openBottomSheet(BuildContext context,
          {EdgeInsetsGeometry? margin,
          EdgeInsetsGeometry? padding,
          double scrollThickness = 6.0,
          Size colorBox = const Size(30, 30)}) =>
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
                    margin ?? const EdgeInsets.only(bottom: kToolbarHeight),
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
                        child: RichTrexColorPicker(
                            painter: ColorPickerBackground()))),
              ),
            ),
          ),
        ),
      );

  /// Open [RichTrexColorPicker] as Dialog.
  static Future openDialog(BuildContext context,
          {EdgeInsetsGeometry? margin,
          EdgeInsetsGeometry? padding,
          double scrollThickness = 6.0,
          Size colorBox = const Size(30, 30)}) =>
      showDialog(
          context: context,
          builder: (_) => Center(
                child: Material(
                  color: Colors.white,
                  child: Container(
                    constraints: BoxConstraints(
                        maxWidth: (colorBox.width * 7) +
                            (padding?.horizontal ?? 15 * 2) +
                            scrollThickness,
                        maxHeight: (colorBox.height * 7) +
                            (padding != null ? padding.vertical * 2 : 15 * 4)),
                    child: const RichTrexColorPicker(),
                    color: Colors.transparent,
                    alignment: Alignment.center,
                  ),
                ),
              ));
}
