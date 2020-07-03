import 'package:flutter/material.dart';
import 'package:rawinpornshop/models/search_model.dart';

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
    return Scaffold(appBar: AppBar(),
      body: Text('name = ${model.name}'),
    );
  }
}
