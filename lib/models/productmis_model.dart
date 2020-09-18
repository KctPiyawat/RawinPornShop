class ProductMISmodel {
  String reciveLastDate;
  String reciveLastQty;
  String saleAfterRC;
  String stkWh;
  String saleLastDate;

  ProductMISmodel(
      {this.reciveLastDate,
      this.reciveLastQty,
      this.saleAfterRC,
      this.stkWh,
      this.saleLastDate});

  ProductMISmodel.fromJson(Map<String, dynamic> json) {
    reciveLastDate = json['ReciveLastDate'];
    reciveLastQty = json['ReciveLastQty'];
    saleAfterRC = json['SaleAfterRC'];
    stkWh = json['StkWh'];
    saleLastDate = json['SaleLastDate'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['ReciveLastDate'] = this.reciveLastDate;
    data['ReciveLastQty'] = this.reciveLastQty;
    data['SaleAfterRC'] = this.saleAfterRC;
    data['StkWh'] = this.stkWh;
    data['SaleLastDate'] = this.saleLastDate;
    return data;
  }
}
