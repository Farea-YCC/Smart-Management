import 'package:flutter/material.dart';

import '../../models/ExpensesModel.dart';
import '../../repository/expenses_repository.dart';
class ExpensesEditView extends StatefulWidget {
  ExpensesEditView({Key? key, required this.Id}) : super(key: key);
  final int Id;
  @override
  _ExpensesEditViewState createState() => _ExpensesEditViewState(Id: Id);
}

class _ExpensesEditViewState extends State<ExpensesEditView> {
  _ExpensesEditViewState({required this.Id});
  final int Id;
  bool _isLoading = false;
  String _resultMessage = '';
  ExpensesModel _list = new ExpensesModel();
  final _formKey = GlobalKey<FormState>();
  int idedite = 0;

  TextEditingController _exchangeDestinationCtr = TextEditingController(); //
  TextEditingController _amountSpentCtr = TextEditingController();
  TextEditingController _dateOfExchangeCtr = TextEditingController();
  void initState() {
    super.initState();
    getData();
  }

  Future<void> getData() async {
    _isLoading = true;
    _list = (await ExpensesRepository().getById(this.Id))!;
    idedite = int.parse(_list.id.toString());
    _exchangeDestinationCtr.text = _list.exchangeDestination.toString();
    _amountSpentCtr.text = _list.amountSpent.toString();
    _dateOfExchangeCtr.text = _list.dateOfExchange.toString();
    _isLoading = false;
    setState(() {});
  }

  Future<void> _submitForm() async {
    if (_formKey.currentState!.validate()) {
      setState(() {
        _isLoading = true;
      });

      String exchangeDestination = _exchangeDestinationCtr.text; //
      int amountSpent = int.parse(_amountSpentCtr.text);
      String dateOfExchange = _dateOfExchangeCtr.text;

      ExpensesModel data = ExpensesModel(); //
      data.exchangeDestination = exchangeDestination;
      data.amountSpent = amountSpent;
      data.dateOfExchange = dateOfExchange;

      bool success = await ExpensesRepository().addToDb(data); //

      setState(() {
        _isLoading = false;
        _resultMessage = success ? 'Successfully added!' : 'Failure!';
      });

      _exchangeDestinationCtr.clear(); //
      _amountSpentCtr.clear();
      _dateOfExchangeCtr.clear();
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
        title: const Text(' المصروفات'),
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
                    controller: _exchangeDestinationCtr,
                    keyboardType: TextInputType.text,
                    decoration: const InputDecoration(
                      hintText: 'جهة الصرف ',
                      border: OutlineInputBorder(),
                    ),
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'من فضلك ادخل جهة الصرف';
                      }
                      return null;
                    },
                  ),
                ),
                const SizedBox(height: 16.0),
                Directionality(
                  textDirection: TextDirection.rtl,
                  child: TextFormField(
                    controller: _amountSpentCtr,
                    keyboardType: TextInputType.number,
                    decoration: const InputDecoration(
                      hintText: ' كمية الصرف',
                      border: OutlineInputBorder(),
                    ),
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'من فضلك ادخل كمية الصرف';
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
                        _dateOfExchangeCtr.text = pickedDate.toString();
                      }
                    },
                    keyboardType: TextInputType.datetime,
                    controller: _dateOfExchangeCtr,
                    decoration: const InputDecoration(
                      hintText: 'تاريخ الصرف',
                      border: OutlineInputBorder(),
                    ),
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'من فضلك ادخل تاريخ الصرف';
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
