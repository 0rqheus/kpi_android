import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:lab5/inputs/OpacityStepInput.dart';
import '../preset_filters/originalMatrix.dart';

class OpacityAnimation extends StatefulWidget {
  @override
  _OpacityAnimationState createState() => _OpacityAnimationState();
}

class _OpacityAnimationState extends State<OpacityAnimation> {
  ColorFilter filter = ColorFilter.matrix(originalMatrix);

  void playOpactityAnimation(double animationStep) {
    for (int i = 0; i <= 1 / animationStep; i++) {
      Future.delayed(Duration(milliseconds: 100 * i),
          () => setState(() => filter = alphaFilter(animationStep * i)));
    }
  }

  ColorFilter alphaFilter(double alpha) {
    var customMatrix = List<double>.from(originalMatrix);
    customMatrix[18] -= alpha;
    return ColorFilter.matrix(customMatrix);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Opacity animation')),
      body: ListView(
        padding: const EdgeInsets.all(10),
        children: [
          Stack(children: [
            Image.asset('assets/back.png', height: 250),
            ColorFiltered(
              child: Image.asset('assets/target.png'),
              colorFilter: filter,
            )
          ]),
          OpacityStepInput(playOpactityAnimation),
        ],
      ),
    );
  }
}
