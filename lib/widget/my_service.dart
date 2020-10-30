import 'package:flutter/material.dart';
import 'package:rawinpornshop/utility/my_style.dart';
import 'package:rawinpornshop/widget/backend_menu.dart';
import 'package:rawinpornshop/widget/frontend_menu.dart';

class MyService extends StatefulWidget {
  @override
  _MyServiceState createState() => _MyServiceState();
}

class _MyServiceState extends State<MyService> {
  List<Widget> widgets = [FrontEndMenu(), BackEndMenu()];
  List<String> titles = ['หน้าร้าน', 'คลังสินค้า'];
  List<IconData> icons = [Icons.shop, Icons.wallpaper_sharp];
  List<String> images = ['images/frontend.png', 'images/backend.png'];
  List<Widget> tabWidgets = List();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    creatWidgets();
  }

  void creatWidgets() {
    int i = 0;
    for (var title in titles) {
      tabWidgets.add(Column(
        children: [
          Container(
            width: 48,
            child: Image.asset(images[i]),
          ),
          Text(title),
        ],
      ));
      i++;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: DefaultTabController(
        length: 2,
        child: Scaffold(
          appBar: AppBar(
            title: Text('Name Login'),
            bottom: TabBar(indicator: BoxDecoration(color: Colors.white24),
              tabs: tabWidgets,
              indicatorWeight: 4.0,
              labelColor: Colors.white,
              labelStyle: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 16,
              ),
              unselectedLabelColor: Colors.white54,
              labelPadding: EdgeInsets.only(top:8)
            ),
          ),
          body: TabBarView(children: widgets),
        ),
      ),
    );
  }
}
