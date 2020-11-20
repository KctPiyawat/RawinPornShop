import 'package:flutter/cupertino.dart';
import 'package:rawinpornshop/widget/search_product.dart';

class MyConstant {
  String domain = 'http://210.86.171.110:89';
  String whidLatkabang = '7';
  String whidEuamp = '8';
  String whidNongjok = '9';
  String whidHunjakai = '10';

  List<String> menuFrontEnds = ['Search', 'Menu2', 'Menu3', 'Menu4', 'Menu5'];
  List<String> imageMenuFrontEnds = [
    'icon0.png',
    'icon1.png',
    'icon2.png',
    'icon3.png',
    'icon4.png',
    'icon5.png'
  ];
  List<Widget> routeWidgets = [SearchProduct()];

  MyConstant();
}
