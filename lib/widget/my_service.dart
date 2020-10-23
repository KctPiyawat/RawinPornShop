import 'package:flutter/material.dart';
import 'package:rawinpornshop/widget/search_product.dart';

class MyService extends StatefulWidget {
  @override
  _MyServiceState createState() => _MyServiceState();
}

class _MyServiceState extends State<MyService> {
  Widget currentWidget = SearchProduct();
  bool statusMenu = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
            icon: Icon(statusMenu ? Icons.menu : Icons.clear),
            onPressed: () {
              setState(() {
                statusMenu = !statusMenu;
              });
            },
          )
        ],
      ),
      body: currentWidget,
    );
  }
}
