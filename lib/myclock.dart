import 'package:flutter/material.dart';

// TODO: This is an empty page.

class MyClock extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => new MyClockPageState();
}

class MyClockPageState extends State<MyClock> {
  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      debugShowCheckedModeBanner: false,
      home: new Scaffold(
        appBar: new AppBar(
          title: new Text('⌚时钟'),
          actions: <Widget>[new Container()],
        ),
        body: new Center(
          child: null,
        ),
      ),
    );
  }
}
