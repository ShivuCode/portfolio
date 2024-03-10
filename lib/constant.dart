import 'dart:math';

import 'package:flutter/material.dart';
import 'package:velocity_x/velocity_x.dart';

toast(context, String msg) {
  ScaffoldMessenger.of(context).showSnackBar(SnackBar(
    duration: const Duration(milliseconds: 500),
    content: Text(msg),
    behavior: SnackBarBehavior.floating,
    backgroundColor: Vx.purple400,
  ));
}

List<Color> colors = [
  Colors.redAccent,
  Colors.blueAccent,
  Colors.greenAccent,
  Colors.purpleAccent,
  Colors.orangeAccent,
  Colors.yellowAccent,
  Colors.pinkAccent,
];
int generateRandomNumber() {
  Random random = Random();
  return random.nextInt(6) + 1; // Add 1 to make the range 1 to 7
}

