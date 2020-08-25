import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'dart:convert';

class WeatherPage extends StatefulWidget {
  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  @override
  State<StatefulWidget> createState() {
    return new WeatherState();
  }
}

class WeatherPage_3d extends StatefulWidget {
  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  @override
  State<StatefulWidget> createState() {
    return new WeatherState_3d();
  }
}

class WeatherState extends State<WeatherPage> {
  WeatherData weather = WeatherData.empty();

  WeatherState() {
    _getWeather();
  }

  void _getWeather() async {
    WeatherData data = await _fetchWeather();
    setState(() {
      weather = data;
    });
  }

  Future<WeatherData> _fetchWeather() async {
    print('start fetching');
    final response = await get(
        'https://devapi.heweather.net/v7/weather/now?location=101020100&key=615fef66d131450fb6e21722544ebb0e');
    print('fetching completed');
    if (response.statusCode == 200) {
      var content = json.decode(response.body);
      if (content['code'] == "200") {
        return WeatherData.fromJson(content);
      } else {
        print("Error code: $content['code']");
      }
    } else {
      print('fetching failed');
      return WeatherData.empty();
    }
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: new Scaffold(
        appBar: AppBar(
          title: Text("🌞天气"),
        ),
        body: new Stack(
          fit: StackFit.expand,
          children: <Widget>[
            new Image.asset(
              "images/weather_bg.jpg",
              fit: BoxFit.fill
            ),
            new Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                new Container(
                  width: double.infinity,
                  margin: EdgeInsets.only(top: 30.0),
                  child: new Text(
                    "📍上海市",
                    textAlign: TextAlign.center,
                    style: new TextStyle(
                      color: Colors.white,
                      fontSize: 30.0,
                    ),
                  ),
                ),
                new Container(
                  width: double.infinity,
                  margin: EdgeInsets.only(top: 50.0),
                  child: new Column(
                    children: <Widget>[
                      new Text(weather?.tmp,
                          style: new TextStyle(
                              color: Colors.white, fontSize: 80.0)),
                      new Image.asset(
                        "icons/${weather?.icon}.png",
                        fit: BoxFit.fitHeight,
                      ),
                      new Text(weather?.cond,
                          style: new TextStyle(
                              color: Colors.white, fontSize: 45.0)),
                      new Text(
                        weather?.hum,
                        style:
                            new TextStyle(color: Colors.white, fontSize: 30.0),
                      )
                    ],
                  ),
                ),
                new Container(
                  width: double.infinity,
                  margin: EdgeInsets.only(top: 80.0),
                  alignment: Alignment.bottomRight,
                  child: RaisedButton(
                    child: Text("查看未来天气"),
                    textColor: Colors.white,
                    color: Colors.transparent,
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => WeatherPage_3d()));
                    },
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}

class WeatherState_3d extends State<WeatherPage_3d> {
  WeatherData_3d weather = WeatherData_3d.empty();

  WeatherState_3d() {
    _getWeather_3d();
  }

  void _getWeather_3d() async {
    WeatherData_3d data = await _fetchWeather_3d();
    setState(() {
      weather = data;
    });
  }

  Future<WeatherData_3d> _fetchWeather_3d() async {
    print('start fetching');
    final response = await get(
        'https://devapi.heweather.net/v7/weather/3d?location=101020100&key=615fef66d131450fb6e21722544ebb0e');
    print('fetching completed');
    if (response.statusCode == 200) {
      var content = json.decode(response.body);
      if (content['code'] == "200") {
        return WeatherData_3d.fromJson(content);
      } else {
        print(content['code']);
      }
    } else {
      print('failed');
      return WeatherData_3d.empty();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: new Stack(
        fit: StackFit.expand,
        children: <Widget>[
          new Image.asset(
            "images/weather_bg.jpg",
            fit: BoxFit.fill
          ),
          new Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              new Container(
                width: double.infinity,
                // margin: EdgeInsets.only(top: 40.0),
                margin: EdgeInsets.fromLTRB(0, 130, 0, 40),
                child: new Text(
                  "📍上海市",
                  textAlign: TextAlign.center,
                  style: new TextStyle(
                    color: Colors.white,
                    fontSize: 30.0,
                  ),
                ),
              ),
              new Container(
                width: double.infinity,
                // margin: EdgeInsets.only(top: 100.0),
                child: new Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      new Container(
                        margin: EdgeInsets.only(left: 5.0),
                        child: new Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            new Text(weather?.date0 + '\n',
                                style: new TextStyle(
                                    color: Colors.white, fontSize: 30.0)),
                            new Image.asset(
                              "icons/${weather?.iconDay0}.png",
                              fit: BoxFit.fitHeight,
                            ),
                            new Text(weather?.cond0 + '\n',
                                style: new TextStyle(
                                    color: Colors.white, fontSize: 30.0)),
                            new Text(
                                '${weather?.tmpMin0} - ${weather?.tmpMax0}',
                                style: new TextStyle(
                                    color: Colors.white, fontSize: 30.0)),
                          ],
                        ),
                      ),
                      new Container(
                        margin: EdgeInsets.only(left: 5.0),
                        child: new Column(
                          children: <Widget>[
                            new Text(weather?.date1 + '\n',
                                style: new TextStyle(
                                    color: Colors.white, fontSize: 30.0)),
                            new Image.asset(
                              "icons/${weather?.iconDay1}.png",
                              fit: BoxFit.fitHeight,
                            ),
                            new Text(weather?.cond1 + '\n',
                                style: new TextStyle(
                                    color: Colors.white, fontSize: 30.0)),
                            new Text(
                                '${weather?.tmpMin1} - ${weather?.tmpMax1}',
                                style: new TextStyle(
                                    color: Colors.white, fontSize: 30.0)),
                          ],
                        ),
                      ),
                      new Container(
                        margin: EdgeInsets.only(left: 5.0),
                        child: new Column(
                          children: <Widget>[
                            new Text(weather?.date2 + '\n',
                                style: new TextStyle(
                                    color: Colors.white, fontSize: 30.0)),
                            new Image.asset(
                              "icons/${weather?.iconDay2}.png",
                              fit: BoxFit.fitHeight,
                            ),
                            new Text(weather?.cond2 + '\n',
                                style: new TextStyle(
                                    color: Colors.white, fontSize: 30.0)),
                            new Text(
                                '${weather?.tmpMin2} - ${weather?.tmpMax2}',
                                style: new TextStyle(
                                    color: Colors.white, fontSize: 30.0)),
                          ],
                        ),
                      ),
                    ]),
              ),
              new Container(
                width: double.infinity,
                // margin: EdgeInsets.only(top: 100.0),
                alignment: Alignment.bottomLeft,
                child: RaisedButton(
                    textColor: Colors.white,
                    color: Colors.transparent,
                    child: Text("返回当前天气"),
                    onPressed: () {
                      Navigator.pop(context);
                    }),
              ),
            ],
          )
        ],
      ),
    );
  }
}

