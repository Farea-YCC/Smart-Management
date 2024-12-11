// import 'package:flutter/material.dart';
// import '../../models/ClientModel.dart';
// import '../../repository/clients_repository.dart';
// import 'clients_views.dart';
//
// class ClientsEditView extends StatefulWidget {
//   ClientsEditView({Key? key, required this.Id}) : super(key: key);
//   final int Id;
//   @override
//   _ClientsEditViewState createState() => _ClientsEditViewState(Id: Id);
// }
//
// class _ClientsEditViewState extends State<ClientsEditView> {
//   _ClientsEditViewState({required this.Id});
//   final int Id;
//   bool _isLoading = false;
//   String _resultMessage = '';
//   ClientModel _list = new ClientModel();
//   final _formKey = GlobalKey<FormState>();
//   int idedite = 0;
//   TextEditingController _clientNameCtr = TextEditingController();
//   TextEditingController _clientLocationCtr = TextEditingController();
//   TextEditingController _phoneNumberCtr = TextEditingController();
//   TextEditingController _notesCtr = TextEditingController();
//   void initState() {
//     super.initState();
//     getData();
//   }
//
//   Future<void> getData() async {
//     _isLoading = true;
//     _list = (await ClientsRepository().getById(this.Id))!;
//     idedite = int.parse(_list.id.toString());
//     _clientNameCtr.text = _list.clientName.toString();
//     _clientLocationCtr.text = _list.clientLocation.toString();
//     _phoneNumberCtr.text = _list.phoneNumber.toString();
//     _notesCtr.text = _list.note.toString();
//     _isLoading = false;
//     setState(() {});
//   }
//
//   Future<void> _submitForm() async {
//     if (_formKey.currentState!.validate()) {
//       setState(() {
//         _isLoading = true;
//       });
//       String clientName = _clientNameCtr.text;
//       String clientLocation = _clientLocationCtr.text;
//       int phoneNumber = int.parse(_phoneNumberCtr.text);
//       String notes = _notesCtr.text;
//
//       ClientModel data = ClientModel();
//       data.clientName = clientName;
//       data.clientLocation = clientLocation;
//       data.phoneNumber = phoneNumber;
//       data.note = notes;
//       data.id = idedite;
//       bool success = await ClientsRepository().updateToDb(data);
//
//       setState(() {
//         _isLoading = false;
//         _resultMessage = success ? 'Successfully added!' : 'Failure!';
//       });
//
//       _clientNameCtr.clear();
//       _clientLocationCtr.clear();
//       _phoneNumberCtr.clear();
//       _notesCtr.clear();
//       Navigator.push(
//         context,
//         MaterialPageRoute(builder: (context) => const ClientsView()),
//       );
//     }
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       resizeToAvoidBottomInset: true,
//       appBar: AppBar(
//         title: const Text('تعديل بيانات العملاء'),
//         leading: IconButton(
//           icon: const Icon(Icons.arrow_back_ios),
//           onPressed: () {
//             Navigator.push(
//               context,
//               MaterialPageRoute(builder: (context) => const ClientsView()),
//             );
//           },
//         ),
//       ),
//       body: Padding(
//         padding: const EdgeInsets.all(16.0),
//         child: Form(
//           key: _formKey,
//           child: SingleChildScrollView(
//             child: Column(
//               children: [
//                 Directionality(
//                   textDirection: TextDirection.rtl,
//                   child: TextFormField(
//                     controller: _clientNameCtr,
//                     decoration: const InputDecoration(
//                       hintText: 'اسم العميل',
//                       border: OutlineInputBorder(),
//                     ),
//                     validator: (value) {
//                       if (value!.isEmpty) {
//                         return 'من فضلك ادخل اسم العميل';
//                       }
//                       return null;
//                     },
//                   ),
//                 ),
//                 const SizedBox(height: 16.0),
//                 Directionality(
//                   textDirection: TextDirection.rtl,
//                   child: TextFormField(
//                     controller: _clientLocationCtr,
//                     keyboardType: TextInputType.text,
//                     decoration: const InputDecoration(
//                       hintText: 'موقع العميل',
//                       hintStyle: TextStyle(),
//                       hintTextDirection: TextDirection.rtl,
//                       border: OutlineInputBorder(),
//                     ),
//                     validator: (value) {
//                       if (value!.isEmpty) {
//                         return 'من فضلك ادخل موقع العميل';
//                       }
//                       return null;
//                     },
//                   ),
//                 ),
//                 const SizedBox(height: 16.0),
//                 Directionality(
//                   textDirection: TextDirection.rtl,
//                   child: TextFormField(
//                     controller: _phoneNumberCtr,
//                     keyboardType: TextInputType.number,
//                     decoration: const InputDecoration(
//                       hintText: 'رقم العميل',
//                       border: OutlineInputBorder(),
//                     ),
//                     validator: (value) {
//                       if (value!.isEmpty) {
//                         return 'من فضلك ادخل رقم العميل';
//                       }
//                       return null;
//                     },
//                   ),
//                 ),
//                 const SizedBox(height: 16.0),
//                 const SizedBox(height: 16.0),
//                 Directionality(
//                   textDirection: TextDirection.rtl,
//                   child: TextFormField(
//                     controller: _notesCtr,
//                     decoration: const InputDecoration(
//                       hintText: 'ملاحظات',
//                       border: OutlineInputBorder(),
//                     ),
//                     validator: (value) {
//                       if (value!.isEmpty) {
//                         return 'من فضلك ادخل ملاحظة';
//                       }
//                       return null;
//                     },
//                   ),
//                 ), //selection day
//                 const SizedBox(height: 16.0),
//                 SizedBox(
//                   width: double.infinity,
//                   child: ElevatedButton(
//                     onPressed: _isLoading ? null : _submitForm,
//                     child: _isLoading
//                         ? const CircularProgressIndicator() // Show loading indicator
//                         : Container(
//                             height: 50,
//                             child: const Center(
//                                 child: Text(
//                               'حفـــظ',
//                               style: TextStyle(fontWeight: FontWeight.bold),
//                             ))),
//                   ),
//                 ),
//                 const SizedBox(height: 16.0),
//                 Text(
//                   _resultMessage,
//                   style: TextStyle(
//                     color: _resultMessage == 'Failure!'
//                         ? Colors.red
//                         : Colors.green,
//                     fontWeight: FontWeight.bold,
//                   ),
//                 ),
//               ],
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }
import 'package:flutter/material.dart';
import '../../models/ClientModel.dart';
import '../../repository/clients_repository.dart';
import 'clients_views.dart';

