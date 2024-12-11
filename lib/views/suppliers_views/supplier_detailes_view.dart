import 'package:flutter/material.dart';
import 'package:smart_management/models/SupplierModel.dart';
import 'package:smart_management/repository/suppliers_repository.dart';
import 'package:smart_management/widget/custom_appbar.dart';
class SuppliersDetailesViews extends StatefulWidget {
  const SuppliersDetailesViews({Key? key, required this.Id}) : super(key: key);
  final int Id;
  @override
  State<SuppliersDetailesViews> createState() => _SuppliersDetailesViewsState();
}

class _SuppliersDetailesViewsState extends State<SuppliersDetailesViews> {
  Future<SupplierModel?> onPressed() async {
    var res = await SuppliersRepository().getById(widget.Id);
    return res;
  }

  bool loading = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: customeAppBar(context, ""),
      body: loading
          ? const Center(child: CircularProgressIndicator())
          : Container(
              child: FutureBuilder<SupplierModel?>(
                  future: onPressed(),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return const Center(
                        child: CircularProgressIndicator(),
                      );
                    } else if (snapshot.connectionState == ConnectionState.done) {
                      if (snapshot.hasError) {
                        return Center(
                          child: Text("Error: ${snapshot.error}"),
                        );
                      } else if (snapshot.hasData) {
                        var list = snapshot.data;
                        return RefreshIndicator(
                          onRefresh: () async {
                            setState(() {});
                          },
                          child: Column(
                            children: [
                              const SizedBox(
                                height: 20,
                              ),
                              Directionality(
                                textDirection: TextDirection.rtl,
                                child: Container(
                                  decoration: BoxDecoration(
                                    border: Border.all(
                                      color: Colors.grey,
                                      width: 1.0,
                                    ),
                                    borderRadius: BorderRadius.circular(8.0),
                                  ),
                                  child: Row(
                                    children: [
                                      Column(
                                        children: [
                                          Container(
                                              padding: const EdgeInsets.symmetric(horizontal: 3.0),
                                              child: const Text(
                                                'أسم الموراد',
                                                style: TextStyle(
                                                  fontWeight: FontWeight.bold,
                                                  fontSize: 15,
                                                ),
                                              )),
                                          const SizedBox(
                                            height: 15,
                                          ),
                                          Text("${list?.supplierName}",
                                              style: const TextStyle(
                                                fontWeight: FontWeight.bold,
                                                color: Colors.grey,
                                                fontSize: 17,
                                              )),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              const SizedBox(
                                height: 10,
                              ),
                              Directionality(
                                textDirection: TextDirection.rtl,
                                child: Container(
                                  decoration: BoxDecoration(
                                    border: Border.all(
                                      color: Colors.grey,
                                      width: 1.0,
                                    ),
                                    borderRadius: BorderRadius.circular(8.0),
                                  ),
                                  child: Row(
                                    children: [
                                      Column(
                                        children: [
                                          Container(
                                              padding: const EdgeInsets.symmetric(horizontal: 3.0),
                                              child: const Text(
                                                'عنوان الموارد',
                                                style: TextStyle(
                                                  fontWeight: FontWeight.bold,
                                                  fontSize: 15,
                                                ),
                                              )),
                                          const SizedBox(
                                            height: 15,
                                          ),
                                          Text("${list?.supplierLocation}",
                                              style: const TextStyle(
                                                fontWeight: FontWeight.bold,
                                                color: Colors.grey,
                                                fontSize: 17,
                                              )),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              const SizedBox(
                                height: 20,
                              ),
                              Directionality(
                                textDirection: TextDirection.rtl,
                                child: Container(
                                  decoration: BoxDecoration(
                                    border: Border.all(
                                      color: Colors.grey,
                                      width: 1.0,
                                    ),
                                    borderRadius: BorderRadius.circular(8.0),
                                  ),
                                  child: Row(
                                    children: [
                                      Column(
                                        children: [
                                          Container(
                                              padding: const EdgeInsets.symmetric(horizontal: 3.0),
                                              child: const Text(
                                                'رقم الهاتف',
                                                style: TextStyle(
                                                  fontWeight: FontWeight.bold,
                                                  fontSize: 15,
                                                ),
                                              )),
                                          const SizedBox(
                                            height: 15,
                                          ),
                                          Text("${list?.phoneNumber}",
                                              style: const TextStyle(
                                                fontWeight: FontWeight.bold,
                                                color: Colors.grey,
                                                fontSize: 17,
                                              )),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              const SizedBox(
                                height: 20,
                              ),
                              Directionality(
                                textDirection: TextDirection.rtl,
                                child: Container(
                                  height: 200,
                                  decoration: BoxDecoration(
                                    border: Border.all(
                                      color: Colors.grey,
                                      width: 1.0,
                                    ),
                                    borderRadius: BorderRadius.circular(8.0),
                                  ),
                                  child: Row(
                                    children: [
                                      Column(
                                        children: [
                                          Container(
                                              padding: const EdgeInsets.symmetric(horizontal: 3.0),
                                              child: const Text(
                                                'ملاحظة',
                                                style: TextStyle(
                                                  fontWeight: FontWeight.bold,
                                                  fontSize: 15,
                                                ),
                                              )),
                                          const SizedBox(
                                            height: 5,
                                          ),
                                          Text("${list?.note}",
                                              style: const TextStyle(
                                                fontWeight: FontWeight.bold,
                                                color: Colors.grey,
                                                fontSize: 17,
                                              )),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),
                        );
                      }
                    }
                    throw '';
                  }),
            ),
    );
  }
}
