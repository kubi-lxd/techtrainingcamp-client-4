import 'package:flutter/material.dart';
import 'dart:async';

// 正向计时器

class MyTimer extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => new MyTimerState();
}

class MyTimerState extends State<MyTimer> {
  static const duration = const Duration(seconds: 1);

  int secondsPassed = 0;
  bool isActive = false;

  Timer timer;

  void handleTick() {
    if (isActive) {
      setState(() {
        secondsPassed++;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    if (timer == null) {
      timer = Timer.periodic(duration, (Timer t) {
        handleTick();
      });
    }
    int sec = secondsPassed % 60;
    int min = secondsPassed ~/ 60;
    int hour = secondsPassed ~/ 3600;

    return MaterialApp(
      // title: 'Welcome to flutter',
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
          title: Text('🕰计时器'),
        ),
        body: Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  CustomTextContainer(
                    label: 'HRS',
                    value: hour.toString().padLeft(2, '0'), //padLeft 补占位符
                  ),
                  CustomTextContainer(
                    label: 'MIN',
                    value: min.toString().padLeft(2, '0'),
                  ),
                  CustomTextContainer(
                    label: 'SEC',
                    value: sec.toString().padLeft(2, '0'),
                  ),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Container(
                    margin: EdgeInsets.only(top: 20),
                    child: RaisedButton(
                        child: Text(isActive ? 'STOP' : 'START'),
                        onPressed: () {
                          setState(() {
                            isActive = !isActive;
                          });
                        }),
                  ),
                  Container(
                    margin: EdgeInsets.only(top: 20),
                    child: RaisedButton(
                      child: Text("CLEAR"),
                      onPressed: () {
                        setState(() {
                          secondsPassed = 0;
                        });
                      },
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class CustomTextContainer extends StatelessWidget {
  final String label;
  final String value;

  CustomTextContainer({this.label, this.value});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 5),
      padding: EdgeInsets.all(20),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: Colors.black87,
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          Text(
            '$value',
            style: TextStyle(
                color: Colors.white, fontSize: 54, fontWeight: FontWeight.bold),
          ),
          Text(
            "$label",
            style: TextStyle(
              color: Colors.white70,
              // fontSize: 25,
            ),
          )
        ],
      ),
    );
  }
}
