import 'package:contactus/contactus.dart';
import 'package:flutter/material.dart';

class AboutUsPage extends StatefulWidget {
  const AboutUsPage({super.key});

  @override
  State<AboutUsPage> createState() => _AboutUsPageState();
}

class _AboutUsPageState extends State<AboutUsPage> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
          title: Text('من نحن', ),centerTitle: true,
        ),
        body: Directionality(
          textDirection: TextDirection.rtl,
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ContactUs(
                  logo: const AssetImage('images/my_photo_faraa .png'),
                  email: 'faraa717281413.@gmail.com',
                  companyName: 'فــارع الضلاع',
                  phoneNumber: '+967717281413',
                  website: 'https://wa.me/+967717281413',
                  githubUserName: 'FaraaAl-Delaa717281413',
                  linkedinURL: 'https://www.linkedin.com/in/abhishek-doshi-520983199/',
                  twitterHandle: 'Faraa AlDela',
                  companyColor: Colors.black,
                  textColor: Colors.black,
                  cardColor: Colors.white,
                  taglineColor: Colors.black,
                ),
                const Padding(
                  padding: EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'عن شركتنا',
                        style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                        ),
                        textAlign: TextAlign.right,
                      ),
                      SizedBox(height: 10),
                      Text(
                        'نحن شركة رائدة في الصناعة ملتزمة بتقديم أفضل الخدمات والمنتجات لعملائنا. مهمتنا هي الابتكار والريادة في مجالنا.',
                        style: TextStyle(
                          fontSize: 16,
                          color: Colors.black,
                        ),
                        textAlign: TextAlign.right,
                      ),
                      SizedBox(height: 20),
                      Text(
                        'رؤيتنا',
                        style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                        ),
                        textAlign: TextAlign.right,
                      ),
                      SizedBox(height: 10),
                      Text(
                        'أن نكون الشركة الأكثر احترامًا ونجاحًا في صناعتنا، معروفة بتفانينا في رضا العملاء ونهجنا الابتكاري.',
                        style: TextStyle(
                          fontSize: 16,
                          color: Colors.black,
                        ),
                        textAlign: TextAlign.right,
                      ),
                    ],
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
