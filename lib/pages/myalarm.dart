import 'package:flutter/material.dart';
// import 'package:android_alarm_manager/android_alarm_manager.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'mytimer.dart';

// TODO: This is an empty page.
class ClockDate {
  var chour;
  var cmin;
  var csec;
  bool state;
  var nowtime;
  var description;
  ClockDate(this.chour, this.cmin, this.csec, this.state, this.description);
  // ClockDate(this.chour, this.cmin, this.csec, this.state);
}

DateTime now = DateTime.now();
List<ClockDate> cdlist = [
  ClockDate(now.hour, now.minute, now.second, true, '闹钟')
];

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
                ClockDate backdata = new ClockDate(data.chour, data.cmin,
                    data.csec, data.state, data.description);
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
                      '${data.chour.toString().padLeft(2,'0')}:${data.cmin.toString().padLeft(2,'0')}:${data.csec.toString().padLeft(2,'0')}',
                      style: TextStyle(
                        fontSize: 22,
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
                  data.description,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                    fontSize: 18,
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
  TextEditingController alarmNameController = new TextEditingController();

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    print('${this} hashCode=${this.hashCode}');
    cd = new ClockDate(
        selectTime.hour, selectTime.minute, selectTime.second, true, '闹钟');
    return Scaffold(
      appBar: AppBar(
        title: Text('新建闹钟'),
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
                  value: cd.chour.toString().padLeft(2, '0'), //padLeft 补占位符
                ),
                CustomTextContainer(
                  label: 'MIN',
                  value: cd.cmin.toString().padLeft(2, '0'),
                ),
                CustomTextContainer(
                  label: 'SEC',
                  value: cd.csec.toString().padLeft(2, '0'),
                ),
              ],
            ),
            // Text(
            //   '${cd.chour}:${cd.cmin}:${cd.csec}',
            //   style: Theme.of(context).textTheme.headline2,
            // ),
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
            Container(
              width: 250,
              child: TextField(
                controller: alarmNameController,
                style: TextStyle(fontSize: 20),
                decoration: InputDecoration(
                  contentPadding: EdgeInsets.all(10.0),
                  icon: Icon(Icons.add_alarm),
                  labelText: "闹钟名称",
                ),
              ),
            ),
            RaisedButton(
                child: Text("确定"),
                onPressed: () {
                  ClockDate dat = cd;
                  dat.description = alarmNameController.text;
                  Navigator.of(context).pop(dat);
                }),
          ],
        ),
      ),
    );
  }
}
