import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:quit_frontend/views/home.dart';
import 'package:quit_frontend/views/profile.dart';

class Index extends StatefulWidget {
  Index({Key? key}) : super(key: key);

  @override
  _IndexState createState() => _IndexState();
}

class _IndexState extends State<Index> {
  final List<Widget> pages = [
    CupertinoTabView(
      routes: {
        "/": (context) => Home(),
      },
    ),
    CupertinoTabView(
      routes: {
        "/": (context) => Profile(),
      },
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return CupertinoTabScaffold(
      tabBar: CupertinoTabBar(
        items: [
          BottomNavigationBarItem(
              icon: Icon(
                Icons.search,
              ),
              label: 'Home'),
          BottomNavigationBarItem(
              icon: Icon(
                Icons.person,
              ),
              label: 'Profile'),
        ],
      ),
      tabBuilder: (BuildContext context, index) {
        return pages[index];
      },
    );
  }
}
