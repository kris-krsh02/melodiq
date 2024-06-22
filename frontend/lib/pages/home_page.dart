import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Home Page'),
        automaticallyImplyLeading:
            false, // This will remove the back button if any.
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            ElevatedButton(
              onPressed: () {
                Navigator.pushNamed(context, '/music_player');
              },
              child: Text('Music Player Page'),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.pushNamed(context, '/library');
              },
              child: Text('Music Library Page'),
            ),
          ],
        ),
      ),
    );
  }
}
