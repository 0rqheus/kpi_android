import 'package:flutter/material.dart';
import 'Snake.dart';

List<Widget> createPlayField(
    int fieldSize, Snake snake, List<int> foodPositions) {
  var list = List.generate(fieldSize * fieldSize, (index) {
    return Container(
      child: Card(
        color: Colors.white,
      ),
    );
  });

  print(foodPositions);

  foodPositions.forEach((food) {
    list[food] = Container(
      child: Card(
        color: Colors.red,
      ),
    );
  });

  snake.cells.forEach((cell) {
    list[cell.positionInArr(fieldSize)] = Container(
      child: Card(
        color: Colors.teal[800],
      ),
    );
  });

  return list;
}
