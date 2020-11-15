import 'package:flutter/material.dart';

class MutableCircle extends StatefulWidget {
  final Color borderColor;
  final double borderWidth;
  final int x;
  final int y;

  MutableCircle({this.x, this.y, this.borderColor, this.borderWidth});

  @override
  _MutableCircleState createState() => _MutableCircleState();
}

class _MutableCircleState extends State<MutableCircle> {
  final double circleRadius = 20;

  @override
  Widget build(BuildContext context) {
    return Positioned(
      top: widget.y.toDouble(),
      left: widget.x.toDouble(),
      child: Container(
        width: circleRadius,
        height: circleRadius,
        decoration: BoxDecoration(
            shape: BoxShape.circle,
            border: Border.all(
                color: widget.borderColor, width: widget.borderWidth)),
      ),
    );
  }
}
