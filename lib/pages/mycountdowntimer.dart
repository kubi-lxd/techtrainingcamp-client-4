import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../stopwatch/fancyButton.dart';

// 倒计时

class MyCountdownTimer extends StatefulWidget {
  @override
  MyCountdownTimerState createState() => MyCountdownTimerState();
}

class MyCountdownTimerState extends State<MyCountdownTimer>
    with TickerProviderStateMixin {
  AnimationController animationController;

  bool iconState = false;
  static final int defaultSeconds = 3;
  int hours = 0, mins = 0, secs = 0;

  final TextEditingController hourTextController =
      new TextEditingController(text: '0');
  final TextEditingController minTextController =
      new TextEditingController(text: '0');
  final TextEditingController secTextController =
      new TextEditingController(text: '${defaultSeconds.toString()}');

  String get timerString {
    Duration duration =
        animationController.duration * animationController.value;
    if (animationController.value == 0.0) {
      // print('finish');
      // do something here when timer is end
    }
    return '${duration.inHours.toString().padLeft(2, '0')}:${(duration.inMinutes % 60).toString().padLeft(2, '0')}:${(duration.inSeconds % 60).toString().padLeft(2, '0')}';
  }

  @override
  void initState() {
    super.initState();
    animationController = AnimationController(
        vsync: this, duration: Duration(seconds: defaultSeconds));
    animationController.value = 1.0;
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: new Scaffold(
        // 防止 keyboard 出现时组件溢出屏幕
        resizeToAvoidBottomInset: false,
        appBar: new AppBar(
          title: new Text('⏳倒计时'),
          actions: <Widget>[new Container()],
        ),
        body: Padding(
          padding: EdgeInsets.all(8.0),
          child: Column(
            children: <Widget>[
              Expanded(
                child: Align(
                  alignment: FractionalOffset.center,
                  child: AspectRatio(
                    aspectRatio: 1.0,
                    child: Stack(
                      children: <Widget>[
                        Positioned.fill(
                          child: AnimatedBuilder(
                            animation: animationController,
                            builder: (BuildContext innerContext, Widget child) {
                              return CustomPaint(
                                painter: TimerPainter(
                                  animation: animationController,
                                  backgroundColor: Colors.white,
                                  color: Theme.of(innerContext).accentColor,
                                  context: context,
                                ),
                              );
                            },
                          ),
                        ),
                        Align(
                          alignment: FractionalOffset.center,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: <Widget>[
                              Text(
                                "🚀Count Down Timer🚀",
                                style: Theme.of(context).textTheme.headline5,
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  // 下面是一个类似于 iOS 的时间选择窗口
                                  /*
                                  Container(
                                    height: 250,
                                    alignment: Alignment.center,
                                    child: CupertinoTimerPicker(
                                      mode: CupertinoTimerPickerMode.hms,
                                      onTimerDurationChanged:
                                          (Duration newTimer) {
                                        setState(() {
                                          print(newTimer.toString());
                                        });
                                      },
                                    ),
                                  ),
                                  */
                                  // 下面是 TextField 输入文本的 GUI
                                  Container(
                                    width: 50,
                                    child: TextField(
                                      controller: hourTextController,
                                      textAlign: TextAlign.center,
                                      style: TextStyle(fontSize: 20),
                                    ),
                                  ),
                                  Text(
                                    "时",
                                    style: TextStyle(fontSize: 25),
                                  ),
                                  Container(
                                    width: 50,
                                    child: TextField(
                                      controller: minTextController,
                                      textAlign: TextAlign.center,
                                      style: TextStyle(fontSize: 20),
                                    ),
                                  ),
                                  Text(
                                    "分",
                                    style: TextStyle(fontSize: 25),
                                  ),
                                  Container(
                                    width: 50,
                                    child: TextField(
                                      controller: secTextController,
                                      textAlign: TextAlign.center,
                                      style: TextStyle(fontSize: 20),
                                    ),
                                  ),
                                  Text(
                                    "秒",
                                    style: TextStyle(fontSize: 25),
                                  ),
                                  Container(
                                    child: RaisedButton(
                                      child: Text(
                                        "设置时间🙂",
                                        style: TextStyle(fontSize: 16),
                                      ),
                                      color: Colors.lightBlue,
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(10),
                                      ),
                                      onPressed: () {
                                        hours =
                                            int.parse(hourTextController.text);
                                        mins =
                                            int.parse(minTextController.text);
                                        secs =
                                            int.parse(secTextController.text);
                                        animationController =
                                            AnimationController(
                                                vsync: this,
                                                duration: Duration(
                                                    seconds: hours * 3600 +
                                                        mins * 60 +
                                                        secs));
                                      },
                                    ),
                                    padding: EdgeInsets.fromLTRB(8, 0, 0, 0),
                                  ),
                                ],
                              ),
                              AnimatedBuilder(
                                  animation: animationController,
                                  builder: (_, Widget child) {
                                    return Text(
                                      timerString,
                                      style:
                                          Theme.of(context).textTheme.headline2,
                                    );
                                  }),
                            ],
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              ),
              Container(
                margin: EdgeInsets.all(8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    FloatingActionButton(
                      child: AnimatedBuilder(
                          animation: animationController,
                          builder: (_, Widget child) {
                            return Icon(
                                iconState ? Icons.stop : Icons.play_arrow);
                          }),
                      onPressed: () {
                        if (animationController.isAnimating) {
                          animationController.stop();
                        } else {
                          animationController.reverse(
                              from: animationController.value == 0.0
                                  ? 1.0
                                  : animationController.value);
                        }

                        setState(() {
                          iconState = (!iconState);
                        });
                      },
                    )
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class TimerPainter extends CustomPainter {
  final Animation<double> animation;
  final Color backgroundColor;
  final Color color;
  BuildContext context;

  TimerPainter({this.animation, this.backgroundColor, this.color, this.context})
      : super(repaint: animation);

  @override
  void paint(Canvas canvas, Size size) {
    Paint paint = Paint()
      ..color = backgroundColor
      ..strokeWidth = 5.0
      ..strokeCap = StrokeCap.round
      ..style = PaintingStyle.stroke;
    const double PI = 3.1415926535;
    canvas.drawCircle(size.center(Offset.zero), size.width / 2.0, paint);
    paint.color = color;
    double progress = (1.0 - animation.value) * 2 * PI;
    canvas.drawArc(Offset.zero & size, PI * 1.5, -progress, false, paint);
    if (animation.value == 0.0) {
      print("finish");
    }
  }

  @override
  bool shouldRepaint(TimerPainter old) {
    return animation.value != old.animation.value ||
        color != old.color ||
        backgroundColor != old.backgroundColor;
  }
}
