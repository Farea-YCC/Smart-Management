import 'package:flutter/material.dart';
import 'package:smart_management/models/SupplierModel.dart';
import 'package:smart_management/repository/suppliers_repository.dart';
import 'suppliers_view.dart';

class SuppliersFormView extends StatefulWidget {
  @override
  _SuppliersFormViewState createState() => _SuppliersFormViewState();
}

class _SuppliersFormViewState extends State<SuppliersFormView> {
  bool _isLoading = false;
  String _resultMessage = '';
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _supplierNameCtr = TextEditingController();
  final TextEditingController _supplierLocationCtr = TextEditingController();
  final TextEditingController _phoneNumberCtr = TextEditingController();
  final TextEditingController _noteCtr = TextEditingController();

  Future<void> _submitForm() async {
    if (_formKey.currentState!.validate()) {
      setState(() {
        _isLoading = true;
      });

      String supplierName = _supplierNameCtr.text;
      String supplierLocation = _supplierLocationCtr.text;
      int phoneNumber = int.parse(_phoneNumberCtr.text);
      String note = _noteCtr.text;

      SupplierModel data = SupplierModel();
      data.supplierName = supplierName;
      data.supplierLocation = supplierLocation;
      data.phoneNumber = phoneNumber;
      data.note = note;

      bool success = await SuppliersRepository().addToDb(data);

      setState(() {
        _isLoading = false;
        _resultMessage = success ? 'تم الإضافة بنجاح!' : 'فشل!';
      });

      _supplierNameCtr.clear();
      _supplierLocationCtr.clear();
      _phoneNumberCtr.clear();
      _noteCtr.clear();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => SuppliersView()),
            );
          },
        ),
        title: const Text('الموردون'),
      ),
      resizeToAvoidBottomInset: true,
      body: WillPopScope(
        onWillPop: () async {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => SuppliersView()),
          );
          return true;
        },
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Form(
            key: _formKey,
            child: SingleChildScrollView(
              child: Column(
                children: [
                  Directionality(
                    textDirection: TextDirection.rtl,
                    child: _buildTextField(
                      controller: _supplierNameCtr,
                      hintText: 'اسم المورد',
                      inputType: TextInputType.text,
                    ),
                  ),
                  const SizedBox(height: 16.0),
                  Directionality(
                    textDirection: TextDirection.rtl,
                    child: _buildTextField(
                      controller: _supplierLocationCtr,
                      hintText: 'موقع المورد',
                      inputType: TextInputType.text,
                    ),
                  ),
                  const SizedBox(height: 16.0),
                  Directionality(
                    textDirection: TextDirection.rtl,
                    child: _buildTextField(
                      controller: _phoneNumberCtr,
                      hintText: 'رقم المورد',
                      inputType: TextInputType.number,
                    ),
                  ),
                  const SizedBox(height: 16.0),
                  Directionality(
                    textDirection: TextDirection.rtl,
                    child: _buildTextField(
                      controller: _noteCtr,
                      hintText: 'ملاحظة',
                      inputType: TextInputType.text,
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