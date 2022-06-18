import 'package:flutter/material.dart';
import 'package:richtrex_colorpicker/richtrex_colorpicker.dart';

void main() {
  runApp(const MaterialApp(title: "Color Picker Demo", home: MyApp()));
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  /// Initial [Color] `0xFF1565C0`.
  Color color = Colors.blue.shade800;

  /// Update [color].
  void setColor(Color color) => setState(() => this.color = color);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: PageView(children: [
          // Dialog sample.
          Center(
              child: FloatingActionButton(
                  elevation: 0,
                  shape: const BeveledRectangleBorder(),
                  backgroundColor: color,
                  onPressed: () =>
                      RichTrexColorPicker.openDialog(context, color: color)
                          .then((value) => setColor(value)),
                  child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Icon(Icons.colorize, size: 20.0),
                        Text("Dialog".toUpperCase(),
                            style: const TextStyle(
                                height: 1.75,
                                fontSize: 8,
                                fontWeight: FontWeight.bold))
                      ]))),

          // Widget in tree sample.
          Center(
              child: RichTrexColorPicker(
                  color: color,
                  onChanged: (color) =>
                      Future.value(color).then((value) => setColor(value))))
        ]),

        // Bottom sheet sample.
        bottomSheet: DecoratedBox(
            decoration: const BoxDecoration(boxShadow: [
              BoxShadow(color: Colors.black12, blurRadius: 10.0)
            ]),
            child: Material(
                color: Colors.white,
                child: InkWell(
                    onTap: () => RichTrexColorPicker.openBottomSheet(context,
                            color: color)
                        .then((value) => setColor(value)),
                    child: SizedBox(
                        height: kToolbarHeight,
                        child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.stretch,
                            children: [
                              Icon(Icons.colorize, size: 20.0, color: color),
                              Text("Sheet".toUpperCase(),
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                      height: 1.75,
                                      fontSize: 10,
                                      fontWeight: FontWeight.bold,
                                      color: color))
                            ]))))));
  }
}
