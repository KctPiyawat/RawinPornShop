import 'dart:convert';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter_swiper/flutter_swiper.dart';
import 'package:intl/intl.dart';
import 'package:rawinpornshop/models/search_model.dart';
import 'package:rawinpornshop/utility/my_style.dart';

class DetailProduct extends StatefulWidget {
  final SearchModel searchModel;
  DetailProduct({Key key, this.searchModel});

  @override
  _DetailProductState createState() => _DetailProductState();
}

class _DetailProductState extends State<DetailProduct> {
  SearchModel model;
  List<PLs> plss = List();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    model = widget.searchModel;
    readPLs();
  }

  Future<Null> readPLs() async {
    var objPLs = model.pLs;
    for (var plsModel in objPLs) {
      Map<String, dynamic> map = plsModel.toJson();
      PLs pLs = PLs.fromJson(map);
      String testPrice = pLs.price9;
      if (testPrice.isNotEmpty) {
        double douTestPrice = double.parse(testPrice);
        if (douTestPrice != 0) {
          setState(() {
            plss.add(pLs);
          });
        }
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Column(
        children: <Widget>[
          MyStyle().sizedBox16(),
          // buildText(context, 'รหัสสินค้า : ${model.code}'),
          MyStyle().sizedBox16(),
          buildText(context, model.code,model.name),
          showListPLs(),
          showPicture(),
        ],
      ),
    );
  }

  Widget buildText(BuildContext context, String string, String string2) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Card(
          child: Container(
              padding: EdgeInsets.all(8),
              width: MediaQuery.of(context).size.width * 0.8,
              child: Container(width: 300,
                child: Row(
                  children: <Widget>[
                    Text(
                      string,
                      style: TextStyle(color: Colors.red),
                    ),
                    Text(' : '),
                    Text(
                      string2,
                      style: TextStyle(color: Colors.blue)
                    ),
                  ],
                ),
              )),
        ),
      ],
    );
  }

  Widget showListPLs() {
    return Card(
      child: Container(
        // padding: EdgeInsets.all(8),
        width: MediaQuery.of(context).size.width * 0.8,
        child: Column(
          children: <Widget>[
            Container(
              height: 35,
              decoration: BoxDecoration(color: Colors.grey.shade300),
              child: Row(
                children: <Widget>[
                  Expanded(
                    flex: 2,
                    child: Text(
                      'บาร์โค๊ด',
                      style: MyStyle().titleH3(),
                    ),
                  ),
                  Expanded(
                    flex: 2,
                    child: Text(
                      'หน่วยนับ',
                      style: MyStyle().titleH3(),
                    ),
                  ),
                  Expanded(
                    flex: 1,
                    child: Text(
                      'ราคา',
                      style: MyStyle().titleH3(),
                    ),
                  ),
                ],
              ),
            ),
            ListView.builder(
              shrinkWrap: true,
              physics: ScrollPhysics(),
              itemCount: plss.length,
              itemBuilder: (context, index) => Row(
                children: <Widget>[
                  Expanded(
                    flex: 2,
                    child: Text(plss[index].barcode),
                  ),
                  Expanded(
                    flex: 2,
                    child: Text(plss[index].unitName),
                  ),
                  Expanded(
                    flex: 1,
                    child: Text(setupPrice(plss[index].price9)),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  String setupPrice(String price9) {
    String result;

    if (price9.isEmpty) {
      result = '-';
    } else {
      double priceDou = double.parse(price9.trim());
      if (priceDou == 0) {
        result = '-';
      } else {
        var myFormat = NumberFormat('#,###', 'en_US');
        result = myFormat.format(priceDou);
      }
    }

    return result;
  }

  Widget showPicture() {
    // Uint8List uint8list = base64Decode(model.pic4);

    List<Uint8List> uint8Lists = List();

    List<String> picStrings = [model.pic1, model.pic2, model.pic3, model.pic4];
    for (var string in picStrings) {
      if (string.isNotEmpty) {
        uint8Lists.add(base64Decode(string));
      }
    }

    // uint8Lists.add(base64Decode(model.pic1));
    // uint8Lists.add(base64Decode(model.pic2));
    // uint8Lists.add(base64Decode(model.pic3));
    // uint8Lists.add(base64Decode(model.pic4));

    return Container(
      height: MediaQuery.of(context).size.height * 0.3,
      child: Swiper(
        itemCount: uint8Lists.length,
        itemBuilder: (context, index) => Image.memory(uint8Lists[index]),
        pagination: SwiperPagination(),
      ),
    );
  }
}
