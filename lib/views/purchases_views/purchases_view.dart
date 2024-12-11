import 'package:flutter/material.dart'; //
import 'package:smart_management/common/widget/custom_appbar.dart';
import 'package:smart_management/models/PurchaseModel.dart';
import 'package:smart_management/repository/purchases_repository.dart';
import 'package:smart_management/views/purchases_views/purchase_detailes_view.dart';
import 'package:smart_management/views/purchases_views/purchases_edit_view.dart';
import 'package:smart_management/views/purchases_views/purchases_form_view.dart';

import 'delete_purchases.dart';
class PurchasesView extends StatefulWidget {
  //
  const PurchasesView({Key? key}) : super(key: key); //

  @override
  State<PurchasesView> createState() => _PurchasesViewState(); //
}

class _PurchasesViewState extends State<PurchasesView> {
  //
  bool loading = false;
  @override
  Widget build(BuildContext ctx) {
    return Scaffold(
      appBar: customeAppBar(context, "  "),
      body: loading
          ? const Center(child: CircularProgressIndicator())
          : Container(
              child: FutureBuilder<List<PurchaseModel>>(
                future: PurchasesRepository().getAllFromDb(), //
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
                                title: Text("${list[index].productName}"),
                                leading: Text("${index + 1}"),
                                onTap: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) =>
                                          PurchasesDetailesView(
                                        Id: list[index].id ?? 0,
                                      ),
                                    ),
                                  );
                                },
                                trailing: Row(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    IconButton(
                                      onPressed: () {
                                        Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                            builder: (context) =>
                                                PurchasesEditView(
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
                                              return DeletePurchases(
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
                              return const Divider(
                                color: Colors.black87,
                              );
                            },
                            itemCount: list.length),
                      );
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
          Navigator.of(context).push(MaterialPageRoute(builder: (context) => PurchasesFormView(),
          )); //
        },
        child: const Icon(
          Icons.add,
        ),
        backgroundColor: Colors.white,
      ),
    );
  }
}
