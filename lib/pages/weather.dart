import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'dart:convert';

class ProvideWidget extends StatefulWidget {
  ProvideWidget({
    Key key,
  }) : super(key: key);

  @override
  _ProvideWidgetState createState() => _ProvideWidgetState();
}

class _ProvideWidgetState extends State<ProvideWidget> {
  TextEditingController _decController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).requestFocus(FocusNode());
      },
      child: Scaffold(
          backgroundColor: Colors.blue,
          body: Stack(children: <Widget>[
            Image.asset(
              "images/weather_bg.jpg",
              fit: BoxFit.fill,
            ),
            Container(
                padding: EdgeInsets.symmetric(horizontal: 40, vertical: 20),
                child: Stack(
                  children: <Widget>[
                    Positioned(
                      child: Container(
                        decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.all(Radius.circular(5))),
                        child: Column(
                          children: <Widget>[
                            SizedBox(
                              height: 20,
                            ),
                            Container(
                              padding: EdgeInsets.symmetric(horizontal: 20),
                              child: Row(
                                children: <Widget>[
                                  Text(
                                    '城市：',
                                    style: TextStyle(
                                        fontSize: 14,
                                        fontWeight: FontWeight.bold,
                                        color: Color(0XFF333333),
                                        decoration: TextDecoration.none),
                                  ),
                                  Expanded(
                                    child: Container(
                                      height: 30.0,
                                      width: 150.0,
                                      decoration: BoxDecoration(
                                        color: Colors.white,
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(5)),
                                      ),
                                      child: TextField(
                                        controller: _decController,
                                        textAlign: TextAlign.center,
                                        style: TextStyle(
                                          color: Colors.black,
                                          fontSize: 14.0,
                                        ),
                                        decoration: InputDecoration(
                                          enabledBorder: OutlineInputBorder(
                                            borderRadius: BorderRadius.all(
                                              Radius.circular(5),
                                            ),
                                            borderSide: BorderSide(
                                              color: Color(0XFFEEEEEE),
                                              width: 1,
                                            ),
                                          ),
                                          focusedBorder: OutlineInputBorder(
                                            borderSide: BorderSide(
                                              color: Color(0XFFEEEEEE),
                                              width: 1,
                                            ),
                                            borderRadius: BorderRadius.all(
                                              Radius.circular(5), //边角为30
                                            ),
                                          ),
                                          contentPadding:
                                              const EdgeInsets.all(0),
                                          hintStyle: TextStyle(fontSize: 12.0),
                                        ),
                                      ),
                                    ),
                                  ),
                                  Container(
                                      margin: EdgeInsets.only(left: 8.0),
                                      height: 28,
                                      child: RaisedButton(
                                        child: Text("确定"),
                                        textColor: Colors.white,
                                        color: Colors.blue,
                                        onPressed: () {
                                          if (_decController.text.isEmpty) {
                                            print("null");
                                            Navigator.pop(context, null);
                                          } else {
                                            Navigator.pop(
                                                context, _decController.text);
                                          }
                                        },
                                      )),
                                ],
                              ),
                            ),
                            SizedBox(height: 23),
                          ],
                        ),
                      ),
                    )
                  ],
                )),
          ])),
    );
  }
}

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
  String city;

  WeatherPage_3d(this.city);

  @override
  State<StatefulWidget> createState() {
    return new WeatherState_3d(city);
  }
}

class WeatherState extends State<WeatherPage> {
  WeatherData weather = WeatherData.empty();
  String city = "上海";

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
    final location = await get(
        'https://geoapi.heweather.net/v2/city/lookup?location=$city&key=615fef66d131450fb6e21722544ebb0e');
    if (location.statusCode == 200) {
      final locationID = json.decode(location.body)['location'][0]['id'];
      city = json.decode(location.body)['location'][0]['name'];
      final response = await get(
          'https://devapi.heweather.net/v7/weather/now?location=$locationID&key=615fef66d131450fb6e21722544ebb0e');
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
    } else {
      print("Error code: $location['code']");
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
            fit: BoxFit.fitHeight,
          ),
          new Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              new Container(
                width: double.infinity,
                margin: EdgeInsets.only(top: 60.0),
                child: new Text(
                  "📍" + city,
                  textAlign: TextAlign.center,
                  style: new TextStyle(
                    color: Colors.white,
                    fontSize: 30.0,
                  ),
                ),
              ),
              new FlatButton(
                child: Text("更改当前城市"),
                textColor: Colors.white,
                onPressed: () {
                  Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => ProvideWidget()))
                      .then((dynamic input) => this.setState(() {
                            if (input != null) {
                              city = input;
                              _getWeather();
                            }
                          }));
                },
              ),
              new Container(
                width: double.infinity,
                margin: EdgeInsets.only(top: 30.0),
                child: new Column(
                  children: <Widget>[
                    new Text(weather.tmp,
                        style:
                            new TextStyle(color: Colors.white, fontSize: 80.0)),
                    new Image.asset(
                      "icons/${weather?.icon}.png",
                      fit: BoxFit.fitHeight,
                    ),
                    new Text(weather?.cond,
                        style:
                            new TextStyle(color: Colors.white, fontSize: 45.0)),
                    new Text(
                      weather?.hum,
                      style: new TextStyle(color: Colors.white, fontSize: 30.0),
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
                            builder: (context) => WeatherPage_3d(city)));
                  },
                ),
              ),
            ],
          )
        ],
      ),
    );
  }
}

class WeatherState_3d extends State<WeatherPage_3d> {
  WeatherData_3d weather = WeatherData_3d.empty();
  String city = "";

  WeatherState_3d(String input) {
    _getWeather_3d(input);
  }

  void _getWeather_3d(String input) async {
    WeatherData_3d data = await _fetchWeather_3d(input);
    setState(() {
      weather = data;
    });
  }

  Future<WeatherData_3d> _fetchWeather_3d(String input) async {
    print('start fetching');
    final location = await get(
        'https://geoapi.heweather.net/v2/city/lookup?location=$input&key=615fef66d131450fb6e21722544ebb0e');
    if (location.statusCode == 200) {
      final locationID = json.decode(location.body)['location'][0]['id'];
      city = json.decode(location.body)['location'][0]['name'];
      print('start fetching');
      final response = await get(
          'https://devapi.heweather.net/v7/weather/3d?location=$locationID&key=615fef66d131450fb6e21722544ebb0e');
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
            fit: BoxFit.fitHeight,
          ),
          new Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              new Container(
                width: double.infinity,
                margin: EdgeInsets.only(top: 80.0),
                child: new Text(
                  "📍" + city,
                  textAlign: TextAlign.center,
                  style: new TextStyle(
                    color: Colors.white,
                    fontSize: 30.0,
                  ),
                ),
              ),
              new Container(
                width: double.infinity,
                margin: EdgeInsets.only(top: 80.0),
                child: new Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      new Container(
                        margin: EdgeInsets.only(left: 5.0),
                        child: new Column(
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
                margin: EdgeInsets.only(top: 100.0),
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
