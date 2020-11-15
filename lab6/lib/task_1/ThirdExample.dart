import 'package:flutter/material.dart';
import '../components/SyncDuoMutableBoxes.dart';

class ThirdExample extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Example 3")),
      body: SyncDuoMutableBoxes(),
    );
  }
}
