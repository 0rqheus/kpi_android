import 'dart:async';
import 'dart:math';
import 'package:flutter/material.dart';
import 'MutableCircle.dart';

class SyncDuoMutableBoxes extends StatefulWidget {
  @override
  _SyncDuoMutableBoxesState createState() => _SyncDuoMutableBoxesState();
}

class _SyncDuoMutableBoxesState extends State<SyncDuoMutableBoxes> {
  final double boxWidth = 100;
  final double boxHeight = 70;
  final int movingStep = 1;
  Timer _movingTimer;

  double _borderWidth = 1;
  Color _borderColor = Colors.black;

  bool _isMovingRight = true;
  bool _isMovingDown = true;
  int topOffset = 0;
  int leftOffset1 = 0;
  int leftOffset2 = 180;

  int circleTopOffset = 10;
  int circleLeftOffset = 10;

  @override
  void initState() {
    super.initState();

    _movingTimer = Timer.periodic(Duration(milliseconds: 10), (timer) {
      if (topOffset >= MediaQuery.of(context).size.height - (boxWidth + 30)) {
        _isMovingDown = false;
        modifyBorderAndCircle();
      }

      if (topOffset <= 0) {
        _isMovingDown = true;
        modifyBorderAndCircle();
      }

      if (leftOffset2 >= MediaQuery.of(context).size.width - (boxHeight + 30)) {
        _isMovingRight = false;
        modifyBorderAndCircle();
      }

      if (leftOffset1 <= 0) {
        _isMovingRight = true;
        modifyBorderAndCircle();
      }

      setState(() {
        topOffset =
            _isMovingDown ? (topOffset + movingStep) : (topOffset - movingStep);

        leftOffset1 = _isMovingRight
            ? (leftOffset1 + movingStep)
            : (leftOffset1 - movingStep);

        leftOffset2 = _isMovingRight
            ? (leftOffset2 + movingStep)
            : (leftOffset2 - movingStep);
      });
    });
  }

  modifyBorderAndCircle() {
    setState(() {
      _borderColor =
          Color((Random().nextDouble() * 0xFFFFFF).toInt()).withOpacity(1.0);

      _borderWidth = Random().nextInt(10).toDouble();

      circleTopOffset = Random().nextInt(40) + 10;
      circleLeftOffset = Random().nextInt(70) + 10;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Positioned(
          top: topOffset.toDouble(),
          left: leftOffset1.toDouble(),
          child: Container(
            width: boxWidth,
            height: boxHeight,
            decoration: BoxDecoration(
                border: Border.all(color: _borderColor, width: _borderWidth)),
            child: Stack(children: [
              MutableCircle(
                  x: circleLeftOffset,
                  y: circleTopOffset,
                  borderColor: _borderColor,
                  borderWidth: _borderWidth)
            ]),
          ),
        ),
        Positioned(
          top: topOffset.toDouble(),
          left: leftOffset2.toDouble(),
          child: Container(
            width: boxWidth,
            height: boxHeight,
            decoration: BoxDecoration(
                border: Border.all(color: _borderColor, width: _borderWidth)),
            child: Stack(children: [
              MutableCircle(
                  x: circleLeftOffset,
                  y: circleTopOffset,
                  borderColor: _borderColor,
                  borderWidth: _borderWidth)
            ]),
          ),
        )
      ],
    );
  }
}
