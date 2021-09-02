import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:quit_frontend/views/entrance.dart';
import 'package:quit_frontend/views/index.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(QuitFrontend());
}

class QuitFrontend extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'I Quit',
      home: Entrance(),
      routes: <String, WidgetBuilder>{"/index": (context) => Index()},
    );
  }
}
