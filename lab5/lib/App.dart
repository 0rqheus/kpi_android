import 'package:flutter/material.dart';
import 'components/Menu.dart';
import 'components/CustomRgb.dart';
import 'components/OpacityAnimation.dart';
import 'components/ColorFilters.dart';
import 'components/MatrixFilters.dart';

class App extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Tmp chat',
      initialRoute: '/menu',
      routes: {
        '/menu': (BuildContext context) => Menu(),
        '/custom_rgb': (BuildContext context) => CustomRgb(),
        '/opacity': (BuildContext context) => OpacityAnimation(),
        '/color_filters': (BuildContext context) => ColorFilters(),
        '/matrix_filters': (BuildContext context) => MatrixFilters(),
      },
    );
  }
}
