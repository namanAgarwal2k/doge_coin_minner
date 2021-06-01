import 'dart:async';

import 'package:doge_coin_minner/barriers.dart';
import 'package:doge_coin_minner/bird.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  // final bestScoreHive = Hive.box('bestScore');
  static double birdYaxis = 0;
  double time = 0;
  double height = 0;
  double initialHeight = birdYaxis;
  bool gameHasStarted = false;
  static double barrierXone = 1.8;
  double barrierXtwo = barrierXone + 1.5;
  bool live = false;

  int score = 0;
  int bestScore = 0;

  @override
  void initState() {
    gameHasStarted = false;
    birdYaxis = 0;
    barrierXone = 1.8;
    initialHeight = birdYaxis;
    time = 0;
    score = 0;
    // height = 0;
    live = false;
    barrierXtwo = barrierXone + 1.5;
    //  initHiveBestScore();
    super.initState();
  }

  // void initHiveBestScore() {
  //   bestScore = bestScoreHive.get('score') ?? 0;
  //   setState(() {});
  // }

  void onInit() {
    setState(() {
      gameHasStarted = false;
      birdYaxis = 0;
      barrierXone = 1.8;
      initialHeight = birdYaxis;
      time = 0;
      score = 0;
      //  height = 0;
      live = false;
      barrierXtwo = barrierXone + 1.9;
    });
  }

  void jump() {
    setState(() {
      time = 0;
      initialHeight = birdYaxis;
    });
  }

  void startGame() {
    Timer.periodic(Duration(milliseconds: 50), (timer) {
      gameHasStarted = true;
      time += 0.05;
      height = -4.9 * time * time + 2.8 * time;
      setState(() {
        birdYaxis = initialHeight - height;
        if (barrierXone < -2) {
          score++;
          barrierXone += 4.5;
        } else {
          barrierXone -= 0.05;
        }
        if (barrierXtwo < -2) {
          score++;
          barrierXtwo += 4.5;
        } else {
          barrierXtwo -= 0.05;
        }
      });

      if (birdYaxis > 1 || checkBarrierLost()) {
        timer.cancel();
        gameHasStarted = false;
        _showDialog();
      }
    });
  }

  void _showDialog() {
    showDialog(
      barrierDismissible: false,
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: Colors.brown[900],
          title: Text(
            'GAME OVER',
            style: TextStyle(color: Colors.white),
          ),
          content: Text(
            'Score ${score.toString()}',
            style: TextStyle(color: Colors.white),
          ),
          actions: [
            FlatButton(
              onPressed: () {
                if (score > bestScore) {
                  bestScore = score;
                  // bestScoreHive.put('score', score);
                }
                onInit();
                setState(() {
                  gameHasStarted = false;
                });
                Navigator.of(context).pop();
              },
              child: Text(
                'Start Again',
                style: TextStyle(color: Colors.white),
              ),
            )
          ],
        );
      },
    );
  }

  bool checkBarrierLost() {
    if (barrierXone < 0.4 && barrierXone > -0.2) {
      if (birdYaxis < -0.5 || birdYaxis > 0.4) {
        return true;
      }
    }
    if (barrierXtwo < 0.4 && barrierXtwo > -0.2) {
      if (birdYaxis < -0.25 || birdYaxis > 0.6) {
        return true;
      }
    }
    return false;
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        if (gameHasStarted) {
          jump();
        } else {
          startGame();
        }
      },
      child: Scaffold(
          body: Column(
        children: [
          Expanded(
            flex: 3,
            child: Stack(
              children: [
                AnimatedContainer(
                  alignment: Alignment(0, birdYaxis),
                  color: Colors.black,
                  duration: Duration(microseconds: 0),
                  child: MyBird(),
                ),
                AnimatedContainer(
                  duration: Duration(milliseconds: 0),
                  alignment: Alignment(barrierXone, 1.1),
                  child: MyBarrier(
                    size: 200.0,
                  ),
                ),
                AnimatedContainer(
                  duration: Duration(milliseconds: 0),
                  alignment: Alignment(barrierXone, -1.1),
                  child: MyBarrier(
                    size: 180.0,
                  ),
                ),
                AnimatedContainer(
                  duration: Duration(milliseconds: 0),
                  alignment: Alignment(barrierXtwo, 1.1),
                  child: MyBarrier(
                    size: 150.0,
                  ),
                ),
                AnimatedContainer(
                  duration: Duration(milliseconds: 0),
                  alignment: Alignment(barrierXtwo, -1.1),
                  child: MyBarrier(
                    size: 250.0,
                  ),
                ),
                Container(
                  alignment: Alignment(0.2, -0.3),
                  child: gameHasStarted
                      ? Text('')
                      : Text(
                          'T A P  T O  P L A Y',
                          style: TextStyle(fontSize: 20, color: Colors.white),
                        ),
                ),
              ],
            ),
          ),
          Container(
            height: 15,
            color: Colors.green[800],
          ),
          Expanded(
              child: Container(
            color: Colors.brown[900],
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'SCORE',
                      style: TextStyle(color: Colors.white, fontSize: 25),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Text(
                      score.toString(),
                      style: TextStyle(color: Colors.white, fontSize: 35),
                    )
                  ],
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'BEST',
                      style: TextStyle(color: Colors.white, fontSize: 25),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Text(
                      bestScore.toString(),
                      style: TextStyle(color: Colors.white, fontSize: 35),
                    )
                  ],
                )
              ],
            ),
          ))
        ],
      )),
    );
  }
}
