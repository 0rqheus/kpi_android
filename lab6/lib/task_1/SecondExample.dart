import 'package:flutter/material.dart';
import '../components/MutableBox.dart';

class SecondExample extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Example 2")),
      body: Stack(
        children: [MutableRectangle(0, 0), MutableRectangle(100, 200)],
      ),
    );
  }
}
