import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';
import 'package:provider/provider.dart';
import 'package:smart_management/splash/splash.dart';
import 'package:smart_management/theme/mode_theme.dart';
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await GetStorage.init();
  runApp(const SmartManagement());
}
class SmartManagement extends StatefulWidget {
  const SmartManagement({super.key});
  @override
  State<SmartManagement> createState() => _SmartManagementState();
}
class _SmartManagementState extends State<SmartManagement> {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => ThemeProvider(),
      child: Consumer<ThemeProvider>(
        builder: (context, themeProvider, child) {
          return MaterialApp(
            debugShowCheckedModeBanner: false,
            themeMode: themeProvider.themeMode,
            theme: ThemeData.light(),
            darkTheme: ThemeData.dark(),
            home: const SplashScreen(),
          );
        },
      ),
    );
  }
}