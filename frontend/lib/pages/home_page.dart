import 'package:flutter/material.dart';
import 'package:frontend/components/playlist_tile.dart';
import 'package:web_socket_channel/web_socket_channel.dart';
import '../components/custom_app_bar.dart';
import 'music_player_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final TextEditingController _textController = TextEditingController();
  WebSocketChannel? _channel;

  @override
  void dispose() {
    _textController.dispose();
    _channel?.sink.close();
    super.dispose();
  }

  void _submitInput() {
    String userInput = _textController.text;
    print('User input: $userInput');
    _connectWebSocket(userInput);
  }

  void _connectWebSocket(String userInput) {
    _channel =
        WebSocketChannel.connect(Uri.parse('ws://localhost:8000/ws/audio'));

    _channel!.sink.add(userInput);
    Navigator.of(context).push(MaterialPageRoute(
      builder: (context) => MusicPlayerPage(channel: _channel),
    ));
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
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      Navigator.of(context).pushNamed('/login');
                    },
                    child: CircleAvatar(
                      radius: 25,
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
                controller: _textController,
                decoration: InputDecoration(
                  filled: true,
                  fillColor: Theme.of(context)
                      .elevatedButtonTheme
                      .style!
                      .backgroundColor!
                      .resolve({}),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(15.0),
                    borderSide: BorderSide.none,
                  ),
                  hintText: 'Enter your prompt',
                  contentPadding:
                      EdgeInsets.symmetric(vertical: 10.0, horizontal: 20.0),
                ),
                maxLines: null,
                minLines: 1,
              ),
              const SizedBox(height: 15),
              ElevatedButton(
                onPressed: _submitInput,
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
              const SizedBox(height: 10),
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
            ],
          ),
        ),
      ),
    );
  }
}
