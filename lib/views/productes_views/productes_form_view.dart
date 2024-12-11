import 'package:flutter/material.dart';
import '../../models/ProducteModel.dart';
import '../../repository/productes_repository.dart';
import 'productes_view.dart';

class ProductesFormView extends StatefulWidget {
  @override
  _ProductesFormViewState createState() => _ProductesFormViewState();
}

class _ProductesFormViewState extends State<ProductesFormView> {
  bool _isLoading = false;
  String _resultMessage = '';

  final _formKey = GlobalKey<FormState>();
  final TextEditingController _productNameCtr = TextEditingController();
  final TextEditingController _quantityCtr = TextEditingController();
  final TextEditingController _purchasePriceCtr = TextEditingController();
  final TextEditingController _salePriceCtr = TextEditingController();
  final TextEditingController _descriptionCtr = TextEditingController();

  Future<void> _submitForm() async {
    if (_formKey.currentState!.validate()) {
      setState(() {
        _isLoading = true;
      });

      String productName = _productNameCtr.text;
      int quantity = int.parse(_quantityCtr.text);
      int purchasePrice = int.parse(_purchasePriceCtr.text);
      int salePrice = int.parse(_salePriceCtr.text);
      String description = _descriptionCtr.text;

      ProducteModel data = ProducteModel();
      data.productName = productName;
      data.quantity = quantity;
      data.purchasePrice = purchasePrice;
      data.salePrice = salePrice;
      data.description = description;

      bool success = await ProductesRepository().addToDb(data);

      setState(() {
        _isLoading = false;
        _resultMessage = success ? 'تم الإضافة بنجاح!' : 'فشل!';
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
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => ProductesView()),
            );
          },
        ),
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
                    controller: _purchasePriceCtr,
                    hintText: 'سعر الشراء',
                    inputType: TextInputType.number,
                  ),
                ),
                const SizedBox(height: 16.0),
                Directionality(
                  textDirection: TextDirection.rtl,
                  child: _buildTextField(
                    controller: _salePriceCtr,
                    hintText: 'سعر البيع',
                    inputType: TextInputType.number,
                  ),
                ),
                const SizedBox(height: 16.0),
                Directionality(
                  textDirection: TextDirection.rtl,
                  child: _buildTextField(
                    controller: _descriptionCtr,
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
