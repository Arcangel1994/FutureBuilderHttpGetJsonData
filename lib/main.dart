import 'package:flutter/material.dart';
import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:futurebuilderhttploading/model/photos.dart';

import './pages/details.dart';

void main() => runApp(MyApp());

class MyApp extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return MyAppStatus();
  }
}

class MyAppStatus extends State<MyApp> {
  final String url = "http://www.somaku.com/photos";
  List<Photos> photos = [];

  Future<List<Photos>> _getPhotos() async {
    var data = await http.get(url);

    var jsonData = json.decode(data.body);

    for (var inf in jsonData) {
      photos.add(Photos(inf['id'], inf['albumId'], inf['title'], inf['url'],
          inf['thumbnailUrl']));
    }

    print(photos.length);

    return photos;
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.indigo,
      ),
      home: Scaffold(
        appBar: AppBar(
          title: Text('HTTP GET'),
        ),
        body: Container(
          child: FutureBuilder(
            future: _getPhotos(),
            builder: (BuildContext context, AsyncSnapshot snapshot) {
              if (snapshot.data == null) {
                return Container(
                  child: Center(
                    child: CircularProgressIndicator(),
                  ),
                );
              } else {
                return ListView.builder(
                  itemCount: snapshot.data.length,
                  itemBuilder: (BuildContext context, int index) {
                    return ListTile(
                      leading: CircleAvatar(
                        backgroundImage: NetworkImage(snapshot.data[index].url),
                      ),
                      title: Text(snapshot.data[index].title),
                      subtitle: Text(snapshot.data[index].thumbnailUrl),
                      onTap: () {

                        Navigator.of(context).push(MaterialPageRoute(builder: (context) => DetailPage(snapshot.data[index]) ));

                      },
                    );
                  },
                );
              }
            },
          ),
        ),
      ),
    );
  }
}
