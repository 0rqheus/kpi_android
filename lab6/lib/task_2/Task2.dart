import 'package:flutter/material.dart';
import 'dart:async';
import 'dart:math' as math;

class SecondTask extends StatefulWidget {
  @override
  _SecondTaskState createState() => _SecondTaskState();
}

class _SecondTaskState extends State<SecondTask> {
  double _speed = 20;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Example 1")),
      body: Column(
        children: [
          Center(
            child: CirclingRectangle(_speed),
          ),
          Slider(
              value: _speed,
              min: 10,
              max: 1000,
              divisions: 10,
              label: _speed.round().toString(),
              onChanged: (double value) => setState(() => _speed = value))
        ],
      ),
    );
  }
}

class CirclingRectangle extends StatefulWidget {
  final double speed;

  CirclingRectangle(this.speed);

  @override
  _CirclingRectangleState createState() => _CirclingRectangleState();
}

class _CirclingRectangleState extends State<CirclingRectangle> {
  final int radius = 125;
  double _x = 150;
  double _y = 0;
  int _angle = 0;
  Timer _movingTimer;

  @override
  void initState() {
    super.initState();

    _movingTimer =
        Timer.periodic(Duration(milliseconds: widget.speed.toInt()), (timer) {
      setState(() {
        _x = radius * math.sin(_angle * math.pi / 180);
        _y = radius * math.cos(_angle * math.pi / 180);

        _angle = (_angle == 360) ? 0 : _angle + 1;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Positioned(
          left: _x + 125,
          top: _y + 135,
          child: Container(
            width: 50,
            height: 30,
            decoration: BoxDecoration(
                border: Border.all(color: Colors.green, width: 5)),
          ),
        ),
        Positioned(
            top: 25,
            left: 25,
            child: Container(
              width: 250,
              height: 250,
              decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  border: Border.all(color: Colors.grey)),
            )),
        Container(
          width: 300,
          height: 300,
        )
      ],
    );
  }
}
