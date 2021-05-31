import 'dart:async';

import 'package:doge_coin_minner/bird.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Column(
      children: [
        Expanded(
          child: Container(
            color: Colors.blue,
            child: Center(child: MyBird()),
          ),
        ),
        Expanded(
            child: Container(
          color: Colors.green,
        ))
      ],
    ));
  }
}
