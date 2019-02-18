import 'package:flutter/material.dart';
import 'package:futurebuilderhttploading/model/photos.dart';

class DetailPage extends StatelessWidget {
  final Photos photo;

  DetailPage(this.photo);

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        title: Text('${photo.title}'),
      ),
    );
  }
}
