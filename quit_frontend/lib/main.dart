import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:quit_frontend/views/entrance.dart';
import 'package:quit_frontend/views/index.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return CupertinoApp(
      title: 'Flutter Demo',
      home: Entrance(),
      routes: <String, WidgetBuilder>{"/index": (context) => Index()},
    );
  }
}
