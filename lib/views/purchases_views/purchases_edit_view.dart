import 'package:flutter/material.dart';

import '../../models/PurchaseModel.dart';
import '../../repository/purchases_repository.dart';
class PurchasesEditView extends StatefulWidget {
  PurchasesEditView({Key? key, required this.Id}) : super(key: key);
  final int Id;
  @override
  _PurchasesEditViewState createState() => _PurchasesEditViewState(Id: Id);
}

class _PurchasesEditViewState extends State<PurchasesEditView> {
  _PurchasesEditViewState({required this.Id});

  final int Id;
  bool _isLoading = false;
  String _resultMessage = '';
  PurchaseModel _list = new PurchaseModel();
  int idedite = 0;

  final _formKey = GlobalKey<FormState>();
  TextEditingController _productNameCtr = TextEditingController(); //
  TextEditingController _quantityCtr = TextEditingController();
  TextEditingController _purchasePriceCtr = TextEditingController();
  TextEditingController _salePriceCtr = TextEditingController();
  TextEditingController _supplierCtr = TextEditingController();

  TextEditingController _amountPaidCtr = TextEditingController();
  TextEditingController _remainingAmountCtr = TextEditingController();
  TextEditingController _discountCtr = TextEditingController();
  TextEditingController _dateOfAmountCtr = TextEditingController();

  void initState() {
    super.initState();
    getData();
  }

  Future<void> getData() async {
    _isLoading = true;
    _list = (await PurchasesRepository().getById(this.Id))!;
    idedite = int.parse(_list.id.toString());
    _productNameCtr.text = _list.productName.toString();
    _quantityCtr.text = _list.quantity.toString();
    _purchasePriceCtr.text = _list.purchasePrice.toString();
    _salePriceCtr.text = _list.salePrice.toString();
    _supplierCtr.text = _list.supplier.toString();
    _amountPaidCtr.text = _list.amountPaid.toString();
    _remainingAmountCtr.text = _list.remainingAmount.toString();
    _discountCtr.text = _list.discount.toString();
    _dateOfAmountCtr.text = _list.dateOfAmount.toString();

    _isLoading = false;
    setState(() {});
  }

