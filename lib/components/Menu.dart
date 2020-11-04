import 'package:flutter/material.dart';

class Menu extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Main menu'),
      ),
      body: ListView(
        padding: const EdgeInsets.all(8),
        children: <Widget>[
          FlatButton(
              onPressed: () => Navigator.pushNamed(context, '/custom_rgb'),
              child: const Center(child: Text('Custom RGB')),
              height: 50,
              color: Colors.blue,
              textColor: Colors.white),
          Divider(),
          FlatButton(
              onPressed: () => Navigator.pushNamed(context, '/opacity'),
              child: const Center(child: Text('Opacity')),
              height: 50,
              color: Colors.blue,
              textColor: Colors.white),
          Divider(),
          FlatButton(
              onPressed: () => Navigator.pushNamed(context, '/color_filters'),
              child: const Center(child: Text('Color filters')),
              height: 50,
              color: Colors.blue,
              textColor: Colors.white),
          Divider(),
          FlatButton(
              onPressed: () => Navigator.pushNamed(context, '/matrix_filters'),
              child: const Center(child: Text('Matrix filters')),
              height: 50,
              color: Colors.blue,
              textColor: Colors.white),
        ],
      ),
    );
  }
}
