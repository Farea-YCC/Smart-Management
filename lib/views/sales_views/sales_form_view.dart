import 'package:flutter/material.dart';
import '../../models/SaleModel.dart';
import '../../repository/sales_repository.dart';
import 'sales_view.dart';

class SalesFormView extends StatefulWidget {
  @override
  _SalesFormViewState createState() => _SalesFormViewState();
}

class _SalesFormViewState extends State<SalesFormView> {
  bool _isLoading = false;
  String _resultMessage = '';

  final _formKey = GlobalKey<FormState>();
  final TextEditingController _productNameCtr = TextEditingController();
  final TextEditingController _quantityCtr = TextEditingController();
  final TextEditingController _amountPaidCtr = TextEditingController();
  final TextEditingController _remainingAmountCtr = TextEditingController();
  final TextEditingController _discountCtr = TextEditingController();
  final TextEditingController _customerNameCtr = TextEditingController();
  final TextEditingController _dateOfAmountCtr = TextEditingController();

  Future<void> _submitForm() async {
    if (_formKey.currentState!.validate()) {
      setState(() {
        _isLoading = true;
      });

      String productName = _productNameCtr.text;
      int quantity = int.parse(_quantityCtr.text);
      int amountPaid = int.parse(_amountPaidCtr.text);
      int remainingAmount = int.parse(_remainingAmountCtr.text);
      int discount = int.parse(_discountCtr.text);
      String customerName = _customerNameCtr.text;
      String dateOfAmount = _dateOfAmountCtr.text;

      SaleModel data = SaleModel();
      data.productName = productName;
      data.quantity = quantity;
      data.amountPaid = amountPaid;
      data.remainingAmount = remainingAmount;
      data.discount = discount;
      data.customerName = customerName;
      data.dateOfAmount = dateOfAmount;

      bool success = await SalesRepository().addToDb(data);

      setState(() {
        _isLoading = false;
        _resultMessage = success ? 'تم الإضافة بنجاح!' : 'فشل!';
      });

      _productNameCtr.clear();
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
      firstDate: DateTime(1900),
      lastDate: DateTime.now(),
    );
    if (pickedDate != null) {
      _dateOfAmountCtr.text = pickedDate.toString();
    }
    return pickedDate;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => SalesView()),
            );
          },
        ),
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
                  child: _buildTextField(
                    controller: _productNameCtr,
                    hintText: 'اسم المنتج',
                    inputType: TextInputType.text,
                  ),
                ),
                const SizedBox(height: 16.0),
                Directionality(
                  textDirection: TextDirection.rtl,
                  child: _buildTextField(
                    controller: _quantityCtr,
                    hintText: 'الكمية',
                    inputType: TextInputType.number,
                  ),
                ),
                const SizedBox(height: 16.0),
                Directionality(
                  textDirection: TextDirection.rtl,
                  child: _buildTextField(
                    controller: _amountPaidCtr,
                    hintText: 'الكمية المدفوعة',
                    inputType: TextInputType.number,
                  ),
                ),
                const SizedBox(height: 16.0),
                Directionality(
                  textDirection: TextDirection.rtl,
                  child: _buildTextField(
                    controller: _remainingAmountCtr,
                    hintText: 'الكمية المتبقية',
                    inputType: TextInputType.number,
                  ),
                ),
                const SizedBox(height: 16.0),
                Directionality(
                  textDirection: TextDirection.rtl,
                  child: _buildTextField(
                    controller: _discountCtr,
                    hintText: 'الخصم',
                    inputType: TextInputType.number,
                  ),
                ),
                const SizedBox(height: 16.0),
                Directionality(
                  textDirection: TextDirection.rtl,
                  child: _buildTextField(
                    controller: _customerNameCtr,
                    hintText: 'اسم العميل',
                    inputType: TextInputType.text,
                  ),
                ),
                const SizedBox(height: 16.0),
                Directionality(
                  textDirection: TextDirection.rtl,
                  child: _buildTextField(
                    controller: _dateOfAmountCtr,
                    hintText: 'تاريخ الدفع',
                    inputType: TextInputType.datetime,
                    readOnly: true,
                    onTap: () async {
                      final pickedDate = await _selectExpenseDate(context);
                      if (pickedDate != null) {
                        _dateOfAmountCtr.text = pickedDate.toString();
                      }
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
                      'حفــــظ',
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

  Widget _buildTextField({
    required TextEditingController controller,
    required String hintText,
    required TextInputType inputType,
    bool readOnly = false,
    void Function()? onTap,
  }) {
    return TextFormField(
      controller: controller,
      keyboardType: inputType,
      readOnly: readOnly,
      onTap: onTap,
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
