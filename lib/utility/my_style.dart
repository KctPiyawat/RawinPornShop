import 'package:flutter/material.dart';

class MyStye {
  TextStyle titleH2() {
    return TextStyle(
      fontSize: 16.0,
      fontWeight: FontWeight.bold,
    );
  }

  TextStyle titleH2white() {
    return TextStyle(
      fontSize: 16.0,
      fontWeight: FontWeight.bold,
      color: Colors.white,
    );
  }

  SizedBox sizedBox(double height){
    return SizedBox(height: height,);
  }

  MyStye();
}
