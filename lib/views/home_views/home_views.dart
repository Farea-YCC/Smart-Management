import 'package:flutter/material.dart';
import 'package:smart_management/widget/custom_appbar.dart';
import '../clients_views/clients_views.dart';
import '../expenses_views/expenses_views.dart';
import '../productes_views/productes_view.dart';
import '../purchases_views/purchases_view.dart';
import '../sales_views/sales_view.dart';
import '../suppliers_views/suppliers_view.dart';
class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);
  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: customeAppBar(context, "الإدارة الذكية "),
      body: Container(
        padding: const EdgeInsets.all(10.0),
        child: GridView.count(
          childAspectRatio: 0.8,
          crossAxisCount: 2,
          children: [
            _buildGridItem(
              context,
              imagePath: 'images/6.png',
              label: 'العملاء',
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const ClientsView(),
                  ),
                );
              },
            ),
            _buildGridItem(
              context,
              imagePath: 'images/2.png',
              label: 'المشتريات',
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const PurchasesView(),
                  ),
                );
              },
            ),
            _buildGridItem(
              context,
              imagePath: 'images/1.png',
              label: 'المخزون',
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const ProductesView(),
                  ),
                );
              },
            ),

            _buildGridItem(
              context,
              imagePath: 'images/5.png',
              label: 'المورديــن',
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const SuppliersView(),
                  ),
                );
              },
            ),
            _buildGridItem(
              context,
              imagePath: 'images/4.png',
              label: 'المبيعات',
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const SalesView(),
                  ),
                );
              },
            ),
            _buildGridItem(
              context,
              imagePath: 'images/3.png',
              label: 'المصروفات',
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const ExpensesView(),
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildGridItem(BuildContext context, {required String imagePath, required String label, required VoidCallback onTap}) {
    return GestureDetector(
      onTap: onTap,
      child: Column(
        children: [
          Container(
            height: MediaQuery.of(context).size.height * 0.2,
            margin: const EdgeInsets.all(12.0),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(16),
              child: Image.asset(
                imagePath,
                fit: BoxFit.cover,
                width: double.infinity,
                height: double.infinity,
              ),
            ),
          ),
          Text(
            label,
            style: const TextStyle(fontWeight: FontWeight.bold),
          ),
        ],
      ),
    );
  }
}