class WeatherData {
  String cond; //天气
  String tmp; //温度
  String hum; //湿度
  String icon;

  WeatherData({this.cond, this.tmp, this.hum, this.icon});

  factory WeatherData.fromJson(Map<String, dynamic> json) {
    return WeatherData(
      cond: json['now']['text'],
      tmp: json['now']['temp'] + "°",
      hum: "湿度  " + json['now']['humidity'] + "%",
      icon: json['now']['icon'],
    );
  }

  factory WeatherData.empty() {
    return WeatherData(
      cond: "载入中",
      tmp: "",
      icon: "103",
      hum: "",
    );
  }
}

class WeatherData_3d {
  String date0;
  String cond0; //天气
  String iconDay0;
  String tmpMax0; //温度
  String tmpMin0; //温度
  String date1;
  String cond1; //天气
  String iconDay1;
  String tmpMax1; //温度
  String tmpMin1; //温度
  String date2;
  String cond2; //天气
  String iconDay2;
  String tmpMax2; //温度
  String tmpMin2; //温度

  WeatherData_3d(
      {this.cond0,
      this.cond1,
      this.cond2,
      this.tmpMax0,
      this.tmpMax1,
      this.tmpMax2,
      this.tmpMin0,
      this.tmpMin1,
      this.tmpMin2,
      this.date0,
      this.date1,
      this.date2,
      this.iconDay0,
      this.iconDay1,
      this.iconDay2});

  factory WeatherData_3d.fromJson(Map<String, dynamic> json) {
    return WeatherData_3d(
      date0: json['daily'][0]['fxDate'].substring(5),
      cond0: json['daily'][0]['textDay'],
      iconDay0: json['daily'][0]['iconDay'],
      tmpMax0: json['daily'][0]['tempMax'] + "°",
      tmpMin0: json['daily'][0]['tempMin'] + "°",
      cond1: json['daily'][1]['textDay'],
      iconDay1: json['daily'][1]['iconDay'],
      date1: json['daily'][1]['fxDate'].substring(5),
      tmpMax1: json['daily'][1]['tempMax'] + "°",
      tmpMin1: json['daily'][1]['tempMin'] + "°",
      date2: json['daily'][2]['fxDate'].substring(5),
      cond2: json['daily'][2]['textDay'],
      iconDay2: json['daily'][2]['iconDay'],
      tmpMax2: json['daily'][2]['tempMax'] + "°",
      tmpMin2: json['daily'][2]['tempMin'] + "°",
    );
  }

  factory WeatherData_3d.empty() {
    return WeatherData_3d(
      date0: "",
      cond0: "载入中",
      iconDay0: "103",
      tmpMax0: "",
      tmpMin0: "",
      date1: "",
      cond1: "载入中",
      iconDay1: "303",
      tmpMax1: "",
      tmpMin1: "",
      date2: "",
      cond2: "载入中",
      iconDay2: "403",
      tmpMax2: "",
      tmpMin2: "",
    );
  }
}
