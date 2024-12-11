class ProducteModel {
  ProducteModel({
      this.id, 
      this.productName, 
      this.quantity, 
      this.purchasePrice, 
      this.salePrice, 
      this.description,});

  ProducteModel.fromJson(dynamic json) {
    id = json['Id'];
    productName = json['productName'];
    quantity = json['Quantity'];
    purchasePrice = json['purchasePrice'];
    salePrice = json['salePrice'];
    description = json['Description'];
  }
  int? id;
  String? productName;
  int? quantity;
  int? purchasePrice;
  int? salePrice;
  String? description;
ProducteModel copyWith({  int? id,
  String? productName,
  int? quantity,
  int? purchasePrice,
  int? salePrice,
  String? description,
}) => ProducteModel(  id: id ?? this.id,
  productName: productName ?? this.productName,
  quantity: quantity ?? this.quantity,
  purchasePrice: purchasePrice ?? this.purchasePrice,
  salePrice: salePrice ?? this.salePrice,
  description: description ?? this.description,
);
  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['Id'] = id;
    map['productName'] = productName;
    map['Quantity'] = quantity;
    map['purchasePrice'] = purchasePrice;
    map['salePrice'] = salePrice;
    map['Description'] = description;
    return map;
  }

}