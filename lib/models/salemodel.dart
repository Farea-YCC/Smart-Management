class SaleModel {
  SaleModel({
      this.id, 
      this.productName, 
      this.quantity,
      this.amountPaid, 
      this.remainingAmount, 
      this.discount,
      this.customerName,
      this.dateOfAmount,});

  SaleModel.fromJson(dynamic json) {
    id = json['Id'];
    productName = json['productName'];
    quantity = json['Quantity'];
    amountPaid = json['amountPaid'];
    remainingAmount = json['remainingAmount'];
    discount = json['Discount'];
    customerName = json['customerName'];
    dateOfAmount = json['dateOfAmount'];
  }
  int? id;
  String? productName;
  int? quantity;
  int? amountPaid;
  int? remainingAmount;
  int? discount;
  String? customerName;
  String? dateOfAmount;
SaleModel copyWith({  int? id,
  String? productName,
  int? quantity,
  int? totalBill,
  int? amountPaid,
  int? remainingAmount,
  int? discount,
  String? customerName,
  String? dateOfAmount,
}) => SaleModel(  id: id ?? this.id,
  productName: productName ?? this.productName,
  quantity: quantity ?? this.quantity,
  amountPaid: amountPaid ?? this.amountPaid,
  remainingAmount: remainingAmount ?? this.remainingAmount,
  discount: discount ?? this.discount,
  customerName: customerName ?? this.customerName,
  dateOfAmount: dateOfAmount ?? this.dateOfAmount,
);
  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['Id'] = id;
    map['productName'] = productName;
    map['Quantity'] = quantity;
    map['amountPaid'] = amountPaid;
    map['remainingAmount'] = remainingAmount;
    map['Discount'] = discount;
    map['customerName'] = customerName;
    map['dateOfAmount'] = dateOfAmount;
    return map;
  }

}