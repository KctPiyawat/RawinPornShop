import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

Future<Null> normalDialog(BuildContext context, String title) async {
  showDialog(
    context: context,
    builder: (context) => SimpleDialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30.0)),
      title: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Container(width: 250,
            child: Text(
              title,
              style: GoogleFonts.itim(
                textStyle: TextStyle(color: Colors.blue),
              ),
            ),
          ),
        ],
      ),
      children: <Widget>[
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            OutlineButton(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30.0)),
              borderSide: BorderSide(color: Colors.blue),
              onPressed: () => Navigator.pop(context),
              child: Text('OK'),
            ),
          ],
        )
      ],
    ),
  );
}
