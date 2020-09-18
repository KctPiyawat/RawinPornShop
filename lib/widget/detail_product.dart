import 'dart:convert';
import 'dart:typed_data';

import 'package:barcode_scan/barcode_scan.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_swiper/flutter_swiper.dart';
import 'package:fontisto_flutter/fontisto_flutter.dart';
import 'package:intl/intl.dart';
import 'package:rawinpornshop/models/search_model.dart';
import 'package:rawinpornshop/utility/my_constant.dart';
import 'package:rawinpornshop/utility/my_style.dart';
import 'package:rawinpornshop/utility/normal_dialog.dart';
import 'package:rawinpornshop/widget/euamp.dart';
import 'package:rawinpornshop/widget/huajakai.dart';
import 'package:rawinpornshop/widget/latkabung.dart';
import 'package:rawinpornshop/widget/nongjok.dart';

class DetailProduct extends StatefulWidget {
  final SearchModel searchModel;
  DetailProduct({Key key, this.searchModel});
  @override
  _DetailProductState createState() => _DetailProductState();
}

class _DetailProductState extends State<DetailProduct> {
  SearchModel model;
  List<PLs> plss = List();
  bool statusProcess = false;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    model = widget.searchModel;
    readPLs();
  }

  Future<Null> readPLs() async {
    var objPLs = model.pLs;
    print('objPLs ==>> ${objPLs.toString()}');

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
      appBar: AppBar(title:  Text('รายละเอียดสินค้า'),
        actions: <Widget>[barcodeButton()],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            MyStyle().sizedBox16(),
            buildText(context, model.code, model.name),
            MyStyle().sizedBox16(),
            showListPLs(),
            MyStyle().sizedBox16(),
            showPicture(),
            MyStyle().sizedBox16(),
            buildTabHost(),
          ],
        ),
      ),
    );
  }

  Widget barcodeButton() => Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: <Widget>[
          Container(
            margin: EdgeInsets.only(right: 20),
            child: IconButton(
              icon: Icon(Istos.shopping_barcode),
              onPressed: () {
                qrThread();
              },
            ),
          ),
        ],
      );

  Widget buildTabHost() {
    List<Widget> widgets = [Latkabung(searchModel: model,), Euamp(), Nongjok(), Hunjakai()];
    List<Widget> tabWidgets = [
      Text('ลาดกระบัง'),
      Text('ตลาดเอี่ยม'),
      Text('หนองจอก'),
      Text('หัวตะเข้')
    ];

    return Container(
      height: 300,
      child: DefaultTabController(
        length: widgets.length,
        child: Scaffold(
          appBar: AppBar(
            backgroundColor: Colors.white,
            // title: Text('สาขา',style: MyStyle().titleH3(),),
            leading: SizedBox(),
            bottom: TabBar(
              tabs: tabWidgets,
              labelColor: Colors.blue.shade900,
              indicatorColor: Colors.red,
              // indicatorWeight: 6.0,                                                                                                                                                                                                                                                  ,
            ),
          ),
          body: TabBarView(children: widgets),
        ),
      ),
    );
  }

  Widget buildText(BuildContext context, String string, String string2) {
    return Card(
      child: Container(
        padding: EdgeInsets.all(8),
        width: MediaQuery.of(context).size.width * 0.8,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Row(
              children: [
                Text(
                  string,
                  style: TextStyle(color: Colors.red),
                ),
              ],
            ),
            Row(
              children: [
                Container(
                  width: MediaQuery.of(context).size.width * 0.8 - 20,
                  child: Text(
                    string2,
                    style: TextStyle(color: Colors.blue.shade700),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget showListPLs() {
    return Card(
      child: Container(
        // padding: EdgeInsets.all(2),
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
                      'BarCode',
                      style: MyStyle().titleH3(),
                    ),
                  ),
                  Expanded(
                    flex: 1,
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
                    flex: 1,
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

    return Container(
      height: MediaQuery.of(context).size.height * 0.3,
      child: Swiper(
        itemCount: uint8Lists.length,
        itemBuilder: (context, index) => Image.memory(uint8Lists[index]),
        pagination: SwiperPagination(),
        // control: SwiperControl(),
      ),
    );
  }

  Future<Null> qrThread() async {
    try {
      var object = await BarcodeScanner.scan();
      String qrCode = object.rawContent;
      if (qrCode.isNotEmpty) {
        String url =
            '${MyConstant().domain}/webapi3/api/limit?name=$qrCode&start=1&end=10';
        await Dio().get(url).then((value) {
          if (value.toString() == '[]') {
            normalDialog(context, 'ไม่มี BarCode $qrCode ในฐานข้อมูล');
          } else {
            for (var map in value.data) {
              SearchModel searchModel = SearchModel.fromJson(map);

              setState(() {
                model = searchModel;
              });
            }
          }
        });
      }
    } catch (e) {}
  }
}
