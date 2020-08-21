import 'package:barcode_scan/barcode_scan.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:fontisto_flutter/fontisto_flutter.dart';
import 'package:rawinpornshop/models/search_model.dart';
import 'package:rawinpornshop/utility/my_constant.dart';
import 'package:rawinpornshop/utility/my_style.dart';
import 'package:rawinpornshop/utility/normal_dialog.dart';
import 'package:rawinpornshop/widget/detail_product.dart';

class SearchProduct extends StatefulWidget {
  @override
  _SearchProductState createState() => _SearchProductState();
}

class _SearchProductState extends State<SearchProduct> {
  List<SearchModel> searchModels = List();
  String search;
  bool processStatus = false;
  bool resultSearch = true;
  int amountSearch = 20;
  int start = 1;
  bool lazyLoad = true;
  bool barCodeBool = false;

  ScrollController scrollController = ScrollController();

  @override
  void initState() {
    super.initState();

    scrollController.addListener(() {
      if (scrollController.position.pixels ==
          scrollController.position.maxScrollExtent) {
        print('At the End');
        setState(() {
          start = amountSearch + 1;
          amountSearch = amountSearch + 20;
          lazyLoad = false;
          readData();
        });
      }
    });
  }

  Future<void> readData() async {
    if (searchModels.length != 0 && lazyLoad) {
      searchModels.clear();
    }

    String url =
        '${MyConstant().domain}/webapi3/api/limit?name=$search&start=$start&end=$amountSearch';
    try {
      Response response = await Dio().get(url);
      // print(object(response));

      if (response.toString() == '[]') {
        setState(() {
          resultSearch = false;
          processStatus = false;
        });
      } else {
        for (var map in response.data) {
          SearchModel model = SearchModel.fromJson(map);
          setState(() {
            searchModels.add(model);
            processStatus = false;
            resultSearch = true;
          });
        }
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
              ? myProcess()
              : resultSearch
                  ? mySizeBox()
                  : Center(child: Text('ไม่มีคำ $search ในฐานข้อมูล')),
          myContent(),
          barCodeBool ? MyStyle().showProgress() : mySizeBox(),
        ],
      )),
    );
  }

  Center myProcess() {
    return Center(
      child: CircularProgressIndicator(),
    );
  }

  Widget showNoSearch() {
    return Center(
      child: Text('Please Fill Search'),
    );
  }

  Widget myContent() => Column(
        children: <Widget>[
          MyStyle().sizedBox(16.0),
          searchBox(),
          MyStyle().sizedBox(10.0),
          searchModels.length == 0 ? MyStyle().sizedBox(1.0) : headList(),
          showListResult(),
        ],
      );

  Widget headList() => Card(
        color: Colors.blue,
        child: Container(
          padding: EdgeInsets.only(top: 10.0, bottom: 10.0),
          child: Row(
            children: <Widget>[
              Expanded(
                flex: 3,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Text(
                      'ลำดับ',
                      style: MyStyle().titleH2white(),
                    ),
                  ],
                ),
              ),
              Expanded(
                flex: 17,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Text(
                      'สินค้า',
                      style: MyStyle().titleH2white(),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      );

  Widget showListResult() {
    return searchModels.length == 0
        ? showNoSearch()
        : Expanded(
            child: ListView.builder(
              controller: scrollController,
              itemCount: searchModels.length,
              itemBuilder: (context, index) => showCard(index),
            ),
          );
  }

  Widget showCard(int index) {
    return GestureDetector(
      onTap: () {
        MaterialPageRoute route = MaterialPageRoute(
          builder: (context) => DetailProduct(
            searchModel: searchModels[index],
          ),
        );
        Navigator.push(context, route);
      },
      child: Card(
        child: Container(
          margin: EdgeInsets.only(top: 16.0, bottom: 16.0, right: 16.0),
          child: Row(
            children: <Widget>[
              Expanded(
                flex: 3,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Text(
                      '${index + 1}',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
              ),
              Expanded(
                flex: 17,
                child: Text(searchModels[index].name),
              ),
            ],
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
      onPressed: () async {
        lazyLoad = true;
        start = 1;
        amountSearch = 20;
        if (search == null || search.isEmpty) {
          resultSearch = true;
          normalDialog(context, "กรุณาใส่ข้อมุล Search ด้วยค่ะ");
        } else {
          setState(() {
            processStatus = true;
            readData();
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
            onPressed: () {
              qrThread();
            },
          ),
        ],
      );

  Future<Null> qrThread() async {
    try {
      var result = await BarcodeScanner.scan();
      print('result ========= ${result.rawContent}');
      String qrCode = result.rawContent;

      if (qrCode.isNotEmpty) {
        setState(() {
          barCodeBool = true;
        });

        String url1 =
            '${MyConstant().domain}/webapi3/api/limit?name=$qrCode&start=1&end=10';
        await Dio().get(url1).then(
          (value) {
            // print('value  =============================... $value');

            setState(() {
              barCodeBool = false;
            });

            if (value.toString() == '[]') {
              normalDialog(context, 'ไม่มี BarCode $qrCode ในฐานข้อมูล');
            } else {
              var result = value.data;
              for (var map in result) {
                SearchModel searchModel = SearchModel.fromJson(map);
                MaterialPageRoute route = MaterialPageRoute(
                  builder: (context) => DetailProduct(
                    searchModel: searchModel,
                  ),
                );
                Navigator.push(context, route);
              }
            }
          },
        );
      }
    } catch (e) {}
  }
}
