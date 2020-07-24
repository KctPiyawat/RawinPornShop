import 'package:flutter/material.dart';
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
      setState(() {
        plss.add(pLs);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Column(
        children: <Widget>[
          buildText(context, 'รหัสสินค้า = ${model.code}'),
          buildText(context, 'ชื่อสินค้า = ${model.name}'),
          showListPLs(),
        ],
      ),
    );
  }

  Widget buildText(BuildContext context, String string) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Card(
          child: Container(
              padding: EdgeInsets.all(8),
              width: MediaQuery.of(context).size.width * 0.8,
              child: Text(
                string,
                style: MyStyle().titleH2(),
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
            Container(height: 35,
              decoration: BoxDecoration(color: Colors.grey.shade300),
              child: Row(
                children: <Widget>[
                  Expanded(
                    flex: 2,
                    child: Text('บาร์โค๊ด',style: MyStyle().titleH3(),),
                  ),
                  Expanded(
                    flex: 2,
                    child: Text('หน่วยนับ',style: MyStyle().titleH3(),),
                  ),
                  Expanded(
                    flex: 1,
                    child: Text('ราคา',style: MyStyle().titleH3(),),
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
    // List<String> list = price9.split('.');
    // return list[0];

    double priceDou = double.parse(price9.trim());
    var myFormat = NumberFormat('#,###', 'en_US');
    String result = myFormat.format(priceDou);

    return result;
  }
}
