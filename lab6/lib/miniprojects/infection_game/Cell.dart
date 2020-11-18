class Cell {
  double x;
  double y;
  double birthTime;

  Cell({this.x, this.y, this.birthTime});

  bool operator ==(cell) =>
      cell is Cell && cell.x == this.x && cell.y == this.y;

  @override
  int get hashCode => (this.x * this.y ~/ this.birthTime).toInt();
}
