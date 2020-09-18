import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:rawinpornshop/models/productmis_model.dart';
import 'package:rawinpornshop/models/search_model.dart';
import 'package:rawinpornshop/utility/my_constant.dart';
import 'package:rawinpornshop/utility/my_style.dart';

class Latkabung extends StatefulWidget {
  final SearchModel searchModel;
  Latkabung({Key key, this.searchModel}) : super(key: key);
  @override
  _LatkabungState createState() => _LatkabungState();
}

class _LatkabungState extends State<Latkabung> {
  String whid;
  int pid;
  SearchModel model;
  ProductMISmodel productMISmodel;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    model = widget.searchModel;
    pid = model.id;
    whid = MyConstant().whidLatkabang;

    readData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: productMISmodel == null
          ? MyStyle().showProgress()
          : Column(
            children: [
              Text('Stock คงเหลือ ${productMISmodel.stkWh}'),
              Text('วันที่รับเข้าล่าสุด ${productMISmodel.reciveLastDate}'),
              Text('จำนวนรับเข้า ${productMISmodel.reciveLastQty}'),
              Text('ขายได้หลังรับเข้าล่าสุด ${productMISmodel.saleAfterRC}'),
              Text('วันที่ขายล่าสุด ${productMISmodel.saleLastDate}'),
            ],
          ),
    );
  }

  Future<Null> readData() async {
    String urlProductMIS =
        '${MyConstant().domain}/webapi3/api/productmis?pid=$pid&whid=$whid';
    await Dio().get(urlProductMIS).then((value) {
      // print('value ==> $value');
      setState(() {
        productMISmodel = ProductMISmodel.fromJson(value.data);
      });
      // print('Recive ==> ${productMISmodel.reciveLastDate}');
    });
  }
}
