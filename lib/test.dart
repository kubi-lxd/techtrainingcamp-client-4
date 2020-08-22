import 'package:flutter/material.dart';
import 'package:flutter_ringtone_player/flutter_ringtone_player.dart';

class EmptyPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => new EmptyPageState();
}

class EmptyPageState extends State<EmptyPage> {
  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      home: new Scaffold(
        appBar: new AppBar(
          title: new Text('空页'),
          actions: <Widget>[new Container()],
        ),
        body: new Center(
          child: RaisedButton(
            child: Text('Test'),
            onPressed: () {
              FlutterRingtonePlayer.playNotification();
            },
          ),
        ),
      ),
    );
  }
}
