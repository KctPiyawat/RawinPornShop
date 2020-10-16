import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:rawinpornshop/models/user_authen_model.dart';
import 'package:rawinpornshop/utility/my_constant.dart';
import 'package:rawinpornshop/utility/my_style.dart';
import 'package:rawinpornshop/utility/normal_dialog.dart';
import 'package:rawinpornshop/widget/search_product.dart';

class Authen extends StatefulWidget {
  @override
  _AuthenState createState() => _AuthenState();
}

class _AuthenState extends State<Authen> {
  String user, password;
  bool redEye = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: Container(
        margin: EdgeInsets.only(right: 40, bottom: 30),
        child: FloatingActionButton(
          onPressed: () {
            if (user == null ||
                user.isEmpty ||
                password == null ||
                password.isEmpty) {
              normalDialog(context, 'มีช่องว่าง ? กรุณากรอกข้อมูลทุกช่อง');
            } else {
              checkAuthen();
            }
          },
          child: Icon(
            Icons.forward,
            size: 36,
          ),
        ),
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: RadialGradient(
            radius: 1.0,
            colors: [Colors.white, MyStyle().primaryColor],
          ),
        ),
        child: Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                margin: EdgeInsets.only(bottom: 24),
                width: 130,
                child: Image.asset("images/logo.png"),
              ),
              buildUser(),
              MyStyle().sizedBox16(),
              buildPassword(),
            ],
          ),
        ),
      ),
    );
  }

  Future routToService(BuildContext context) {
    return Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(
          builder: (context) => SearchProduct(),
        ),
        (route) => false);
  }

  Container buildUser() {
    return Container(
      decoration: BoxDecoration(
        color: Colors.black12,
        borderRadius: BorderRadius.circular(30),
      ),
      width: 250,
      child: TextFormField(
        onChanged: (value) => user = value.trim(),
        decoration: InputDecoration(
          prefixIcon: Icon(Icons.account_box),
          contentPadding: EdgeInsets.only(left: 15, top: 15),
          hintText: 'User :',
          border: InputBorder.none,
        ),
      ),
    );
  }

  Container buildPassword() {
    return Container(
      decoration: BoxDecoration(
        color: Colors.black12,
        borderRadius: BorderRadius.circular(30),
      ),
      width: 250,
      child: TextFormField(
        obscureText: redEye,
        onChanged: (value) => password = value.trim(),
        decoration: InputDecoration(
          prefixIcon: Icon(
            Icons.lock,
            color: Colors.black45,
          ),
          contentPadding: EdgeInsets.only(left: 15, top: 15),
          hintText: 'Password :',
          border: InputBorder.none,
          suffixIcon: IconButton(
            icon: Icon(
              Icons.remove_red_eye,
              color: redEye ? Colors.black45 : Colors.blue[700],
            ),
            onPressed: () {
              setState(() {
                redEye = !redEye;
              });
            },
          ),
        ),
      ),
    );
  }

  Future<Null> checkAuthen() async {
    String urlCheckUser = '${MyConstant().domain}/webapi3/api/user?code=$user';
    await Dio().get(urlCheckUser).then((value) async {
      print('value ====> $value');
      if (value.toString() == '[]') {
        normalDialog(context, 'ไม่มี $user ในระบบ');
      } else {
        for (var json in value.data) {
          UserAuthenModel model = UserAuthenModel.fromJson(json);
          String passwordKey = model.password;
          print('passwordKey ===>> $passwordKey');

          String path =
              '${MyConstant().domain}/webapi3/api/login?type=0&key=$password';

          await Dio().get(path).then((value) {
            String passwordKey2 = value.data['Passvalue'];
            print('passwordKey2 ===> $passwordKey2');
            if (passwordKey == passwordKey2) {
              routToService(context);
              
            } else {
              normalDialog(context, 'Password ไม่ถูกต้อง กรุณาลองใหม่');
            }


          });
        }
      }
    });
  }
}
