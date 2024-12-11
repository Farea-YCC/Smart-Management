class SupplierModel {
  SupplierModel({
      this.id, 
      this.supplierName, 
      this.supplierLocation, 
      this.phoneNumber, 
      this.note,});

  SupplierModel.fromJson(dynamic json) {
    id = json['Id'];
    supplierName = json['supplierName'];
    supplierLocation = json['supplierLocation'];
    phoneNumber = json['phoneNumber'];
    note = json['Note'];
  }
  int? id;
  String? supplierName;
  String? supplierLocation;
  int? phoneNumber;
  String? note;
SupplierModel copyWith({  int? id,
  String? supplierName,
  String? supplierLocation,
  int? phoneNumber,
  String? note,
}) => SupplierModel(  id: id ?? this.id,
  supplierName: supplierName ?? this.supplierName,
  supplierLocation: supplierLocation ?? this.supplierLocation,
  phoneNumber: phoneNumber ?? this.phoneNumber,
  note: note ?? this.note,
);
  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['Id'] = id;
    map['supplierName'] = supplierName;
    map['supplierLocation'] = supplierLocation;
    map['phoneNumber'] = phoneNumber;
    map['Note'] = note;
    return map;
  }

}