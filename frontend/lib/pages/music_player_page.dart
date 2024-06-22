import 'package:flutter/material.dart';

class MusicPlayerPage extends StatelessWidget {
  const MusicPlayerPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Music Player Page'),
      ),
      body: const Center(
        child: Text('Music Player Content Here'),
      ),
    );
  }
}
