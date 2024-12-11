import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:smart_management/common/theme/mode_theme.dart';
import 'custome_alertdialog.dart';
AppBar customeAppBar(BuildContext context, String title) {
  final themeProvider = Provider.of<ThemeProvider>(context);
  return AppBar(
    title: Text(title),
    centerTitle: true,
    leading: IconButton(
      icon: const Icon(Icons.menu, size: 30),
      onPressed: () {
        showDialog(context: context, builder: (BuildContext context) {
            return const CustomeAlertDalog();
          },
        );
      },
    ),
    actions: [
      IconButton(
        icon: Icon(themeProvider.isDarkMode ? Icons.dark_mode : Icons.light_mode),
        onPressed: () {
          themeProvider.toggleTheme();
        },
      ),
    ],

  );
}
