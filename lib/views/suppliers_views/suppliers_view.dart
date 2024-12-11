import 'package:flutter/material.dart';
import 'package:smart_management/common/widget/custom_appbar.dart';
import 'package:smart_management/models/SupplierModel.dart';
import 'package:smart_management/repository/suppliers_repository.dart';
import 'package:smart_management/views/suppliers_views/supplier_detailes_view.dart';
import 'package:smart_management/views/suppliers_views/supplieres_edit_view.dart';
import 'package:smart_management/views/suppliers_views/suppliers_form_view.dart';

import 'delete_supplier.dart';
class SuppliersView extends StatefulWidget {
  const SuppliersView({Key? key}) : super(key: key);

  @override
  State<SuppliersView> createState() => _SuppliersViewState();
}

class _SuppliersViewState extends State<SuppliersView> {
  bool loading = false;
  @override
  Widget build(BuildContext ctx) {
    return Scaffold(
      appBar: customeAppBar(context, "الموردين "),
      body: loading
          ? const Center(child: CircularProgressIndicator())
          : Container(
              child: FutureBuilder<List<SupplierModel>>(
                future: SuppliersRepository().getAllFromDb(),
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
                      var list = snapshot.data ?? [];
                      return RefreshIndicator(
                          onRefresh: () async {
                            setState(() {});
                          },
                          child: ListView.separated(
                            itemBuilder: (context, index) {
                              return ListTile(
                                title: Text("${list[index].supplierName}"),
                                leading: Text("${index + 1}"),
                                onTap: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) =>
                                          SuppliersDetailesViews(
                                        Id: list[index].id ?? 0,
                                      ),
                                    ),
                                  );
                                }, // Update the index numbers
                                trailing: Row(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    IconButton(
                                      onPressed: () {
                                        Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                            builder: (context) =>
                                                SupplieresEditView(
                                              Id: list[index].id ?? 0,
                                            ),
                                          ),
                                        );
                                      },
                                      icon: Icon(Icons.edit),
                                    ),
                                    IconButton(
                                      onPressed: () async {
                                        var done = await showDialog(
                                            barrierDismissible: false,
                                            context: context,
                                            builder: (context) {
                                              return DeleteSupplier(
                                                testId: list[index].id ?? 0,
                                              );
                                            });
                                        if (done) {
                                          setState(() {});
                                        } else {}
                                      },
                                      icon: const Icon(Icons.delete),
                                    ),
                                  ],
                                ),
                              );
                            },
                            separatorBuilder: (context, index) {
                              return const Divider(color: Colors.black87);
                            },
                            itemCount: list.length,
                          ));
                    } else {
                      return const Center(
                        child: Text("No Data Found"),
                      );
                    }
                  } else {
                    return const Center(
                      child: Text("Error: unknown "),
                    );
                  }
                },
              ),
            ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.of(context).push(MaterialPageRoute(
            builder: (context) => SuppliersFormView(),
          ));
        },
        child: const Icon(
          Icons.add,
        ),
        backgroundColor: Colors.white,
      ),
    );
  }
}
