import 'package:flutter/material.dart';
import 'package:richtrex_colorpicker/richtrex_colorpicker.dart';

void main() {
  runApp(const MaterialApp(title: "Color Picker Demo", home: MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Align(
          alignment: Alignment.center,
          child: FloatingActionButton(
            shape: const BeveledRectangleBorder(),
            elevation: 0,
            onPressed: () => RichTrexColorPicker.openDialog(context),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Icon(
                  Icons.colorize,
                  size: 20.0,
                ),
                Text(
                  "Dialog".toUpperCase(),
                  style: const TextStyle(
                      height: 1.75, fontSize: 8, fontWeight: FontWeight.bold),
                ),
              ],
            ),
            backgroundColor: Colors.blue.shade800,
          ),
        ),
        bottomSheet: DecoratedBox(
            decoration: const BoxDecoration(boxShadow: [
              BoxShadow(color: Colors.black12, blurRadius: 10.0)
            ]),
            child: Material(
                color: Colors.white,
                child: InkWell(
                    onTap: () => RichTrexColorPicker.openBottomSheet(context),
                    child: SizedBox(
                        height: kToolbarHeight,
                        child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.stretch,
                            children: [
                              Icon(Icons.colorize,
                                  size: 20.0, color: Colors.blue.shade800),
                              Text("Sheet".toUpperCase(),
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                      height: 1.75,
                                      fontSize: 10,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.blue.shade800))
                            ]))))));
  }
}
