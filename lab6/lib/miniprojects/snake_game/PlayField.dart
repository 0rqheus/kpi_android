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

  foodPositions.forEach((food) {
    list[food] = Container(
      child: Card(
        color: Colors.red,
      ),
    );
  });

  list[snake.head.positionInArr(fieldSize)] = Container(
    child: Card(
      color: Colors.teal[900],
    ),
  );
  for (int i = 1; i < snake.cells.length - 1; i++) {
    list[snake.cells[i].positionInArr(fieldSize)] = Container(
      child: Card(
        color: Colors.teal,
      ),
    );
  }

  list[snake.tail.positionInArr(fieldSize)] = Container(
    child: Card(
      color: Colors.teal[200],
    ),
  );

  return list;
}
