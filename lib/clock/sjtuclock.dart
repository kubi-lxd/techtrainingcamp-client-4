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

final AssetProvider assetProvider =
    AssetFlare(bundle: rootBundle, name: 'assets/SJTUClock4.flr');

class SJTUClockPage extends StatefulWidget {
  SJTUClockPage();

  @override
  _SJTUClockPage createState() => _SJTUClockPage();
}

class _SJTUClockPage extends State<SJTUClockPage> {
  static final TimeAnimationController _animationController =
      TimeAnimationController();

  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      debugShowCheckedModeBanner: false,
      home: new Scaffold(
        appBar: new AppBar(
          title: new Text('⌚时钟'),
        ),
        body: Stack(
          children: <Widget>[
            Container(
                alignment: Alignment.center,
                child: new Image.asset('assets/test.jpg',
                    fit: BoxFit.cover,
                    width: double.infinity,
                    height: double.infinity)),
            Container(
              alignment: Alignment.center,
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
                    : FlareActor('assets/SJTUClock4.flr',
                        animation: 'rotate', controller: _animationController);
              }),
            ),
          ],
        ),
      ),
    );
  }
}

class TimeAnimationController extends FlareController {
  TimeAnimationController();

  static ActorAnimation _time;

  static const double _dontMixAnimations = 1.0;

  DateTime now;

  @override
  void initialize(FlutterActorArtboard artboard) {
    _time = artboard.getAnimation('time');
  }

  @override
  bool advance(FlutterActorArtboard artboard, double elapsed) {
    now = DateTime.now();
    _time.apply(now.second / 60 + now.minute + now.hour * 60, artboard,
        _dontMixAnimations);
    return true;
  }

  @override
  void setViewTransform(Mat2D viewTransform) {}
}
