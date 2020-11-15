import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:lab5/inputs/RgbInputs.dart';
import '../preset_filters/originalMatrix.dart';

class CustomRgb extends StatefulWidget {
  @override
  _CustomRgbState createState() => _CustomRgbState();
}

class _CustomRgbState extends State<CustomRgb> {
  ColorFilter filter = ColorFilter.matrix(originalMatrix);

  void applyRgbValues(double red, double green, double blue) {
    setState(() {
      filter = customRgbFilter(red, green, blue);
    });
  }

  ColorFilter customRgbFilter(double red, double green, double blue) {
    var customMatrix = new List<double>.from(originalMatrix);
    customMatrix[0] += red;
    customMatrix[6] += green;
    customMatrix[12] += blue;

    return ColorFilter.matrix(customMatrix);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Custom RGB')),
      body: ListView(
        padding: const EdgeInsets.all(10),
        children: [
          ColorFiltered(
            child: Image.asset('assets/target.png'),
            colorFilter: filter,
          ),
          RgbInputs(applyRgbValues)
        ],
      ),
    );
  }
}
