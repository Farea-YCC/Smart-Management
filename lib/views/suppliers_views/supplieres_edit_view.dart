import 'package:flutter/material.dart';
import 'package:smart_management/common/widget/custom_appbar.dart';
import 'package:smart_management/models/SupplierModel.dart';
import 'package:smart_management/repository/suppliers_repository.dart';
class SupplieresEditView extends StatefulWidget {
  SupplieresEditView({Key? key, required this.Id}) : super(key: key);
  final int Id;
  @override
  _SupplieresEditViewState createState() => _SupplieresEditViewState(Id: Id);
}

class _SupplieresEditViewState extends State<SupplieresEditView> {
  _SupplieresEditViewState({required this.Id});

  final int Id;
  bool _isLoading = false;
  String _resultMessage = '';
  SupplierModel _list = new SupplierModel();
  int idedite = 0;

  final _formKey = GlobalKey<FormState>();
  TextEditingController _supplierNameCtr = TextEditingController();
  TextEditingController _supplierLocationCtr = TextEditingController();
  TextEditingController _phoneNumberCtr = TextEditingController();
  TextEditingController _noteCtr = TextEditingController();

  void initState() {
    super.initState();
    getData();
  }

  Future<void> getData() async {
    _isLoading = true;
    _list = (await SuppliersRepository().getById(this.Id))!;
    idedite = int.parse(_list.id.toString());
    _supplierNameCtr.text = _list.supplierName.toString();
    _supplierLocationCtr.text = _list.supplierLocation.toString();
    _phoneNumberCtr.text = _list.phoneNumber.toString();
    _noteCtr.text = _list.note.toString();

    _isLoading = false;
    setState(() {});
  }

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
        _resultMessage = success ? 'Successfully added!' : 'Failure!';
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
      appBar: customeAppBar(context, "  "),
      resizeToAvoidBottomInset: true,
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
                    controller: _supplierNameCtr,
                    decoration: const InputDecoration(
                      hintText: 'اسم المورد',
                      border: OutlineInputBorder(),
                    ),
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'من فضلك ادخل اسم المورد';
                      }
                      return null;
                    },
                  ),
                ),
                const SizedBox(height: 16.0),
                Directionality(
                  textDirection: TextDirection.rtl,
                  child: TextFormField(
                    controller: _supplierLocationCtr,
                    keyboardType: TextInputType.text,
                    decoration: const InputDecoration(
                      hintText: 'موقع المورد',
                      border: OutlineInputBorder(),
                    ),
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'من فضلك ادخل موقع المورد';
                      }
                      return null;
                    },
                  ),
                ),
                const SizedBox(height: 16.0),
                Directionality(
                  textDirection: TextDirection.rtl,
                  child: TextFormField(
                    controller: _phoneNumberCtr,
                    keyboardType: TextInputType.number,
                    decoration: const InputDecoration(
                      hintText: 'رقم المورد ',
                      border: OutlineInputBorder(),
                    ),
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'من فضلك ادخل رقم المورد';
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
                    controller: _noteCtr,
                    decoration: const InputDecoration(
                      hintText: 'ملاحظة',
                      border: OutlineInputBorder(),
                    ),
                    validator: (value) {
                      if (value!.isEmpty) {
                        return ' من فضلك ادخل ملاظة ';
                      }
                      return null;
                    },
                  ),
                ), //selection day
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
