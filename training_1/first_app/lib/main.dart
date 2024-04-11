import 'package:flutter/material.dart';
import 'package:first_app/gradient_container.dart';

//this is a comment

void main() {
  runApp(
    const MaterialApp(
      home: Scaffold(
        body: GradientContainer(Colors.blue, Colors.blueGrey),
      ),
    ),
  );
}
