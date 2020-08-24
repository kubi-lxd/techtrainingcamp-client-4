import 'package:flutter/material.dart';
// import 'package:android_alarm_manager/android_alarm_manager.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';

// TODO: This is an empty page.
class ClockDate {
  var chour;
  var cmin;
  var csec;
  bool state;
  var nowtime;
  ClockDate(this.chour, this.cmin, this.csec, this.state);
}

List<ClockDate> cdlist = [];

class MyAlarm extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => new MyAlarmPageState();
}

class MyAlarmPageState extends State<MyAlarm> {
  TextEditingController timeController = TextEditingController();
  DateTime selectTime = DateTime.now();

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
          child: ListView.separated(
            itemCount: cdlist.length,
            itemBuilder: (context, index) {
              return showAlarmList(context, cdlist[index]);
            },
            separatorBuilder: (context, index) {
              return Divider(
                height: .5,
                indent: 75,
                color: Color(0xFFDDDDDD),
              );
            },
          ),
        ),
        floatingActionButton: FloatingActionButton(
          child: Icon(Icons.add),
          onPressed: () async {
            Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => SecondScreen(),
                )).then((data) {
              setState(() {
                ClockDate backdata =
                    new ClockDate(data.chour, data.cmin, data.csec, data.state);
                cdlist.add(backdata);
                print(backdata.chour);
              });
            });

            // await AndroidAlarmManager.periodic(const Duration(seconds: 1), 0, checkClock);
          },
        ),
      ),
    );
  }

  Widget showAlarmList(BuildContext context, ClockDate data) {
    return Container(
      color: Colors.white,
      padding: EdgeInsets.all(15),
      child: Row(
        children: <Widget>[
          ClipRRect(
            borderRadius: BorderRadius.circular(4),
            child: Icon(Icons.alarm),
          ),
          Padding(padding: EdgeInsets.only(left: 15)),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Text(
                      '${data.chour}:${data.cmin}:${data.csec}',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w500,
                        color: Color(0xFF333333),
                      ),
                    ),
                    Switch(
                      value: data.state,
                      activeColor: Colors.blue, // 激活时原点颜色
                      onChanged: (bool val) {
                        this.setState(() {
                          data.state = !data.state;
                          print(data.state);
                        });
                      },
                    )
                  ],
                ),
                Padding(padding: EdgeInsets.only(top: 2)),
                Text(
                  'this.data.msgContent',
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                    fontSize: 15,
                    color: Color(0xFF999999),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class SecondScreen extends StatefulWidget {
  @override
  SecondScreenState createState() {
    return new SecondScreenState();
  }
}

class SecondScreenState extends State<SecondScreen> {
  var selectTime = DateTime.now();
  ClockDate cd;
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    print('${this} hashCode=${this.hashCode}');
    cd = new ClockDate(
        selectTime.hour, selectTime.minute, selectTime.second, true);
    return Scaffold(
      appBar: AppBar(
        title: Text('新建闹钟'),
      ),
      body: Center(
        child: Column(children: <Widget>[
          Text(
            '${cd.chour}:${cd.cmin}:${cd.csec}',
            style: Theme.of(context).textTheme.headline2,
          ),
          FlatButton(
              onPressed: () {
                DatePicker.showTimePicker(context,
                    // 是否展示顶部操作按钮
                    showTitleActions: true,
                    // change事件
                    onChanged: (date) {
                  print('change $date');
                },
                    // 确定事件
                    onConfirm: (date) {
                  print('confirm $date');
                  setState(() {
                    selectTime = date;
                    cd.chour = selectTime.hour;
                    cd.cmin = selectTime.minute;
                    cd.csec = selectTime.second;
                    cd.nowtime = selectTime.millisecondsSinceEpoch;
                  });
                },
                    // 当前时间
                    // currentTime: DateTime(2019, 6, 20, 17, 30, 20), // 指定时间
                    currentTime: DateTime.now(), // 当前时间
                    // 语言
                    locale: LocaleType.zh);
              },
              child: Text(
                '选择闹钟时间',
                style: TextStyle(color: Colors.blue),
              )),
          RaisedButton(
              child: Text("确定"),
              onPressed: () {
                ClockDate dat = cd;
                Navigator.of(context).pop(dat);
              }),
        ]),
      ),
    );
  }
}
