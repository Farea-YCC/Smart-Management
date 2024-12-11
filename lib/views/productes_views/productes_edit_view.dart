import 'package:flutter/material.dart';

import '../../models/ProducteModel.dart';
import '../../repository/productes_repository.dart';
class ProductesEditView extends StatefulWidget {
  ProductesEditView({Key? key, required this.Id}) : super(key: key);
  final int Id;
  @override
  _ProductesEditViewState createState() => _ProductesEditViewState(Id: Id);
}

class _ProductesEditViewState extends State<ProductesEditView> {
  _ProductesEditViewState({required this.Id});

  final int Id;
  bool _isLoading = false;
  String _resultMessage = '';
  ProducteModel _list = new ProducteModel();
  int idedite = 0;

  final _formKey = GlobalKey<FormState>();
  TextEditingController _productNameCtr = TextEditingController(); //
  TextEditingController _quantityCtr = TextEditingController();
  TextEditingController _purchasePriceCtr = TextEditingController();
  TextEditingController _salePriceCtr = TextEditingController();
  TextEditingController _descriptionCtr = TextEditingController();

  void initState() {
    super.initState();
    getData();
  }

  Future<void> getData() async {
    _isLoading = true;
    _list = (await ProductesRepository().getById(this.Id))!;
    idedite = int.parse(_list.id.toString());
    _productNameCtr.text = _list.productName.toString();
    _quantityCtr.text = _list.quantity.toString();
    _purchasePriceCtr.text = _list.purchasePrice.toString();
    _salePriceCtr.text = _list.salePrice.toString();
    _descriptionCtr.text = _list.description.toString();
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
      int salePrice = int.parse(_salePriceCtr.text);
      String description = _descriptionCtr.text;

      ProducteModel data = ProducteModel(); //
      data.productName = productName; //
      data.quantity = quantity;
      data.purchasePrice = purchasePrice;
      data.salePrice = salePrice;
      data.description = description;

      bool success = await ProductesRepository().addToDb(data); //

      setState(() {
        _isLoading = false;
        _resultMessage = success ? 'Successfully added!' : 'Failure!';
      });

      _productNameCtr.clear();
      _quantityCtr.clear();
      _purchasePriceCtr.clear();
      _salePriceCtr.clear();
      _descriptionCtr.clear();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      appBar: AppBar(
        title: const Text('المخزون'),
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
                        return 'من فضلك ادخل الكمية';
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
                        return 'من فضلك ادخل سعر الشراء';
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
                    decoration: const InputDecoration(
                      hintText: 'سعر البيع',
                      border: OutlineInputBorder(),
                    ),
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'من فضلك ادخل سعر البيع';
                      }
                      return null;
                    },
                  ),
                ),
                const SizedBox(height: 16.0),
                Directionality(
                  textDirection: TextDirection.rtl,
                  child: TextFormField(
                    controller: _descriptionCtr,
                    decoration: const InputDecoration(
                      hintText: 'ملاحظــــة',
                      border: OutlineInputBorder(),
                    ),
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'من فضلك ادخل ملاحظة';
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
          ), //
        ),
      ),
    );
  }
}
