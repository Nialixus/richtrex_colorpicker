import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'colorpicker_model.dart';

class ColorPickerState extends Cubit<ColorPickerModel> {
  ColorPickerState({required this.model}) : super(model);
  final ColorPickerModel model;

  void setModel({Color? color, double? opacity, double? gradient}) {
    ColorPickerModel newModel = model.copyWith(
        color: color ?? model.color,
        opacity: opacity ?? model.opacity,
        gradient: gradient ?? model.gradient);

    emit(newModel);
  }
}
