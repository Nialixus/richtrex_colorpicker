# RichTrex: Color Picker
<a href='https://pub.dev/packages/richtrex_colorpicker'><img src='https://img.shields.io/pub/v/richtrex_colorpicker.svg?logo=flutter&color=blue&style=flat-square'/></a></br>
An extended package used in `RichTrex` package to pick color.
## Preview
<table>
  <tr>
    <td><img src="https://user-images.githubusercontent.com/45191605/174426454-7d39c384-013d-4c26-8f0f-8aefc5f82a87.gif"/></td>
    <td><img src="https://user-images.githubusercontent.com/45191605/174426475-c9feac54-00b1-47e1-8b9f-165688ae7e46.gif"/></td>
    <td><img src="https://user-images.githubusercontent.com/45191605/174426478-7a46bc7e-1ddc-4421-9efc-dc686c0b462e.gif"/></td>
  </tr>
  <tr align="center">
    <td>Dialog</td>
    <td>Bottom sheet</td>
    <td>Widget</td>
  </tr>
</table>

## Install

Add this line to your pubspec.yaml.

```yaml
dependencies:
  richtrex_colorpicker: ^1.0.0
```

## Usage

First, import the package.

```dart
import 'package:richtrex_colorpicker/richtrex_colorpicker.dart';
```

And then put the widget like this.
```dart
RichTrexColorPicker(
  color: Colors.blue,
  onChanged: (color) => print(color),
);
```

Or if you want to open it as `Dialog`, do this.
```dart
GestureDetector(
  onTap: () async {
    var color = await RichTrexColorPicker.openDialog(context, color: Colors.blue);
    print(color);
  }
);
```

And if you want to open it as `Bottom Sheet`, try this.
```dart
GestureDetector(
  onTap: () async {
    var color = await RichTrexColorPicker.openBottomSheet(context, color: Colors.blue);
    print(color);
  }
);
```

## Sample
- [richtrex_colorpicker/main/example/lib/main.dart](https://github.com/Nialixus/richtrex_colorpicker/blob/main/example/lib/main.dart)
- [richtrex_colorpicker/releases/tag/v1.0.0.apk](https://github.com/Nialixus/richtrex_colorpicker/releases/tag/v1.0.0)
