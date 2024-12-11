import 'package:flutter/material.dart';
import '../../models/ExpensesModel.dart';
import '../../repository/expenses_repository.dart';
import 'expenses_views.dart';

class ExpensesFormView extends StatefulWidget {
  @override
  _ExpensesFormViewState createState() => _ExpensesFormViewState();
}

class _ExpensesFormViewState extends State<ExpensesFormView> {
  Future<DateTime?> _selectExpenseDate(BuildContext context) async {
    final DateTime? pickedDate = await showDatePicker(
        context: context,
        initialDate: DateTime.now(),
        firstDate: DateTime(1900),
        lastDate: DateTime.now()
    );
    if (pickedDate != null) {
      _dateOfExchangeCtr.text = pickedDate.toString();
    }
    return pickedDate;
  }

  bool _isLoading = false;
  String _resultMessage = '';
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _exchangeDestinationCtr = TextEditingController();
  final TextEditingController _amountSpentCtr = TextEditingController();
  final TextEditingController _dateOfExchangeCtr = TextEditingController();

  Future<void> _submitForm() async {
    if (_formKey.currentState!.validate()) {
      setState(() {
        _isLoading = true;
      });

      String exchangeDestination = _exchangeDestinationCtr.text;
      int amountSpent = int.parse(_amountSpentCtr.text);
      String dateOfExchange = _dateOfExchangeCtr.text;

      ExpensesModel data = ExpensesModel();
      data.exchangeDestination = exchangeDestination;
      data.amountSpent = amountSpent;
      data.dateOfExchange = dateOfExchange;

      bool success = await ExpensesRepository().addToDb(data);

      setState(() {
        _isLoading = false;
        _resultMessage = success ? 'تم الإضافة بنجاح!' : 'فشل!';
      });

      _exchangeDestinationCtr.clear();
      _amountSpentCtr.clear();
      _dateOfExchangeCtr.clear();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.push(context, MaterialPageRoute(builder: (context) => ExpensesView()));
          },
        ),
        title: const Text('المصروفات'),
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
                  child: _buildTextField(
                    controller: _exchangeDestinationCtr,
                    hintText: 'جهة الصرف',
                    inputType: TextInputType.text,
                  ),
                ),
                const SizedBox(height: 16.0),
                Directionality(
                  textDirection: TextDirection.rtl,
                  child: _buildTextField(
                    controller: _amountSpentCtr,
                    hintText: 'كمية الصرف',
                    inputType: TextInputType.number,
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
                    decoration: InputDecoration(
                      hintText: 'تاريخ الصرف',
                      hintStyle: TextStyle(
                        fontSize: 14,
                        color: Theme.of(context).brightness == Brightness.dark ? Colors.white : Colors.grey,
                      ),
                      contentPadding: const EdgeInsets.symmetric(vertical: 16, horizontal: 20),
                      filled: true,
                      fillColor: Theme.of(context).brightness == Brightness.dark ? Colors.black : Colors.white,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(16),
                        borderSide: BorderSide(
                          color: Theme.of(context).brightness == Brightness.dark ? Colors.white : Colors.grey,
                        ),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(16),
                        borderSide: BorderSide(
                          color: Theme.of(context).brightness == Brightness.dark ? Colors.white : Colors.grey,
                        ),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(16),
                        borderSide: BorderSide(
                          color: Theme.of(context).primaryColor,
                        ),
                      ),
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
                    style: ElevatedButton.styleFrom(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(16),
                      ),
                      padding: const EdgeInsets.symmetric(vertical: 16.0),
                    ),
                    child: _isLoading
                        ? const CircularProgressIndicator()
                        : const Text(
                      'حفـــظ',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 16.0,
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 16.0),
                Text(
                  _resultMessage,
                  style: TextStyle(
                    color: _resultMessage == 'فشل!' ? Colors.red : Colors.green,
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

  Widget _buildTextField({required TextEditingController controller, required String hintText, required TextInputType inputType}) {
    return TextFormField(
      controller: controller,
      keyboardType: inputType,
      decoration: InputDecoration(
        hintText: hintText,
        hintStyle: TextStyle(
          fontSize: 14,
          color: Theme.of(context).brightness == Brightness.dark ? Colors.white : Colors.grey,
        ),
        contentPadding: const EdgeInsets.symmetric(vertical: 16, horizontal: 20),
        filled: true,
        fillColor: Theme.of(context).brightness == Brightness.dark ? Colors.black : Colors.white,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16),
          borderSide: BorderSide(
            color: Theme.of(context).brightness == Brightness.dark ? Colors.white : Colors.grey,
          ),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16),
          borderSide: BorderSide(
            color: Theme.of(context).brightness == Brightness.dark ? Colors.white : Colors.grey,
          ),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16),
          borderSide: BorderSide(
            color: Theme.of(context).primaryColor,
          ),
        ),
      ),
      validator: (value) {
        if (value!.isEmpty) {
          return 'من فضلك ادخل $hintText';
        }
        return null;
      },
    );
  }
}
