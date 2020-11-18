import 'package:flutter/material.dart';
import 'package:flutter_app/miniprojects/snake_game/Game.dart';

class SpeedMenu extends StatelessWidget {
  final List<String> speedModes = <String>['Slow', 'Normal', 'Fast'];
  final List<int> speed = <int>[1000, 500, 100];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Choose speed"),
        ),
        body: ListView.separated(
          padding: const EdgeInsets.all(8),
          itemCount: speedModes.length,
          itemBuilder: (BuildContext context, int index) {
            return FlatButton(
              height: 50,
              color: Colors.blue,
              child: Center(
                  child: Text(
                speedModes[index],
                style: TextStyle(color: Colors.white),
              )),
              onPressed: () => Navigator.push(context,
                  MaterialPageRoute(builder: (context) => Game(speed[index]))),
            );
          },
          separatorBuilder: (BuildContext context, int index) =>
              const Divider(),
        ));
  }
}
