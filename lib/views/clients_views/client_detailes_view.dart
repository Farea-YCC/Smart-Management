// // ignore_for_file: non_constant_identifier_names, prefer_const_constructors_in_immutables
//
// import 'package:flutter/material.dart';
// import '../../models/ClientModel.dart';
// import '../../repository/clients_repository.dart';
// import 'clients_add.dart';
// import 'clients_views.dart';
//
// class ClientsDetailesViews extends StatefulWidget {
//   ClientsDetailesViews({Key? key, required this.Id}) : super(key: key);
//   final int Id;
//   @override
//   State<ClientsDetailesViews> createState() => _ClientsDetailesViewsState();
// }
//
// class _ClientsDetailesViewsState extends State<ClientsDetailesViews> {
//   Future<ClientModel?> fetchClientDetails() async {
//     var res = await ClientsRepository().getById(widget.Id);
//     return res;
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     // Get screen size and orientation for responsiveness
//     var screenSize = MediaQuery.of(context).size;
//     var orientation = MediaQuery.of(context).orientation;
//
//     return Directionality(
//       textDirection: TextDirection.rtl,
//       child: Scaffold(
//         appBar: AppBar(
//           leading: IconButton(
//             icon: const Icon(Icons.arrow_back_ios),
//             onPressed: () {
//               Navigator.push(
//                 context,
//                 MaterialPageRoute(builder: (context) => const ClientsView()),
//               );
//             },
//           ),
//           actions: [
//             IconButton(
//               icon: const Icon(
//                 Icons.add,
//                 size: 35,
//               ),
//               onPressed: () {
//                 Navigator.push(
//                   context,
//                   MaterialPageRoute(builder: (context) => const ClientsAdd()),
//                 );
//               },
//             ),
//           ],
//           title: const Text("بيانات العملاء "),
//           centerTitle: true,
//         ),
//         body: FutureBuilder<ClientModel?>(
//           future: fetchClientDetails(),
//           builder: (context, snapshot) {
//             if (snapshot.connectionState == ConnectionState.waiting) {
//               return const Center(child: CircularProgressIndicator());
//             } else if (snapshot.hasError) {
//               return Center(child: Text("Error: ${snapshot.error}"));
//             } else if (snapshot.hasData) {
//               var client = snapshot.data;
//               return Directionality(
//                 textDirection: TextDirection.rtl, // RTL direction
//                 child: SingleChildScrollView(
//                   child: Padding(
//                     padding: const EdgeInsets.all(16.0),
//                     child: Column(
//                       children: [
//                         _buildDetailCard(
//                           screenSize: screenSize,
//                           orientation: orientation,
//                           title: 'اسم العميل',
//                           content: client?.clientName ?? 'غير متوفر',
//                         ),
//                         const SizedBox(height: 15),
//                         _buildDetailCard(
//                           screenSize: screenSize,
//                           orientation: orientation,
//                           title: 'عنوان العميل',
//                           content: client?.clientLocation ?? 'غير متوفر',
//                         ),
//                         const SizedBox(height: 15),
//                         _buildDetailCard(
//                           screenSize: screenSize,
//                           orientation: orientation,
//                           title: 'رقم الهاتف',
//                           content:
//                               client?.phoneNumber?.toString() ?? 'غير متوفر',
//                         ),
//
//
//
//                         _buildDetailCard(
//                           screenSize: screenSize,
//                           orientation: orientation,
//                           title: 'له',
//                           content:
//                           client?.creditMoney?.toString() ?? 'غير متوفر',
//                         ),
//                         _buildDetailCard(
//                           screenSize: screenSize,
//                           orientation: orientation,
//                           title: 'عليه',
//                           content:
//                           client?.debitMoney?.toString() ?? 'غير متوفر',
//                         ),
//                         _buildDetailCard(
//                           screenSize: screenSize,
//                           orientation: orientation,
//                           title: 'رقم الهاتف',
//                           content:
//                           client?.amountPaid?.toString() ?? 'غير متوفر',
//                         ),
//                         _buildDetailCard(
//                           screenSize: screenSize,
//                           orientation: orientation,
//                           title: 'تاريخ التسجيل',
//                           content:
//                           client?.dateOfRegister?.toString() ?? 'غير متوفر',
//                         ),
//
//
//
//
//
//
//
//
//                         const SizedBox(height: 15),
//                         _buildDetailCard(
//                           screenSize: screenSize,
//                           orientation: orientation,
//                           title: 'ملاحظة',
//                           content: client?.note ?? 'غير متوفر',
//                           isLarge: true,
//                         ),
//                       ],
//                     ),
//                   ),
//                 ),
//               );
//             }
//             return const Center(child: Text("لا يوجد بيانات"));
//           },
//         ),
//       ),
//     );
//   }
//
//   Widget _buildDetailCard({
//     required Size screenSize,
//     required Orientation orientation,
//     required String title,
//     required String content,
//     bool isLarge = false,
//   }) {
//     double cardHeight = 120; // Static height for the card
//     double cardWidth = orientation == Orientation.portrait
//         ? screenSize.width * 0.9 // 90% of screen width in portrait
//         : screenSize.width * 0.6; // 60% of screen width in landscape
//
//     return Card(
//       elevation: 2,
//       shape: RoundedRectangleBorder(
//         borderRadius: BorderRadius.circular(10),
//       ),
//       child: Container(
//         height: cardHeight, // Static height
//         width: cardWidth, // Static width
//         padding: const EdgeInsets.all(16.0),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             Text(
//               title,
//               style: const TextStyle(
//                 fontWeight: FontWeight.bold,
//                 fontSize: 16,
//               ),
//             ),
//             const SizedBox(height: 10),
//             Expanded(
//               child: SingleChildScrollView(
//                 child: Text(
//                   content,
//                   style: const TextStyle(
//                     fontSize: 16,
//                     color: Colors.grey,
//                   ),
//                   maxLines: isLarge ? null : 10,
//                   overflow:
//                       isLarge ? TextOverflow.visible : TextOverflow.ellipsis,
//                 ),
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }

// ignore_for_file: non_constant_identifier_names, prefer_const_constructors_in_immutables

// ignore_for_file: non_constant_identifier_names, prefer_const_constructors_in_immutables

import 'package:flutter/material.dart';
import '../../models/ClientModel.dart';
import '../../repository/clients_repository.dart';
import 'clients_add.dart';
import 'clients_views.dart';

class ClientsDetailesViews extends StatefulWidget {
  const ClientsDetailesViews({Key? key, required this.Id}) : super(key: key);
  final int Id;

  @override
  State<ClientsDetailesViews> createState() => _ClientsDetailesViewsState();
}

class _ClientsDetailesViewsState extends State<ClientsDetailesViews> {
  Future<ClientModel?> fetchClientDetails() async {
    return await ClientsRepository().getById(widget.Id);
  }

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        appBar: AppBar(
          leading: IconButton(
            icon: const Icon(Icons.arrow_back_ios,size: 28,),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const ClientsView()),
              );
            },
          ),
          actions: [
            IconButton(
              icon: const Icon(Icons.add_comment,size: 28,),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const ClientsAdd()),
                );
              },
            ),
          ],
          title: const Text("بيانات العملاء"),
          centerTitle: true,
        ),
        body: FutureBuilder<ClientModel?>(
          future: fetchClientDetails(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: CircularProgressIndicator());
            } else if (snapshot.hasError) {
              return Center(child: Text("خطأ: ${snapshot.error}"));
            } else if (snapshot.hasData) {
              var client = snapshot.data;
              return Card(
                margin: const EdgeInsets.symmetric(horizontal: 25,),
                child: SingleChildScrollView(
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: DataTable(
                      columns: const [
                        DataColumn(label: Text('البند')),
                        DataColumn(label: Text('القيمة')),
                      ],
                      rows: [
                        DataRow(cells: [
                          const DataCell(Text('اسم العميل')),
                          DataCell(Text(client?.clientName ?? 'غير متوفر')),
                        ]),
                        DataRow(cells: [
                          const DataCell(Text('عنوان العميل')),
                          DataCell(Text(client?.clientLocation ?? 'غير متوفر')),
                        ]),
                        DataRow(cells: [
                          const DataCell(Text('رقم الهاتف')),
                          DataCell(Text(client?.phoneNumber?.toString() ?? 'غير متوفر')),
                        ]),
                        DataRow(cells: [
                          const DataCell(Text('له')),
                          DataCell(Text(client?.creditMoney?.toString() ?? 'غير متوفر')),
                        ]),
                        DataRow(cells: [
                          const DataCell(Text('عليه')),
                          DataCell(Text(client?.debitMoney?.toString() ?? 'غير متوفر')),
                        ]),
                        DataRow(cells: [
                          const DataCell(Text('المبلغ المدفوع')),
                          DataCell(Text(client?.amountPaid?.toString() ?? 'غير متوفر')),
                        ]),
                        DataRow(cells: [
                          const DataCell(Text('تاريخ التسجيل')),
                          DataCell(Text(client?.dateOfRegister ?? 'غير متوفر')),
                        ]),
                        DataRow(cells: [
                          const DataCell(Text('ملاحظة')),
                          DataCell(Text(client?.note ?? 'غير متوفر')),
                        ]),
                      ],
                    ),
                  ),
                ),
              );
            }
            return const Center(child: Text("لا يوجد بيانات"));
          },
        ),
      ),
    );
  }
}

Widget _buildDetailCard({
  required Size screenSize,
  required String title,
  required String content,
  bool isLarge = false,
}) {
  return Card(
    elevation: 2,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(10),
    ),
    child: Container(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: const TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 16,
            ),
          ),
          const SizedBox(height: 10),
          Text(
            content,
            style: const TextStyle(
              fontSize: 16,
              color: Colors.grey,
            ),
            maxLines: isLarge ? null : 10,
            overflow: isLarge ? TextOverflow.visible : TextOverflow.ellipsis,
          ),
        ],
      ),
    ),
  );
}
