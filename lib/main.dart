import 'package:flutter/material.dart';
import 'package:rawinpornshop/widget/search_product.dart';

main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        primarySwatch: Colors.orange,
        primaryIconTheme: IconThemeData(color: Colors.white),
        primaryTextTheme: TextTheme(title: TextStyle(color: Colors.white)),
      ),
      debugShowCheckedModeBanner: false,
      title: 'RawinPorn Shop',
      home: SearchProduct(),
    );
  }
}
