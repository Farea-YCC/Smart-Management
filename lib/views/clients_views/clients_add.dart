import 'package:flutter/material.dart';
import '../../models/ClientModel.dart';
import '../../repository/clients_repository.dart';
import 'clients_views.dart';

class ClientsAdd extends StatefulWidget {
  const ClientsAdd({super.key});

  @override
  _ClientsAddState createState() => _ClientsAddState();
}

class _ClientsAddState extends State<ClientsAdd> {
  bool _isLoading = false;
  String _resultMessage = '';
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _clientNameCtr = TextEditingController();
  final TextEditingController _clientLocationCtr = TextEditingController();
  final TextEditingController _phoneNumberCtr = TextEditingController();
  final TextEditingController _notesCtr = TextEditingController();
  final TextEditingController _debitMoneyCtr = TextEditingController();
  final TextEditingController _creditMoneyCtr = TextEditingController();
  final TextEditingController _dateOfRegisterCtr = TextEditingController();
  final TextEditingController _amountPaidCtr = TextEditingController();

  Future<DateTime?> _selectExpenseDate(BuildContext context) async {
    final DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(1900),
      lastDate: DateTime.now(),
    );
    if (pickedDate != null) {
      _dateOfRegisterCtr.text =
          pickedDate.toLocal().toString().split(' ')[0]; // تنسيق التاريخ
    }
    return pickedDate;
  }

  Future<void> _submitForm() async {
    if (_formKey.currentState!.validate()) {
      setState(() {
        _isLoading = true;
      });

      try {
        String clientName = _clientNameCtr.text;
        String clientLocation = _clientLocationCtr.text;
        int phoneNumber = int.parse(_phoneNumberCtr.text);
        String notes = _notesCtr.text;
        int debitMoney = int.parse(_debitMoneyCtr.text);
        int creditMoney = int.parse(_creditMoneyCtr.text);
        String dateOfRegister = _dateOfRegisterCtr.text;
        int amountPaid = int.parse(_amountPaidCtr.text);

        ClientModel data = ClientModel(
          clientName: clientName,
          clientLocation: clientLocation,
          phoneNumber: phoneNumber,
          note: notes,
          debitMoney: debitMoney,
          creditMoney: creditMoney,
          dateOfRegister: dateOfRegister,
          amountPaid: amountPaid,
        );

        bool success = await ClientsRepository().addToDb(data);

        setState(() {
          _isLoading = false;
          _resultMessage = success ? 'تم الإضافة بنجاح!' : 'فشل!';
        });

        _clearFormFields();

        if (success) {
          Future.delayed(const Duration(seconds: 1), () {
            Navigator.of(context).pop(true);
          });
        }
      } catch (e) {
        setState(() {
          _isLoading = false;
          _resultMessage = 'حدث خطأ: ${e.toString()}';
        });
      }
    }
  }

  void _clearFormFields() {
    _clientNameCtr.clear();
    _clientLocationCtr.clear();
    _phoneNumberCtr.clear();
    _notesCtr.clear();
    _debitMoneyCtr.clear();
    _creditMoneyCtr.clear();
    _dateOfRegisterCtr.clear();
    _amountPaidCtr.clear();
  }

  @override
  void dispose() {
    _clientNameCtr.dispose();
    _clientLocationCtr.dispose();
    _phoneNumberCtr.dispose();
    _notesCtr.dispose();
    _debitMoneyCtr.dispose();
    _creditMoneyCtr.dispose();
    _dateOfRegisterCtr.dispose();
    _amountPaidCtr.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        resizeToAvoidBottomInset: true,
        appBar: AppBar(
          leading: IconButton(
            icon: const Icon(Icons.arrow_back_ios),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const ClientsView()),
              );
            },
          ),
          title: const Text('إضافة عميل'),
        ),
        body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Form(
            key: _formKey,
            child: SingleChildScrollView(
              child: Column(
                children: [
                  _buildTextField(
                      controller: _clientNameCtr,
                      hintText: 'اسم العميل',
                      inputType: TextInputType.text,
                      maxLength: 30),
                  const SizedBox(height: 16.0),
                  _buildTextField(
                      controller: _clientLocationCtr,
                      hintText: 'موقع العميل',
                      inputType: TextInputType.text,
                      maxLength: 15),
                  const SizedBox(height: 16.0),
                  _buildTextField(
                      controller: _phoneNumberCtr,
                      hintText: 'رقم العميل',
                      inputType: TextInputType.number,
                      maxLength: 9),
                  const SizedBox(height: 16.0),
                  _buildTextField(
                      controller: _debitMoneyCtr,
                      hintText: ' له',
                      inputType: TextInputType.number),
                  const SizedBox(height: 16.0),
                  _buildTextField(
                      controller: _creditMoneyCtr,
                      hintText: ' عليه',
                      inputType: TextInputType.number),
                  const SizedBox(height: 16.0),
                  _buildTextField(
                    controller: _dateOfRegisterCtr,
                    hintText: 'تاريخ التسجيل',
                    inputType: TextInputType.datetime,
                    readOnly: true,
                    onTap: () async {
                      final pickedDate = await _selectExpenseDate(context);
                      if (pickedDate != null) {
                        _dateOfRegisterCtr.text =
                            pickedDate.toLocal().toString().split(' ')[0];
                      }
                    },
                  ),
                  const SizedBox(height: 16.0),
                  _buildTextField(
                      controller: _amountPaidCtr,
                      hintText: 'المبلغ المدفوع',
                      inputType: TextInputType.number),
                  const SizedBox(height: 16.0),
                  _buildTextField(
                      controller: _notesCtr,
                      hintText: 'ملاحظات',
                      inputType: TextInputType.text),
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
                                color: Colors.blue,
                                fontWeight: FontWeight.bold,
                                fontSize: 20.0,
                              ),
                            ),
                    ),
                  ),
                  const SizedBox(height: 16.0),
                  Text(
                    _resultMessage,
                    style: TextStyle(
                      color:
                          _resultMessage == 'فشل!' ? Colors.red : Colors.green,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
///في اشياء مضافة
  Widget _buildTextField({
    required TextEditingController controller,
    required String hintText,
    required TextInputType inputType,
    int? maxLength,
    bool readOnly = false,
    VoidCallback? onTap,
  }) {
    return TextFormField(
      controller: controller,
      keyboardType: inputType,
      maxLength: maxLength,
      readOnly: readOnly,
      onTap: onTap,
      autocorrect: true,
      autovalidateMode: AutovalidateMode.always,
      enableInteractiveSelection: true,
      decoration: InputDecoration(
        hintText: hintText,
        counterText: '',
        filled: true,
        fillColor: Theme.of(context).brightness == Brightness.dark
            ? Colors.black
            : Colors.white,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16),
        ),
      ),
      validator: (value) {
        if (value!.isEmpty) {
          return 'من فضلك ادخل $hintText';
        }
        if (hintText == 'اسم العميل' && value.length > 30) {
          return 'اسم العميل لا يجب أن يزيد عن 30 حرف';
        }
        if (hintText == 'موقع العميل' && value.length > 15) {
          return 'موقع العميل لا يجب أن يزيد عن 15 حرف';
        }
        if (hintText == 'رقم العميل') {
          if (value.length < 9) {
            return 'رقم الهاتف يجب أن يتكون من 9 أرقام';
          }
          if (!RegExp(r'^(71|70|73|78|77)\d{7}$').hasMatch(value)) {
            return 'رقم الهاتف يجب أن يبدأ بـ 71 أو 70 أو 73 أو 78 أو 77';
          }
          if (value.length > 9) {
            return 'رقم الهاتف يجب أن يتكون من 9 أرقام';
          }
        }
        return null;
      },
      onChanged: (value) {
        setState(() {});
      },
    );
  }
}
