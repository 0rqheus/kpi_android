import 'dart:async';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:path/path.dart';
import 'package:photofilters/photofilters.dart';
import 'package:image/image.dart' as imageLib;
import 'package:image_picker/image_picker.dart';
import '../preset_filters/matrix_filters.dart';

class MatrixFilters extends StatefulWidget {
  @override
  _MatrixFiltersState createState() => new _MatrixFiltersState();
}

class _MatrixFiltersState extends State<MatrixFilters> {
  File imageFile;
  List<Filter> filters = myConvolutionFilters;

  Future getImage(context) async {
    imageFile = await ImagePicker.pickImage(source: ImageSource.gallery);
    var image = imageLib.decodeImage(imageFile.readAsBytesSync());

    Map processedImages = await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => PhotoFilterSelector(
          title: Text('Matrix filters'),
          image: image,
          filters: filters,
          filename: basename(imageFile.path),
          loader: Center(child: CircularProgressIndicator()),
          fit: BoxFit.contain,
        ),
      ),
    );

    if (processedImages != null &&
        processedImages.containsKey('image_filtered'))
      setState(() => imageFile = processedImages['image_filtered']);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Matrix filters'),
      ),
      body: Center(
        child: imageFile == null
            ? Text('No image selected.')
            : Container(child: Image.file(imageFile)),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => getImage(context),
        tooltip: 'Pick Image',
        child: Icon(Icons.add_a_photo),
      ),
    );
  }
}
