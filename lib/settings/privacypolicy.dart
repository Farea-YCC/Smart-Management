import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:awesome_dialog/awesome_dialog.dart';
import '../views/home_views/home_views.dart';

class PrivacyPolicy extends StatefulWidget {
  const PrivacyPolicy({Key? key}) : super(key: key);

  @override
  State<PrivacyPolicy> createState() => _PrivacyPolicyState();
}

class _PrivacyPolicyState extends State<PrivacyPolicy> {
  late SharedPreferences _preferences;
  bool _isChecked = false;

  @override
  void initState() {
    super.initState();
    _loadConsentStatus();
  }

  Future<void> _loadConsentStatus() async {
    _preferences = await SharedPreferences.getInstance();
    setState(() {
      _isChecked = _preferences.getBool('consentStatus') ?? false;
    });
  }

  Future<void> _saveConsentStatus(bool value) async {
    setState(() {
      _isChecked = value;
    });
    await _preferences.setBool('consentStatus', value);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'سياسة الخصوصية',
          style: TextStyle(fontWeight: FontWeight.bold, fontFamily: 'CustomFont'),
        ),
        centerTitle: true,
      ),
      body: Center(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              children: [
                const SizedBox(height: 16.0),
                const Text(
                  'سياسة الخصوصية مهمة لحماية معلوماتكم',
                  style: TextStyle(fontSize: 18.0, fontFamily: 'CustomFont'),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 32.0),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Switch(
                      value: _isChecked,
                      onChanged: (bool value) {
                        _saveConsentStatus(value);
                      },
                    ),
                    const Text(
                      'الرجاء الموافقة على سياسة الخصوصية',
                      style: TextStyle(fontFamily: 'CustomFont'),
                    ),
                  ],
                ),
                const SizedBox(height: 32.0),
                SizedBox(
                  width: 200,
                  height: 50,
                  child: ElevatedButton(
                    onPressed: () {
                      if (_isChecked) {
                        AwesomeDialog(
                          context: context,
                          dialogType: DialogType.infoReverse,
                          headerAnimationLoop: false,
                          btnOkColor: Colors.blue,
                          animType: AnimType.bottomSlide,
                          title: 'تأكيد الموافقة',
                          desc: 'هل أنت متأكد من قبول سياسة الخصوصية؟',
                          btnCancelOnPress: () {},
                          btnOkOnPress: () {
                            Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(builder: (context) => const HomePage()),
                            );
                          },
                        ).show();
                      } else {
                        AwesomeDialog(
                          context: context,
                          dialogType: DialogType.warning,
                          headerAnimationLoop: false,
                          animType: AnimType.bottomSlide,
                          btnOkColor: Colors.blue,
                          title: 'تحذير',
                          desc: 'يجب الموافقة على سياسة الخصوصية',
                          btnOkOnPress: () {},
                          btnOkText: 'موافق',
                        ).show();
                      }
                    },
                    child: const Text(
                      'استمر',
                      style: TextStyle(fontFamily: 'CustomFont', fontWeight: FontWeight.bold),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
