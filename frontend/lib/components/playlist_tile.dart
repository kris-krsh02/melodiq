import 'package:flutter/material.dart';

class PlaylistTile extends StatelessWidget {
  final String playlistName;
  final VoidCallback onPlay;

  const PlaylistTile({
    super.key,
    required this.playlistName,
    required this.onPlay,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPlay,
      child: Container(
        margin: const EdgeInsets.symmetric(vertical: 10.0),
        padding: const EdgeInsets.symmetric(vertical: 20.0, horizontal: 20.0),
        decoration: BoxDecoration(
          color: Theme.of(context).colorScheme.tertiary, // Background color
          borderRadius: BorderRadius.circular(15.0), // Curved edges
        ),
        child: Row(
          children: [
            Icon(Icons.music_note, color: Theme.of(context).primaryColor),
            SizedBox(width: 10.0),
            Expanded(
              child: Text(
                playlistName,
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            Icon(Icons.arrow_forward_ios_rounded,
                color: Theme.of(context).primaryColor),
          ],
        ),
      ),
    );
  }
}
