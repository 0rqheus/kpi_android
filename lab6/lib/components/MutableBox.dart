import 'package:flutter/material.dart';
import 'dart:async';
import 'dart:math';

class MutableRectangle extends StatefulWidget {
  final int startX;
  final int startY;

  MutableRectangle(this.startX, this.startY);

  @override
  _MutableRectangleState createState() => _MutableRectangleState();
}

class _MutableRectangleState extends State<MutableRectangle> {
  final double targetWidth = 120;
  final double targetHeight = 80;
  final int movingStep = 1;
  Timer _movingTimer;

  double _borderWidth = 1;
  Color _borderColor = Colors.black;

  bool _isMovingRight = true;
  bool _isMovingDown = true;
  int topOffset;
  int leftOffset;

  @override
  void initState() {
    super.initState();

    topOffset = widget.startY;
    leftOffset = widget.startX;

    _movingTimer = Timer.periodic(Duration(milliseconds: 10), (timer) {
      if (topOffset >=
          MediaQuery.of(context).size.height - (targetWidth + 30)) {
        _isMovingDown = false;
        modifyBorder();
      }

      if (topOffset <= 0) {
        _isMovingDown = true;
        modifyBorder();
      }

      if (leftOffset >=
          MediaQuery.of(context).size.width - (targetHeight + 30)) {
        _isMovingRight = false;
        modifyBorder();
      }

      if (leftOffset <= 0) {
        _isMovingRight = true;
        modifyBorder();
      }

      setState(() {
        topOffset =
            _isMovingDown ? (topOffset + movingStep) : (topOffset - movingStep);

        leftOffset = _isMovingRight
            ? (leftOffset + movingStep)
            : (leftOffset - movingStep);
      });
    });
  }

  modifyBorder() {
    setState(() {
      _borderColor =
          Color((Random().nextDouble() * 0xFFFFFF).toInt()).withOpacity(1.0);

      _borderWidth = Random().nextInt(10).toDouble();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Positioned(
      top: topOffset.toDouble(),
      left: leftOffset.toDouble(),
      child: Container(
        width: targetWidth,
        height: targetHeight,
        decoration: BoxDecoration(
            border: Border.all(color: _borderColor, width: _borderWidth)),
      ),
    );
  }
}
