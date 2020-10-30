import 'package:flutter/material.dart';
import 'package:rawinpornshop/utility/my_constant.dart';
import 'package:rawinpornshop/utility/my_style.dart';

class Menu extends StatefulWidget {
  @override
  _MenuState createState() => _MenuState();
}

class _MenuState extends State<Menu> {
  List<String> titleFontEnds = MyConstant().menuFrontEnds;
  List<String> imageFontEnds = MyConstant().imageMenuFrontEnds;
  List<Widget> widgetFontEnds = List();

  Widget forntEnd() => Container();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    createWigget(titleFontEnds, imageFontEnds);
  }

  void createWigget(List<String> titles, List<String> images) {
    for (var title in titles) {
      widgetFontEnds.add(Text(title));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          MyStyle().buildTitleH2('หน้าร้าน'),
          GridView.extent(
            physics: ScrollPhysics(),
            shrinkWrap: true,
            maxCrossAxisExtent: 160,
            children: widgetFontEnds,
          ),
          MyStyle().buildTitleH2('คลังสินค้า'),
        ],
      ),
    );
  }
}
