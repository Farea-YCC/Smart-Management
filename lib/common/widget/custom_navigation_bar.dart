import 'package:flutter/material.dart';
import 'package:smart_management/common/settings/about.dart';
import 'package:smart_management/views/home_views/home_views.dart';

import 'constants.dart';
class CustomNavigationBar extends StatefulWidget {
  const CustomNavigationBar({super.key});
  @override
  State<CustomNavigationBar> createState() => _CustomNavigationBarState();
}

class _CustomNavigationBarState extends State<CustomNavigationBar> {
  int _selectedIndex = 0;
  static const List<Widget> _widgetOptions = <Widget>[
    HomePage(),
    AboutUsPage(),
  ];
  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: _widgetOptions.elementAt(_selectedIndex),
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'الرئيسية',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'عنا',
          ),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: kprimaryColor,
        onTap: _onItemTapped,
      ),
    );
  }
}