class ClientsEditView extends StatefulWidget {
  ClientsEditView({Key? key, required this.Id}) : super(key: key);
  final int Id;

  @override
  _ClientsEditViewState createState() => _ClientsEditViewState(Id: Id);
}

class _ClientsEditViewState extends State<ClientsEditView> {
  _ClientsEditViewState({required this.Id});
  final int Id;
  bool _isLoading = false;
  String _resultMessage = '';
  ClientModel _client = ClientModel();
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _clientNameCtr = TextEditingController();
  final TextEditingController _clientLocationCtr = TextEditingController();
  final TextEditingController _phoneNumberCtr = TextEditingController();
  final TextEditingController _notesCtr = TextEditingController();
  final TextEditingController _debitMoneyCtr = TextEditingController();
  final TextEditingController _creditMoneyCtr = TextEditingController();
  final TextEditingController _dateOfRegisterCtr = TextEditingController();
  final TextEditingController _amountPaidCtr = TextEditingController();

  @override
  void initState() {
    super.initState();
    getData();
  }

  Future<void> getData() async {
    setState(() {
      _isLoading = true;
    });

    _client = (await ClientsRepository().getById(Id))!;
    _clientNameCtr.text = _client.clientName!;
    _clientLocationCtr.text = _client.clientLocation!;
    _phoneNumberCtr.text = _client.phoneNumber.toString();
    _notesCtr.text = _client.note!;
    _debitMoneyCtr.text = _client.debitMoney.toString();
    _creditMoneyCtr.text = _client.creditMoney.toString();
    _dateOfRegisterCtr.text = _client.dateOfRegister!;
    _amountPaidCtr.text = _client.amountPaid.toString();

    setState(() {
      _isLoading = false;
    });
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
          id: _client.id,
          clientName: clientName,
          clientLocation: clientLocation,
          phoneNumber: phoneNumber,
          note: notes,
          debitMoney: debitMoney,
          creditMoney: creditMoney,
          dateOfRegister: dateOfRegister,
          amountPaid: amountPaid,
        );

        bool success = await ClientsRepository().updateToDb(data);

        setState(() {
          _isLoading = false;
          _resultMessage = success ? 'تم التعديل بنجاح!' : 'فشل التعديل!';
        });

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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      appBar: AppBar(
        title: const Text('تعديل بيانات العميل'),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
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
                    hintText: 'له',
                    inputType: TextInputType.number),
                const SizedBox(height: 16.0),
                _buildTextField(
                    controller: _creditMoneyCtr,
                    hintText: 'عليه',
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
                    color: _resultMessage == 'فشل التعديل!'
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

  Future<DateTime?> _selectExpenseDate(BuildContext context) async {
    final DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(1900),
      lastDate: DateTime.now(),
    );
    if (pickedDate != null) {
      _dateOfRegisterCtr.text =
      pickedDate.toLocal().toString().split(' ')[0];
    }
    return pickedDate;
  }
}