class UserAuthenModel {
  String code;
  String name;
  String slname;
  String password;

  UserAuthenModel({this.code, this.name, this.slname, this.password});

  UserAuthenModel.fromJson(Map<String, dynamic> json) {
    code = json['code'];
    name = json['name'];
    slname = json['slname'];
    password = json['password'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['code'] = this.code;
    data['name'] = this.name;
    data['slname'] = this.slname;
    data['password'] = this.password;
    return data;
  }
}
