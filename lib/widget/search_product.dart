import 'package:flutter/material.dart';
import 'package:fontisto_flutter/fontisto_flutter.dart';

class SearchProduct extends StatefulWidget {
  @override
  _SearchProductState createState() => _SearchProductState();
}

class _SearchProductState extends State<SearchProduct> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(child: myContent()),
    );
  }

  Widget myContent() => Column(
        children: <Widget>[
          barcodeButton(),
        ],
      );

  Widget barcodeButton() => Row(mainAxisAlignment: MainAxisAlignment.end,
    children: <Widget>[
      IconButton(
            icon: Icon(Istos.shopping_barcode),
            onPressed: () {},
          ),
    ],
  );
}
