import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import 'package:smart_management/common/widget/custom_navigation_bar.dart';
import 'package:smart_management/models/ClientModel.dart';
import 'package:smart_management/repository/clients_repository.dart';
import 'package:smart_management/views/clients_views/client_detailes_view.dart';
import 'package:smart_management/views/clients_views/clients_add.dart';
import 'package:smart_management/views/clients_views/clients_edit_view.dart';
class ClientsView extends StatefulWidget {
  const ClientsView({Key? key}) : super(key: key);

  @override
  State<ClientsView> createState() => _ClientsViewState();
}

class _ClientsViewState extends State<ClientsView> {
  bool loading = false;
  late Future<List<ClientModel>> _clientsFuture;

  @override
  void initState() {
    super.initState();
    _refreshData();
  }

  Future<void> _refreshData() async {
    setState(() {
      loading = true;
    });
    _clientsFuture = ClientsRepository().getAllFromDb();
    await _clientsFuture;
    setState(() {
      loading = false;
    });
  }

  Future<void> _navigateToAddClient() async {
    bool? result = await Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const ClientsAdd()),
    );

    if (result == true) {
      _refreshData();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        appBar: AppBar(
          leading: IconButton(
            icon: const Icon(
              Icons.arrow_back_ios,
              size: 28,
            ),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const CustomNavigationBar()),
              );
            },
          ),
          title: const Text('العملاء'),
          centerTitle: true,
          actions: [
            IconButton(
              icon: const Icon(
                Icons.add_comment,
                size: 28,
              ),
              onPressed: _navigateToAddClient,
            ),
          ],
        ),
        body: loading
            ? const Center(child: CircularProgressIndicator())
            : FutureBuilder<List<ClientModel>>(
          future: _clientsFuture,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: CircularProgressIndicator());
            } else if (snapshot.hasError) {
              return Center(child: Text("Error: ${snapshot.error}"));
            } else if (snapshot.hasData) {
              var clients = snapshot.data ?? [];
              return RefreshIndicator(
                onRefresh: _refreshData,
                child: ListView.separated(
                  shrinkWrap: true,
                  separatorBuilder: (context, index) =>
                  const Divider(color: Colors.black87, height: 1),
                  itemCount: clients.length,
                  itemBuilder: (context, index) {
                    var client = clients[index];
                    return ListTile(
                      title: Align(
                        alignment: Alignment.centerRight,
                        child: Text(client.clientName ?? ''),
                      ),
                      leading: Text("${index + 1}"),
                      trailing: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          IconButton(
                            onPressed: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => ClientsEditView(
                                    Id: client.id ?? 0,
                                  ),
                                ),
                              );
                            },
                            icon: const Icon(
                              Icons.edit,
                              color: Colors.blue,
                              size: 30,
                            ),
                          ),
                          IconButton(
                            onPressed: () async {
                              AwesomeDialog(
                                context: context,
                                padding: const EdgeInsets.all(10),
                                dialogType: DialogType.error,
                                animType: AnimType.scale,
                                desc: 'هل أنت متأكد من الحذف؟',
                                btnOkText: 'نعم',
                                btnOkColor: Colors.blue,
                                btnCancelText: 'لا',
                                btnCancelColor: Colors.red,
                                btnOkOnPress: () async {
                                  var success = await ClientsRepository()
                                      .deleteFromDb(client.id ?? 0);
                                  if (success) {
                                    AwesomeDialog(
                                      context: context,
                                      dialogType: DialogType.success,
                                      btnOkColor: Colors.blue,
                                      title: 'نجــاح',
                                      desc: 'نجحت العملية!',
                                      autoHide: const Duration(seconds: 2),
                                      btnOkOnPress: _refreshData,
                                      customHeader: const Icon(
                                        Icons.check_circle,
                                        color: Colors.blue,
                                        size: 60,
                                      ),
                                    ).show();
                                  } else {
                                    AwesomeDialog(
                                      context: context,
                                      dialogType: DialogType.error,
                                      title: 'خطأ',
                                      desc: 'فشلت العملية!',
                                      btnOkOnPress: () {},
                                    ).show();
                                  }
                                },
                                btnCancelOnPress: () {},
                                title: "حذف",
                              ).show();
                            },
                            icon: const Icon(
                              Icons.delete,
                              color: Colors.red,
                              size: 30,
                            ),
                          )
                        ],
                      ),
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => ClientsDetailesViews(
                              Id: client.id ?? 0,
                            ),
                          ),
                        );
                      },
                    );
                  },
                ),
              );
            } else {
              return const Center(child: Text("No Data Found"));
            }
          },
        ),
      ),
    );
  }
}
