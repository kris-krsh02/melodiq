import 'package:flutter/material.dart';
import 'package:frontend/components/custom_app_bar.dart';

class MusicPlayerPage extends StatelessWidget {
  const MusicPlayerPage({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      appBar: CustomAppBar(),
      body: Center(
        child: Text('Music Player Content Here'),
      ),
    );
  }
}
