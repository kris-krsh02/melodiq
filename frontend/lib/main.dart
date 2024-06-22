import 'package:flutter/material.dart';
import 'pages/login_page.dart';
import 'components/bottom_nav_bar.dart';

void main() {
  runApp(MyMusicApp());
}

class MyMusicApp extends StatelessWidget {
  // Define your custom colors
  final Color backgroundColor = const Color(0xFFDBC5AB);
  final Color fontColor = const Color(0xFF583E23);
  final Color buttonColor = const Color(0xFFFFF0E0);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'My Music App',
      theme: ThemeData(
        // Set the default background color
        scaffoldBackgroundColor: backgroundColor,
        // Define the default font color
        // Define the default button theme
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            backgroundColor: buttonColor, // Background color of the button
            foregroundColor: Colors.white,
            // Text color of the button
          ),
        ),
        appBarTheme: AppBarTheme(
          backgroundColor: backgroundColor, // AppBar background color
        ),
      ),
      initialRoute: '/login',
      routes: {
        '/': (context) => const BottomNavBar(),
        '/login': (context) => const LoginPage(),
      },
    );
  }
}
