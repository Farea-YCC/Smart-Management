import 'package:flutter/material.dart';

import '../../models/SaleModel.dart';
import '../../repository/sales_repository.dart';
class SalesEditView extends StatefulWidget {
  SalesEditView({Key? key, required this.Id}) : super(key: key);
  final int Id;
  @override
  _SalesEditViewState createState() => _SalesEditViewState(Id: Id);
}

class _SalesEditViewState extends State<SalesEditView> {
  _SalesEditViewState({required this.Id});

  final int Id;
  bool _isLoading = false;
  String _resultMessage = '';
  SaleModel _list = new SaleModel();
  int idedite = 0;

  final _formKey = GlobalKey<FormState>();
  TextEditingController _productNameCtr = TextEditingController(); //
  TextEditingController _quantityCtr = TextEditingController();
  TextEditingController _amountPaidCtr = TextEditingController();
  TextEditingController _remainingAmountCtr = TextEditingController();
  TextEditingController _discountCtr = TextEditingController();
  TextEditingController _customerNameCtr = TextEditingController();
  TextEditingController _dateOfAmountCtr = TextEditingController();

  void initState() {
    super.initState();
    getData();
  }

  Future<void> getData() async {
    _isLoading = true;
    _list = (await SalesRepository().getById(this.Id))!;
    idedite = int.parse(_list.id.toString());
    _productNameCtr.text = _list.productName.toString();
    _quantityCtr.text = _list.quantity.toString();
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
      int amountPaid = int.parse(_amountPaidCtr.text);
      int remainingAmount = int.parse(_remainingAmountCtr.text);
      int discount = int.parse(_discountCtr.text);
      String customerName = _customerNameCtr.text;
      String dateOfAmount = _dateOfAmountCtr.text;

      SaleModel data = SaleModel(); //
      data.productName = productName;
      data.quantity = quantity;
      data.amountPaid = amountPaid;
      data.remainingAmount = remainingAmount;
      data.discount = discount;
      data.customerName = customerName;
      data.dateOfAmount = dateOfAmount;

      bool success = await SalesRepository().addToDb(data); //

      setState(() {
        _isLoading = false;
        _resultMessage = success ? 'Successfully added!' : 'Failure!';
      });

      _productNameCtr.clear(); //
      _quantityCtr.clear();
      _amountPaidCtr.clear();
      _remainingAmountCtr.clear();
      _discountCtr.clear();
      _customerNameCtr.clear();
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
        title: const Text('المبيعات'),
      ),
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
                      hintText: 'اسم المنتج',
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
                        return ' من فضلك ادخل الكمية';
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
                      hintText: 'الكمية المدفوعة',
                      border: OutlineInputBorder(),
                    ),
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'من فضلك ادحل الكمية المدفوعة';
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
                      hintText: 'الكمية المتبقية ',
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
                        return 'من فضلك ادخل الخصم';
                      }
                      return null;
                    },
                  ),
                ),
                const SizedBox(height: 16.0),
                Directionality(
                  textDirection: TextDirection.rtl,
                  child: TextFormField(
                    controller: _customerNameCtr,
                    keyboardType: TextInputType.text,
                    decoration: const InputDecoration(
                      hintText: 'اسم العميل',
                      border: OutlineInputBorder(),
                    ),
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'من فضلك ادخل اسم العميل';
                      }
                      return null;
                    },
                  ),
                ),
                const SizedBox(height: 16.0),
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
                      hintText: 'تاريخ الدفع',
                      border: OutlineInputBorder(),
                    ),
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'من فضلك ادخل';
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
