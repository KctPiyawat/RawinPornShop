import 'package:flutter/material.dart';
import 'package:rawinpornshop/utility/my_constant.dart';

class FrontEndMenu extends StatefulWidget {
  @override
  _FrontEndMenuState createState() => _FrontEndMenuState();
}

class _FrontEndMenuState extends State<FrontEndMenu> {
  List<String> menuFrontEnds = MyConstant().menuFrontEnds;
  List<String> imageMenuFrontEnds = MyConstant().imageMenuFrontEnds;
  List<Widget> widgets = List();
  List<Widget> routeWidgets = MyConstant().routeWidgets;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    createWidgets();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: GridView.extent(
          maxCrossAxisExtent: 160,
          crossAxisSpacing: 16,
          mainAxisSpacing: 16,
          children: widgets,
        ),
      ),
    );
  }

  void createWidgets() {
    int index = 0;
    for (var title in menuFrontEnds) {
      widgets.add(buildWidgets(index, title));
      index += 1;
    }
  }

  GestureDetector buildWidgets(int index, String title) {
    return GestureDetector(onTap:() {
      if (index < routeWidgets.length) {
        Navigator.push(context, MaterialPageRoute(builder: (context) => routeWidgets[index],),);
      }
    } ,
      child: Card(
        shape:
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        child: Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                width: 70,
                child: Image.asset('images/${imageMenuFrontEnds[index]}'),
              ),
              Text(title)
            ],
          ),
        ),
      ),
    );
  }
}
