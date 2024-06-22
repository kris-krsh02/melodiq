import 'package:flutter/material.dart';
import 'pages/login_page.dart';
import 'components/bottom_nav_bar.dart';

void main() {
  runApp(const Melodiq());
}

class Melodiq extends StatelessWidget {
  const Melodiq({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'melodIQ',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      initialRoute: '/login',
      routes: {
        '/': (context) => const BottomNavBar(),
        '/login': (context) => const LoginPage(),
      },
    );
  }
}
