class ExpensesModel {
  ExpensesModel({
      this.id, 
      this.exchangeDestination,
      this.amountSpent,
      this.dateOfExchange,});

  ExpensesModel.fromJson(dynamic json) {
    id = json['Id'];
    exchangeDestination = json['exchangeDestination'];
    amountSpent = json['amountSpent'];
    dateOfExchange = json['dateOfExchange'];
  }
  int? id;
  String? exchangeDestination;
  int? amountSpent;
  String? dateOfExchange;

ExpensesModel copyWith({  int? id,
  String? exchangeDestination,
  int? amountSpent,
  String? dateOfExchange,
}) => ExpensesModel(  id: id ?? this.id,
  exchangeDestination: exchangeDestination ?? this.exchangeDestination,
  amountSpent: amountSpent ?? this.amountSpent,
  dateOfExchange: dateOfExchange ?? this.dateOfExchange,
);
  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['Id'] = id;
    map['exchangeDestination'] = exchangeDestination;
    map['amountSpent'] = amountSpent;
    map['dateOfExchange'] = dateOfExchange;
    return map;
  }

}