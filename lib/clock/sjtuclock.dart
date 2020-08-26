import 'package:flutter/material.dart';
import 'package:flutter/services.dart'
    show SystemChrome, DeviceOrientation, SystemUiOverlay, rootBundle;
import 'package:flare_flutter/flare.dart';
import 'package:flare_flutter/provider/asset_flare.dart';
import 'package:flare_flutter/flare_actor.dart';
import 'package:flare_flutter/flare_controller.dart';
import 'package:flare_flutter/flare_cache_builder.dart';
import 'package:flare_dart/math/mat2d.dart' show Mat2D;
// import 'package:flutter/foundation.dart';
import 'package:flare_flutter/asset_provider.dart';

enum TimeZone {
  local,
  UTC,
}
final AssetProvider assetProvider =
    AssetFlare(bundle: rootBundle, name: 'assets/SJTUClock6.flr');

// void main() {
//   WidgetsFlutterBinding.ensureInitialized();
//   SystemChrome.setEnabledSystemUIOverlays(
//       []); //全屏，SystemUiOverlay.top, SystemUiOverlay.bottom
//   //横屏
//   //SystemChrome.setPreferredOrientations([DeviceOrientation.landscapeRight, DeviceOrientation.landscapeLeft]).then((_) {runApp(MyApp());});
//   SystemChrome.setPreferredOrientations(
//       [DeviceOrientation.portraitDown, DeviceOrientation.portraitUp]).then((_) {
//     runApp(MyApp());
//   });
// }

// class MyApp extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       debugShowCheckedModeBanner: false,
//       home: SJTUClockPage(),
//     );
//   }
// }

class SJTUClockPage extends StatefulWidget {
  SJTUClockPage();

  @override
  _SJTUClockPage createState() => _SJTUClockPage();
}

class _SJTUClockPage extends State<SJTUClockPage> {
  //动画控制器
  static final TimeAnimationController _animationController =
      TimeAnimationController();
  //背景控制器
  bool dayOrNight;
  //时区选择状态参数
  String _checkedValue;

  @override
  void initState() {
    super.initState();
    _checkedValue = 'local';
    changeTimeZone('local');
  }

  void changeTimeZone(String value) {
    showCheckedState(value);
    _animationController.localTimeFlag = false;
    switch (value) {
      case 'local':
        _animationController.localTimeFlag = true;
        _animationController.timeOffset = 0;
        break;
      case 'UTC':
        _animationController.timeOffset = -8;
        break;
      case 'US':
        _animationController.timeOffset = -13;
        break;
      case 'Tokyo':
        _animationController.timeOffset = 1;
        break;
      case 'Moscow':
        _animationController.timeOffset = -5;
        break;
      case 'Wellington':
        _animationController.timeOffset = 4;
        break;
      case 'West12':
        _animationController.timeOffset = -20;
        break;
    }
    int curTime = DateTime.now()
        .add(new Duration(hours: _animationController.timeOffset))
        .hour;
    dayOrNight = curTime >= 6 && curTime <= 18;
    setState(() {});
  }

  bool isChecked(String value) => _checkedValue == value;
  void showCheckedState(String value) {
    _checkedValue = value;
  }

  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
        debugShowCheckedModeBanner: false,
        title: '时钟',
        home: new Scaffold(
          appBar: new AppBar(
            title: new Text('⌚时钟'),
            actions: <Widget>[
              new PopupMenuButton<String>(
                icon: Icon(Icons.history),
                onSelected: (String value) {
                  changeTimeZone(value);
                },
                itemBuilder: (BuildContext context) => <PopupMenuEntry<String>>[
                  CheckedPopupMenuItem(
                    checked: isChecked('local'),
                    value: 'local',
                    child: new Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: <Widget>[
                        new Text('上海时区(+8:00)'),
                      ],
                    ),
                  ),
                  new PopupMenuDivider(height: 1.0),
                  CheckedPopupMenuItem(
                    checked: isChecked('UTC'),
                    value: 'UTC',
                    child: new Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: <Widget>[
                        new Text('全球标准时间(UTC)'),
                      ],
                    ),
                  ),
                  new PopupMenuDivider(height: 1.0),
                  CheckedPopupMenuItem(
                    checked: isChecked('US'),
                    value: 'US',
                    child: new Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: <Widget>[
                        new Text('纽约时区(-5:00)'),
                      ],
                    ),
                  ),
                  new PopupMenuDivider(height: 1.0),
                  CheckedPopupMenuItem(
                    checked: isChecked('Tokyo'),
                    value: 'Tokyo',
                    child: new Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: <Widget>[
                        new Text('东京时区(+9:00)'),
                      ],
                    ),
                  ),
                  new PopupMenuDivider(height: 1.0),
                  CheckedPopupMenuItem(
                    checked: isChecked('Moscow'),
                    value: 'Moscow',
                    child: new Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: <Widget>[
                        new Text('莫斯科时区(+3:00)'),
                      ],
                    ),
                  ),
                  new PopupMenuDivider(height: 1.0),
                  CheckedPopupMenuItem(
                    checked: isChecked('Wellington'),
                    value: 'Wellington',
                    child: new Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: <Widget>[
                        new Text('惠灵顿时区(+12:00)'),
                      ],
                    ),
                  ),
                  new PopupMenuDivider(height: 1.0),
                  CheckedPopupMenuItem(
                    checked: isChecked('West12'),
                    value: 'West12',
                    child: new Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: <Widget>[
                        new Text('西十二区(-12:00)'),
                      ],
                    ),
                  )
                ],
              )
            ],
          ),
          body: Stack(
            children: <Widget>[
              Container(
                  alignment: Alignment.center,
                  child: dayOrNight
                      ? new Image.asset('assets/day.jpeg',
                          fit: BoxFit.cover,
                          width: double.infinity,
                          height: double.infinity)
                      : new Image.asset('assets/night.jpg',
                          fit: BoxFit.cover,
                          width: double.infinity,
                          height: double.infinity)),
              Container(
                alignment: Alignment.topCenter,
                child: FlareCacheBuilder([assetProvider],
                    builder: (context, bool _isWarm) {
                  return !_isWarm
                      ? Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            CircularProgressIndicator(
                                backgroundColor: Colors.brown[200]),
                            SizedBox(height: 10.0),
                          ],
                        )
                      : FlareActor('assets/SJTUClock6.flr',
                          alignment: Alignment.topCenter,
                          animation: 'rotate',
                          controller: _animationController);
                }),
              ),
            ],
          ),
        ));
  }
}

class TimeAnimationController extends FlareController {
  TimeAnimationController();

  static ActorAnimation _time;

  bool localTimeFlag = true;
  int timeOffset = 0;

  static FlareAnimationLayer _totalrotate;

  static const double _dontMixAnimations = 1.0;

  DateTime now;

  @override
  void initialize(FlutterActorArtboard artboard) {
    _time = artboard.getAnimation('time');
    _totalrotate = FlareAnimationLayer()
      ..animation = artboard.getAnimation('totalrotate')
      ..mix = _dontMixAnimations;
  }

  @override
  bool advance(FlutterActorArtboard artboard, double elapsed) {
    now = DateTime.now();
    if (localTimeFlag == false) {
      now = now.add(new Duration(hours: timeOffset));
    }
    _totalrotate.time = (_totalrotate.time + elapsed) % _totalrotate.duration;
    _totalrotate.apply(artboard);
    _time.apply(now.second / 60 + now.minute + now.hour * 60, artboard,
        _dontMixAnimations);
    return true;
  }

  @override
  void setViewTransform(Mat2D viewTransform) {}
}
