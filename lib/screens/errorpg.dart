import 'package:flutter/material.dart';

class Errorpg extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        height: double.infinity,
        width: double.infinity,
        child: Image.asset(
          "assets/images/error.jpg",
          fit: BoxFit.cover,
        ),
      ),
    );
  }
}
