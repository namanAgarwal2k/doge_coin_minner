import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class MyBarrier extends StatelessWidget {
  final size;

  MyBarrier({this.size});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 100,
      height: size,
      decoration: BoxDecoration(
          color: Colors.green[900],
          border: Border.all(width: 10, color: Colors.white70),
          borderRadius: BorderRadius.circular(15)),
    );
  }
}
