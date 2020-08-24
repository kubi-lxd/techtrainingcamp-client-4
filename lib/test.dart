import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:fluttertoast/fluttertoast.dart';
// import 'package:flutter_beep/flutter_beep.dart';
// import 'package:flutter_ringtone_player/flutter_ringtone_player.dart';

// for testing flutter alert windows
final navigatorKey = GlobalKey<NavigatorState>();

class EmptyPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => new EmptyPageState();
}

class EmptyPageState extends State<EmptyPage> {
  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      navigatorKey: navigatorKey,
      home: new Scaffold(
          appBar: new AppBar(
            title: new Text('空页'),
            actions: <Widget>[new Container()],
          ),
          body: new Center(
            child: RaisedButton(
              child: Text("Beep Success"),
              onPressed: () {
                showMyDialog();
              },
            ),
          )),
    );
  }
}

void showMyDialog() {
  showDialog(
      context:
          navigatorKey.currentState.overlay.context, // Using overlay's context
      child: Center(
        child: Material(
          color: Colors.white,
          child: Text('🙂🙂🙂🙂',
          style: TextStyle(fontSize: 50),),
        ),
      ));
}
