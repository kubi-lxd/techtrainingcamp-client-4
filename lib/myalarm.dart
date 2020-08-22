import 'package:flutter/material.dart';

// TODO: This is an empty page.


class MyAlarm extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => new MyAlarmPageState();
}

class MyAlarmPageState extends State<MyAlarm> {
  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      debugShowCheckedModeBanner: false,
      home: new Scaffold(
        appBar: new AppBar(
          title: new Text('⏰闹钟'),
          actions: <Widget>[new Container()],
        ),
        body: new Center(
          child: null,
        ),
      ),
    );
  }
}
