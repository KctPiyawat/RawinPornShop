import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:fontisto_flutter/fontisto_flutter.dart';
import 'package:rawinpornshop/models/search_model.dart';
import 'package:rawinpornshop/utility/normal_dialog.dart';

class SearchProduct extends StatefulWidget {
  @override
  _SearchProductState createState() => _SearchProductState();
}

class _SearchProductState extends State<SearchProduct> {
  List<SearchModel> searchModels = List();
  String search;
  bool processStatus = false;

  @override
  void initState() {
    super.initState();
  }

  Future<void> readDate() async {
    if (searchModels.length != 0) {
      searchModels.clear();
    }

    String url =
        'http://210.86.171.110:89/webapi3/api/limit?name=$search&start=1&end=50';
    try {
      Response response = await Dio().get(url);
      // print(object(response));

      for (var map in response.data) {
        SearchModel model = SearchModel.fromJson(map);
        setState(() {
          searchModels.add(model);
          processStatus = false;
        });
      }
    } catch (e) {}
  }

  String object(Response response) => 'res  ===> $response';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: Stack(
        children: <Widget>[
          processStatus
              ? Center(
                  child: CircularProgressIndicator(),
                )
              : mySizeBox(),
          myContent(),
        ],
      )),
    );
  }

  Widget showNoSearch() {
    return Center(
      child: Text('Please Fill Search'),
    );
  }

  Widget myContent() => Column(
        children: <Widget>[
          mySizeBox(),
          searchBox(),
          showListResult(),
        ],
      );

  Widget showListResult() {
    return searchModels.length == 0
        ? showNoSearch()
        : Expanded(
            child: ListView.builder(
              itemCount: searchModels.length,
              itemBuilder: (context, index) => Card(
                child: Container(
                  margin: EdgeInsets.all(16.0),
                  child: Text(searchModels[index].name),
                ),
              ),
            ),
          );
  }

  Row searchBox() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[barcodeButton(), searchForm(), searchButton()],
    );
  }

  SizedBox mySizeBox() => SizedBox(
        height: 10,
      );

  IconButton searchButton() {
    return IconButton(
      icon: Icon(Istos.search),
      onPressed: () {
        if (search == null || search.isEmpty) {
          normalDialog(context, "กรุณากรอก Search ด้วยค่ะ");
        } else {
          setState(() {
          processStatus = true;
          readDate();
        });
        }
      },
    );
  }

  Widget searchForm() => Container(
        decoration: BoxDecoration(
            color: Colors.black12, borderRadius: BorderRadius.circular(10.0)),
        width: MediaQuery.of(context).size.width - (2 * 58),
        height: 50.0,
        child: TextField(
          onChanged: (value) => search = value.trim(),
          decoration: InputDecoration(
            hintText: 'บาร์โค้ด/รหัสสินค้า/กลุ่มคำชื่อสินค้า',
            hintStyle: TextStyle(color: Colors.black26),
            contentPadding: EdgeInsets.only(
              left: 10.0,
            ),
            border: InputBorder.none,
          ),
        ),
      );

  Widget barcodeButton() => Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: <Widget>[
          IconButton(
            icon: Icon(Istos.shopping_barcode),
            onPressed: () {},
          ),
        ],
      );
}
