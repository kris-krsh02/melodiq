import 'dart:typed_data';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:web_socket_channel/web_socket_channel.dart';
import 'package:audioplayers/audioplayers.dart';
import 'package:path_provider/path_provider.dart';
import 'package:frontend/components/custom_app_bar.dart';

class MusicPlayerPage extends StatefulWidget {
  final WebSocketChannel? channel;

  const MusicPlayerPage({Key? key, this.channel}) : super(key: key);

  @override
  _MusicPlayerPageState createState() => _MusicPlayerPageState();
}

class _MusicPlayerPageState extends State<MusicPlayerPage> {
  bool isPlaying = false;
  AudioPlayer _audioPlayer = AudioPlayer();
  String songTitle = "Loading...";
  late String _filePath;
  List<int> _audioData = [];
  Duration _totalDuration = Duration.zero;
  Duration _currentPosition = Duration.zero;

  @override
  void initState() {
    super.initState();
    _listenToWebSocket();
    _audioPlayer.onDurationChanged.listen((duration) {
      setState(() {
        _totalDuration = duration;
      });
    });
    _audioPlayer.onPositionChanged.listen((position) {
      setState(() {
        _currentPosition = position;
      });
    });
  }

  void _listenToWebSocket() {
    widget.channel?.stream.listen((message) async {
      if (message is String && message.startsWith("title:")) {
        setState(() {
          songTitle = message
              .replaceFirst("title:", "")
              .replaceAll('_', ' ')
              .replaceAll('.wav', '');
        });
        print("Received title: $songTitle");
      } else if (message is String && message == "END_OF_DATA") {
        print("Received end of data signal");
        if (_audioData.isNotEmpty) {
          await _saveAndPlayAudio();
        }
      } else if (message is List<int>) {
        _audioData.addAll(message);
        print("Received audio data chunk");
      }
    }, onError: (error) {
      print("WebSocket error: $error");
    });
  }

  Future<void> _saveAndPlayAudio() async {
    try {
      final directory = await getApplicationDocumentsDirectory();
      final timestamp = DateTime.now().millisecondsSinceEpoch;
      _filePath = '${directory.path}/received_audio_$timestamp.wav';

      final file = File(_filePath);
      await file.writeAsBytes(_audioData);
      setState(() {
        _audioData.clear();
      });

      print("Audio file saved at $_filePath");

      await _audioPlayer.play(DeviceFileSource(_filePath));
      setState(() {
        isPlaying = true;
      });
    } catch (e) {
      print("Error saving or playing audio: $e");
    }
  }

  @override
  void dispose() {
    widget.channel?.sink.close();
    _audioPlayer.dispose();
    super.dispose();
  }

  void _playPause() {
    setState(() {
      isPlaying = !isPlaying;
      if (isPlaying) {
        _audioPlayer.resume();
      } else {
        _audioPlayer.pause();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Spacer(),
            Align(
              alignment: Alignment.centerLeft,
              child: Text(
                songTitle,
                style:
                    const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                textAlign: TextAlign.left,
              ),
            ),
            const SizedBox(height: 16),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(_formatDuration(_currentPosition)),
                Text(_formatDuration(_totalDuration)),
              ],
            ),
            SliderTheme(
              data: SliderTheme.of(context).copyWith(
                inactiveTrackColor: Colors.grey,
                overlayColor:
                    Colors.grey.withAlpha(32), // Color for the overlay
                thumbShape: RoundSliderThumbShape(enabledThumbRadius: 12.0),
                overlayShape: RoundSliderOverlayShape(overlayRadius: 24.0),
              ),
              child: Slider(
                value: _totalDuration.inSeconds > 0
                    ? _currentPosition.inSeconds / _totalDuration.inSeconds
                    : 0.0,
                onChanged: (value) {
                  final position = value * _totalDuration.inSeconds;
                  _audioPlayer.seek(Duration(seconds: position.round()));
                },
                min: 0.0,
                max: 1.0,
              ),
            ),
            Center(
              child: IconButton(
                icon: Icon(isPlaying
                    ? Icons.pause_circle_filled
                    : Icons.play_circle_filled),
                iconSize: 60,
                onPressed: _playPause,
              ),
            ),
          ],
        ),
      ),
    );
  }

  String _formatDuration(Duration duration) {
    String twoDigits(int n) => n.toString().padLeft(2, '0');
    final minutes = twoDigits(duration.inMinutes.remainder(60));
    final seconds = twoDigits(duration.inSeconds.remainder(60));
    return '$minutes:$seconds';
  }
}