  Future<void> _submitForm() async {
    if (_formKey.currentState!.validate()) {
      setState(() {
        _isLoading = true;
      });

      String productName = _productNameCtr.text; //
      int quantity = int.parse(_quantityCtr.text);
      int purchasePrice = int.parse(_purchasePriceCtr.text);
      int salePrice = int.parse(_salePriceCtr.text); //
      String supplier = _supplierCtr.text;
      int amountPaid = int.parse(_amountPaidCtr.text);
      int remainingAmount = int.parse(_remainingAmountCtr.text); //
      int discount = int.parse(_discountCtr.text);
      String dateOfAmount = _dateOfAmountCtr.text;

      PurchaseModel data = PurchaseModel(); //
      data.productName = productName;
      data.quantity = quantity;
      data.purchasePrice = purchasePrice;
      data.salePrice = salePrice;
      data.supplier = supplier;
      data.amountPaid = amountPaid;
      data.remainingAmount = remainingAmount;
      data.discount = discount;
      data.dateOfAmount = dateOfAmount;

      bool success = await PurchasesRepository().addToDb(data); //

      setState(() {
        _isLoading = false;
        _resultMessage = success ? 'Successfully added!' : 'Failure!';
      });

      _productNameCtr.clear(); //
      _quantityCtr.clear();
      _purchasePriceCtr.clear();
      _salePriceCtr.clear(); //
      _supplierCtr.clear();
      _amountPaidCtr.clear();
      _remainingAmountCtr.clear(); //
      _discountCtr.clear();
      _dateOfAmountCtr.clear();
    }
  }
  Future<DateTime?> _selectExpenseDate(BuildContext context) async {
    final DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2100),
    );
    return pickedDate;
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      appBar: AppBar(
        title: const Text('المشتريات'),),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: SingleChildScrollView(
            child: Column(
              children: [
                Directionality(
                  textDirection: TextDirection.rtl,
                  child: TextFormField(
                    controller: _productNameCtr,
                    keyboardType: TextInputType.text,
                    decoration: const InputDecoration(
                      hintText: 'اسم المنتج ',
                      border: OutlineInputBorder(),
                    ),
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'من فضلك ادخل اسم المنتج';
                      }
                      return null;
                    },
                  ),
                ),
                const SizedBox(height: 16.0),
                Directionality(
                  textDirection: TextDirection.rtl,
                  child: TextFormField(
                    controller: _quantityCtr,
                    keyboardType: TextInputType.number,
                    decoration: const InputDecoration(
                      hintText: 'الكمية',
                      border: OutlineInputBorder(),
                    ),
                    validator: (value) {
                      if (value!.isEmpty) {
                        return ' من فضلك ادحل الكمية';
                      }
                      return null;
                    },
                  ),
                ),
                const SizedBox(height: 16.0),
                Directionality(
                  textDirection: TextDirection.rtl,
                  child: TextFormField(
                    controller: _purchasePriceCtr,
                    keyboardType: TextInputType.number,
                    decoration: const InputDecoration(
                      hintText: 'سعر الشراء',
                      border: OutlineInputBorder(),
                    ),
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'من فضلك ادخل سعر الشراء ';
                      }
                      return null;
                    },
                  ),
                ),
                const SizedBox(height: 16.0),
                Directionality(
                  textDirection: TextDirection.rtl,
                  child: TextFormField(
                    controller: _salePriceCtr,
                    keyboardType: TextInputType.number,
                    decoration: const InputDecoration(
                      hintText: 'سعر البيع ',
                      border: OutlineInputBorder(),
                    ),
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'من فضلك ادخل سعر البيع ';
                      }
                      return null;
                    },
                  ),
                ),
                const SizedBox(height: 16.0),
                Directionality(
                  textDirection: TextDirection.rtl,
                  child: TextFormField(
                    controller: _supplierCtr,
                    keyboardType: TextInputType.text,
                    decoration: const InputDecoration(
                      hintText: 'اسم المورد',
                      border: OutlineInputBorder(),
                    ),
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'من فضلك ادخل اسم المورد ';
                      }
                      return null;
                    },
                  ),
                ),
                const SizedBox(height: 16.0),
                Directionality(
                  textDirection: TextDirection.rtl,
                  child: TextFormField(
                    controller: _amountPaidCtr,
                    keyboardType: TextInputType.number,
                    decoration: const InputDecoration(
                      hintText: ' الكمية المدفوعة',
                      border: OutlineInputBorder(),
                    ),
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'من فضلك ادخل  الكمية المدفوعة ';
                      }
                      return null;
                    },
                  ),
                ),
                const SizedBox(height: 16.0),
                Directionality(
                  textDirection: TextDirection.rtl,
                  child: TextFormField(
                    controller: _remainingAmountCtr,
                    keyboardType: TextInputType.number,
                    decoration: const InputDecoration(
                      hintText: 'الكمية المتبقية',
                      border: OutlineInputBorder(),
                    ),
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'من فضلك ادخل الكمية المتبقية';
                      }
                      return null;
                    },
                  ),
                ),
                const SizedBox(height: 16.0),
                Directionality(
                  textDirection: TextDirection.rtl,
                  child: TextFormField(
                    controller: _discountCtr,
                    keyboardType: TextInputType.number,
                    decoration: const InputDecoration(
                      hintText: 'الخصم',
                      border: OutlineInputBorder(),
                    ),
                    validator: (value) {
                      if (value!.isEmpty) {
                        return ' ادخل الخصم';
                      }
                      return null;
                    },
                  ),
                ),
                const SizedBox(height: 16.0),
                Directionality(
                  textDirection: TextDirection.rtl,
                  child: TextFormField(
                    readOnly: true,
                    onTap: () async {
                      final pickedDate = await _selectExpenseDate(context);
                      if (pickedDate != null) {
                        _dateOfAmountCtr.text = pickedDate.toString();
                      }
                    },
                    keyboardType: TextInputType.datetime,
                    controller: _dateOfAmountCtr,
                    decoration: const InputDecoration(
                      hintText: 'تاريخ الشراء',
                      border: OutlineInputBorder(),
                    ),
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'من فضلك ادخل تاريخ الشراء';
                      }
                      return null;
                    },
                  ),
                ),
                const SizedBox(height: 16.0),
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: _isLoading ? null : _submitForm,
                    child: _isLoading
                        ? const CircularProgressIndicator() // Show loading indicator
                        : Container(
                            height: 50,
                            child: const Center(
                                child: Text(
                              'حفــــظ',
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ))),
                  ),
                ),
                const SizedBox(height: 16.0),
                Text(
                  _resultMessage,
                  style: TextStyle(
                    color: _resultMessage == 'Failure!'
                        ? Colors.red
                        : Colors.green,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
