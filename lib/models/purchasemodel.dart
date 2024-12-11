class PurchaseModel {
  PurchaseModel({
    this.id,
    this.productName,
    this.quantity,
    this.purchasePrice,
    this.salePrice,
    this.supplier,
    this.amountPaid,
    this.remainingAmount,
    this.discount,
    this.dateOfAmount,
  });

  PurchaseModel.fromJson(dynamic json) {
    id = json['Id'];
    productName = json['productName'];
    quantity = json['Quantity'];
    purchasePrice = json['purchasePrice'];
    salePrice = json['salePrice'];
    supplier = json['Supplier'];
    amountPaid = json['amountPaid'];
    remainingAmount = json['remainingAmount'];
    discount = json['Discount'];
    dateOfAmount = json['dateOfAmount'];
  }
  int? id;
  String? productName;
  int? quantity;
  int? purchasePrice;
  int? salePrice;
  String? supplier;
  int? amountPaid;
  int? remainingAmount;
  int? discount;
  String? dateOfAmount;
  PurchaseModel copyWith({
    int? id,
    String? productName,
    int? quantity,
    int? purchasePrice,
    int? salePrice,
    String? supplier,
    int? amountPaid,
    int? remainingAmount,
    int? discount,
    String? dateOfAmount,
  }) =>
      PurchaseModel(
        id: id ?? this.id,
        productName: productName ?? this.productName,
        quantity: quantity ?? this.quantity,
        purchasePrice: purchasePrice ?? this.purchasePrice,
        salePrice: salePrice ?? this.salePrice,
        supplier: supplier ?? this.supplier,
        amountPaid: amountPaid ?? this.amountPaid,
        remainingAmount: remainingAmount ?? this.remainingAmount,
        discount: discount ?? this.discount,
        dateOfAmount: dateOfAmount ?? this.dateOfAmount,
      );
  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['Id'] = id;
    map['productName'] = productName;
    map['Quantity'] = quantity;
    map['purchasePrice'] = purchasePrice;
    map['salePrice'] = salePrice;
    map['Supplier'] = supplier;
    map['amountPaid'] = amountPaid;
    map['remainingAmount'] = remainingAmount;
    map['Discount'] = discount;
    map['dateOfAmount'] = dateOfAmount;
    return map;
  }
}
