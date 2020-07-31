class SearchModel {
  int id;
  String code;
  String name;
  String catId;
  String catCode;
  String catName;
  List<PLs> pLs;
  String pic1;
  String pic2;
  String pic3;
  String pic4;


  SearchModel(
      {this.id,
      this.code,
      this.name,
      this.catId,
      this.catCode,
      this.catName,
      this.pLs,
      this.pic1,
      this.pic2,
      this.pic3,
      this.pic4});

  SearchModel.fromJson(Map<String, dynamic> json) {
    id = json['Id'];
    code = json['Code'];
    name = json['Name'];
    catId = json['CatId'];
    catCode = json['CatCode'];
    catName = json['CatName'];
    if (json['PLs'] != null) {
      pLs = new List<PLs>();
      json['PLs'].forEach((v) {
        pLs.add(new PLs.fromJson(v));
      });
    }
    pic1 = json['Pic1'];
    pic2 = json['Pic2'];
    pic3 = json['Pic3'];
    pic4 = json['Pic4'];

  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['Id'] = this.id;
    data['Code'] = this.code;
    data['Name'] = this.name;
    data['CatId'] = this.catId;
    data['CatCode'] = this.catCode;
    data['CatName'] = this.catName;
    if (this.pLs != null) {
      data['PLs'] = this.pLs.map((v) => v.toJson()).toList();
    }
    data['Pic1'] = this.pic1;
    data['Pic2'] = this.pic2;
    data['Pic3'] = this.pic3;
    data['Pic4'] = this.pic4;
    return data;
  }
}

class PLs {
  String unitId;
  String unitCode;
  String unitName;
  String barcode;
  String price9;

  PLs({this.unitId, this.unitCode, this.unitName, this.barcode, this.price9});

  PLs.fromJson(Map<String, dynamic> json) {
    unitId = json['UnitId'];
    unitCode = json['UnitCode'];
    unitName = json['UnitName'];
    barcode = json['Barcode'];
    price9 = json['Price9'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['UnitId'] = this.unitId;
    data['UnitCode'] = this.unitCode;
    data['UnitName'] = this.unitName;
    data['Barcode'] = this.barcode;
    data['Price9'] = this.price9;
    return data;
  }
}
