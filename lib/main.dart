import 'package:flutter/material.dart';
import 'index.dart';

void main() {
  runApp(new MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      title: 'Flutter Clock',
      debugShowCheckedModeBanner: false,
      home: new Index(), // 指定去加载 Index页面。
    );
  }
}
