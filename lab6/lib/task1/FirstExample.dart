import 'package:flutter/material.dart';
import '../components/MutableBox.dart';

class FirstExample extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Example 1")),
      body: Stack(
        children: [MutableRectangle(0, 0)],
      ),
    );
  }
}


