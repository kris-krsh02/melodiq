import 'package:flutter/material.dart';
import 'pages/home_page.dart';
import 'pages/login_page.dart';
import 'pages/music_player_page.dart';
import 'pages/music_library_page.dart';

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
        '/': (context) => const HomePage(),
        '/login': (context) => const LoginPage(),
        '/music_player': (context) => const MusicPlayerPage(),
        '/library': (context) => MusicLibraryPage(),
      },
    );
  }
}
