import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class RgbInputs extends StatefulWidget {
  final void Function(double red, double green, double blue) applyRgbValues;

  RgbInputs(this.applyRgbValues);

  @override
  _RgbInputsState createState() => _RgbInputsState();
}

class _RgbInputsState extends State<RgbInputs> {
  TextEditingController _red;
  TextEditingController _green;
  TextEditingController _blue;

  void initState() {
    super.initState();
    _red = TextEditingController();
    _red.text = "0";
    _green = TextEditingController();
    _green.text = "0";
    _blue = TextEditingController();
    _blue.text = "0";
  }

  void dispose() {
    _red.dispose();
    _green.dispose();
    _blue.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(children: [
          Container(
              child: TextField(
                  controller: _red,
                  decoration: InputDecoration(labelText: 'RED'),
                  keyboardType: TextInputType.number,
                  inputFormatters: <TextInputFormatter>[
                    FilteringTextInputFormatter.digitsOnly
                  ]),
              width: 100),
          SizedBox(width: 20),
          Container(
              child: TextField(
                  controller: _green,
                  decoration: InputDecoration(labelText: 'GREEN'),
                  keyboardType: TextInputType.number,
                  inputFormatters: <TextInputFormatter>[
                    FilteringTextInputFormatter.digitsOnly
                  ]),
              width: 100),
          SizedBox(width: 20),
          Container(
              child: TextField(
                  controller: _blue,
                  decoration: InputDecoration(labelText: 'BLUE'),
                  keyboardType: TextInputType.number,
                  inputFormatters: <TextInputFormatter>[
                    FilteringTextInputFormatter.digitsOnly
                  ]),
              width: 100),
        ]),
        OutlineButton(
            child: Text('apply'),
            borderSide: BorderSide(color: Colors.black),
            onPressed: () => widget.applyRgbValues(double.parse(_red.text),
                double.parse(_green.text), double.parse(_blue.text)))
      ],
    );
  }
}
