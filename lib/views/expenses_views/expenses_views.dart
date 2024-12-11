import 'package:flutter/material.dart'; //
import 'package:smart_management/widget/custom_appbar.dart';
import '../../models/ExpensesModel.dart';
import '../../repository/expenses_repository.dart';
import 'delete_expenses.dart';
import 'expenses_detailes_view.dart';
import 'expenses_form_views.dart';
import 'expenses_edit_view.dart';

class ExpensesView extends StatefulWidget {
  //
  const ExpensesView({Key? key}) : super(key: key); //

  @override
  State<ExpensesView> createState() => _ExpensesViewState(); //
}

class _ExpensesViewState extends State<ExpensesView> {
  //
  bool loading = false;
  @override
  Widget build(BuildContext ctx) {
    return Scaffold(
      appBar: customeAppBar(context, " "),
      body: loading
          ? const Center(child: CircularProgressIndicator())
          : Container(
              child: FutureBuilder<List<ExpensesModel>>(
                //
                future: ExpensesRepository().getAllFromDb(), //
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
                                title: Text(
                                    "${list[index].exchangeDestination}"), //
                                leading: Text("${index + 1}"),
                                onTap: () {
                                  ///
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) =>
                                          ExepensesDetailesView(
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
                                                ExpensesEditView(
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
                                              return DeleteExpenses(
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
          Navigator.of(context).push(MaterialPageRoute(
            builder: (context) => ExpensesFormView(),
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
