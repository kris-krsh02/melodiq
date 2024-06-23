import 'package:flutter/material.dart';
import 'package:frontend/components/custom_app_bar.dart';
import 'package:frontend/components/playlist_tile.dart';

class MusicLibraryPage extends StatelessWidget {
  const MusicLibraryPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(),
      body: Padding(
        padding: EdgeInsets.all(26.0), // Adjust the padding as needed
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Library',
              style: TextStyle(fontSize: 30),
            ),
            SizedBox(height: 8), // Add some spacing between the texts
            Text(
              'Return to one of your previously listened to playlists.',
              style: TextStyle(fontSize: 16),
            ),
            SizedBox(height: 16), // Add some spacing before the scroll view
            Expanded(
              child: Center(
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      // Add your scrollable content here

                      PlaylistTile(
                        playlistName: 'Chill Vibes',
                        onPlay: () => {},
                      ),
                      PlaylistTile(
                        playlistName: 'Workout Mix',
                        onPlay: () => {},
                      ),
                      PlaylistTile(
                        playlistName: 'Top Hits',
                        onPlay: () => {},
                      ),
                      PlaylistTile(
                        playlistName: 'Workout Mix',
                        onPlay: () => {},
                      ),
                      PlaylistTile(
                        playlistName: 'Chill Vibes',
                        onPlay: () => {},
                      ),
                      PlaylistTile(
                        playlistName: 'Workout Mix',
                        onPlay: () => {},
                      ),
                      PlaylistTile(
                        playlistName: 'Top Hits',
                        onPlay: () => {},
                      ),
                      PlaylistTile(
                        playlistName: 'Workout Mix',
                        onPlay: () => {},
                      ), // Add more content as needed
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
