import 'DirectionEnum.dart';

class SnakeCell {
  double x;
  double y;
  Direction direction;

  SnakeCell(this.x, this.y, this.direction);

  void updateCoordinates() {
    switch (this.direction) {
      case Direction.Up:
        this.y--;
        break;
      case Direction.Down:
        this.y++;
        break;
      case Direction.Right:
        this.x++;
        break;
      case Direction.Left:
        this.x--;
        break;
      default:
    }
  }

  int positionInArr(int matrixSize) {
    return (x + matrixSize * y).toInt();
  }
}