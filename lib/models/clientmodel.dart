class ClientModel {
  ClientModel({
    this.id,
    this.clientName,
    this.clientLocation,
    this.phoneNumber,
    this.note,
    this.debitMoney,
    this.creditMoney,
    this.dateOfRegister,
    this.amountPaid,
  });

  ClientModel.fromJson(dynamic json) {
    id = json['Id'];
    clientName = json['clientName'];
    clientLocation = json['clientLocation'];
    phoneNumber = json['phoneNumber'];
    note = json['Note'];
    debitMoney = json['DebitMoney'];
    creditMoney = json['CreditMoney'];
    dateOfRegister = json['DateOfRegister'];
    amountPaid = json['AmountPaid'];
  }

  int? id;
  String? clientName;
  String? clientLocation;
  int? phoneNumber;
  String? note;
  int? debitMoney;
  int? creditMoney;
  String? dateOfRegister;
  int? amountPaid;

  ClientModel copyWith({
    int? id,
    String? clientName,
    String? clientLocation,
    int? phoneNumber,
    String? note,
    int? debitMoney,
    int? creditMoney,
    String? dateOfRegister,
    int? amountPaid,
  }) =>
      ClientModel(
        id: id ?? this.id,
        clientName: clientName ?? this.clientName,
        clientLocation: clientLocation ?? this.clientLocation,
        phoneNumber: phoneNumber ?? this.phoneNumber,
        note: note ?? this.note,
        debitMoney: debitMoney ?? this.debitMoney,
        creditMoney: creditMoney ?? this.creditMoney,
        dateOfRegister: dateOfRegister ?? this.dateOfRegister,
        amountPaid: amountPaid ?? this.amountPaid,
      );

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['Id'] = id;
    map['clientName'] = clientName;
    map['clientLocation'] = clientLocation;
    map['phoneNumber'] = phoneNumber;
    map['Note'] = note;
    map['DebitMoney'] = debitMoney;
    map['CreditMoney'] = creditMoney;
    map['DateOfRegister'] = dateOfRegister;
    map['AmountPaid'] = amountPaid;
    return map;
  }
}
