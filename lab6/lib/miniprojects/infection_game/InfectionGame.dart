import 'dart:async';
import 'package:flutter/material.dart';
import 'Cell.dart';
import 'Infection.dart';
import 'InfectionPainter.dart';

class InfectionGame extends StatefulWidget {
  @override
  _InfectionGameState createState() => _InfectionGameState();
}

class _InfectionGameState extends State<InfectionGame>
    with TickerProviderStateMixin {
  double time = 0;
  Timer _movingTimer;

  Infection infection = Infection();

  @override
  void initState() {
    super.initState();

    // initialize
    Future.delayed(Duration.zero, () {
      double screenWidth = MediaQuery.of(context).size.width;
      infection.infectedCells
          .add(Cell(x: screenWidth / 2, y: screenWidth / 2, birthTime: time));
    });

    // game routine
    _movingTimer = Timer.periodic(Duration(milliseconds: 100), (timer) {
      if (time != 0 &&
          infection.infectedCells.length == 0 &&
          infection.immuneCells.length == 0) timer.cancel();

      setState(() => time++);
    });
  }

  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      painter: InfectionPainter(infection, time),
    );
  }
}
