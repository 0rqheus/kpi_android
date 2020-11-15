import 'package:flutter/material.dart';

class OpacityStepInput extends StatefulWidget {
  final void Function(double animationStep) playOpactityAnimation;

  OpacityStepInput(this.playOpactityAnimation);

  @override
  _OpacityStepInputState createState() => _OpacityStepInputState();
}

class _OpacityStepInputState extends State<OpacityStepInput> {
  double _alphaStep = 0.1;

  @override
  Widget build(BuildContext context) {
    return Column(
        children: [
          Slider(
            value: _alphaStep,
            min: 0.0,
            max: 1.0,
            divisions: 10,
            label: _alphaStep.round().toString(),
            onChanged: (double value) => setState(() => _alphaStep = value),
          ),
          OutlineButton(
              child: Text('Play Animation'),
              borderSide: BorderSide(color: Colors.black),
              onPressed: () => widget.playOpactityAnimation(_alphaStep))
        ],
      );
  }
}
