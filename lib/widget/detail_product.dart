import 'package:flutter/material.dart';
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

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    model = widget.searchModel;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Column(
        children: <Widget>[
          buildText(context, 'รหัสสินค้า = ${model.code}'),
          buildText(context, 'ชื่อสินค้า = ${model.name}'),
        ],
      ),
    );
  }

  Widget buildText(BuildContext context, String string) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Card(
                  child: Container(padding: EdgeInsets.all(8),
              width: MediaQuery.of(context).size.width * 0.8,
              child: Text(
                string,
                style: MyStyle().titleH2(),
              )),
        ),
      ],
    );
  }
}
