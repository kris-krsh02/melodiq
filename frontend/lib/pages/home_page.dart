import 'package:flutter/material.dart';
import '../components/custom_app_bar.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

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
              const SizedBox(height: 30),
              const Row(
                children: [
                  Text(
                    'Browse Playlists',
                    style: TextStyle(fontSize: 24),
                    textAlign: TextAlign.left,
                  ),
                ],
              )

              // Add more widgets below as needed
            ],
          ),
        ),
      ),
    );
  }
}
