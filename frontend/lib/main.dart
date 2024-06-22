import 'package:flutter/material.dart';
import 'pages/login_page.dart';
import 'components/bottom_nav_bar.dart';
import 'package:google_fonts/google_fonts.dart';

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
        fontFamily: GoogleFonts.jura().fontFamily,
        // Set the default background color
        scaffoldBackgroundColor: backgroundColor,
        textTheme: TextTheme(
          // ignore: deprecated_member_use
          bodyLarge: TextStyle(color: fontColor),
          bodyMedium: TextStyle(color: fontColor),
        ),
        // Define the default font color
        // Define the default button theme
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            backgroundColor: buttonColor, // Background color of the button
            foregroundColor: fontColor,
            // Text color of the button
          ),
          // Define the default text theme
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
