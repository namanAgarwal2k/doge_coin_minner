import 'dart:async';

import 'package:doge_coin_minner/bird.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  static double birdYaxis = 0;
  double time = 0;
  double height = 0;
  double initialHeight = birdYaxis;
  bool gameHasStarted = false;

  void jump() {
    setState(() {
      time = 0;
      initialHeight = birdYaxis;
    });
  }

  void startGame() {
    Timer.periodic(Duration(milliseconds: 60), (timer) {
      gameHasStarted = true;
      time += 0.05;
      height = -4.9 * time * time + 2.8 * time;
      setState(() {
        birdYaxis = initialHeight - height;
      });
      if (birdYaxis > 1) {
        timer.cancel();
        gameHasStarted = false;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Column(
      children: [
        Expanded(
          flex: 2,
          child: GestureDetector(
            onTap: () {
              if (gameHasStarted) {
                jump();
              } else {
                startGame();
              }
            },
            child: AnimatedContainer(
              alignment: Alignment(0, birdYaxis),
              color: Colors.blue,
              duration: Duration(microseconds: 0),
              child: MyBird(),
            ),
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
