import 'package:flutter/material.dart';
import 'package:frontend/components/playlist_tile.dart';
import '../components/custom_app_bar.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  // Create a TextEditingController to manage the input
  final TextEditingController _textController = TextEditingController();

  @override
  void dispose() {
    // Dispose of the controller when the widget is disposed
    _textController.dispose();
    super.dispose();
  }

  void _submitInput() {
    // Access the input text
    String userInput = _textController.text;
    // For now, just print it. Later, you can pass this to an API
    print('User input: $userInput');
    // TODO: Pass the userInput to an API
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(30.0),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Expanded(
                    child: Text(
                      'Hey, Kristiana!',
                      style: TextStyle(fontSize: 36),
                      maxLines: 2, // Set the maximum number of lines
                      overflow: TextOverflow.ellipsis, // Handle overflow
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      // Navigate to the login page or handle logout
                      Navigator.of(context).pushNamed('/login');
                    },
                    child: CircleAvatar(
                      radius: 25, // Set the size of the avatar
                      backgroundImage: NetworkImage(
                        'https://www.example.com/profile.jpg',
                      ),
                      backgroundColor: Theme.of(context)
                          .elevatedButtonTheme
                          .style
                          ?.backgroundColor!
                          .resolve({}),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 30),
              const Text(
                'What do you want to listen to today?',
                style: TextStyle(fontSize: 24),
              ),
              const SizedBox(height: 20),
              TextField(
                controller: _textController, // Attach the controller
                decoration: InputDecoration(
                  filled: true,
                  fillColor: Theme.of(context)
                      .elevatedButtonTheme
                      .style!
                      .backgroundColor!
                      .resolve({}), // Background color
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(15.0), // Curved edges
                    borderSide: BorderSide.none, // Remove the border
                  ),
                  hintText: 'Enter your prompt', // Sample input text
                  contentPadding:
                      EdgeInsets.symmetric(vertical: 10.0, horizontal: 20.0),
                ),
                maxLines: null, // Allow the text field to grow vertically
                minLines: 1, // Minimum number of lines
              ),
              const SizedBox(height: 15),
              ElevatedButton(
                onPressed:
                    _submitInput, // Call the function when button is presse
                style: ElevatedButton.styleFrom(
                    backgroundColor:
                        Theme.of(context).textTheme.bodyLarge?.color),
                child: Text(
                  'Generate Playlist!',
                  style: TextStyle(
                      fontSize: 16,
                      color: Theme.of(context)
                          .elevatedButtonTheme
                          .style!
                          .backgroundColor!
                          .resolve({})),
                ),
              ),
              const SizedBox(height: 30),
              const Row(
                children: [
                  Text(
                    'Browse Playlists',
                    style: TextStyle(fontSize: 24),
                    textAlign: TextAlign.left,
                  ),
                ],
              ),

              const SizedBox(height: 20),
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
              // Add more widgets below as needed
            ],
          ),
        ),
      ),
    );
  }
}
