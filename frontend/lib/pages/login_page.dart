import 'package:flutter/material.dart';
import 'package:frontend/components/custom_app_bar.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(),
      body: Center(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(30.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment:
                  CrossAxisAlignment.start, // Align text to the start (left)
              children: <Widget>[
                SizedBox(height: 10), // Add some spacing at the top
                Text(
                  'Welcome to melodIQ!',
                  style: TextStyle(
                    color: Theme.of(context).textTheme.bodyLarge?.color ??
                        Colors.black,
                    fontSize: 36,
                    fontWeight: FontWeight.bold,
                  ),
                  textAlign: TextAlign.left,
                  // Align text to the left
                ),
                SizedBox(height: 20),
                Text(
                  'Unlock AI-Crafted Playlists to Enhance Your Focus and Productivity.',
                  style: TextStyle(
                    fontSize: 24,
                    color: Theme.of(context).textTheme.bodyMedium?.color ??
                        Colors.black,
                  ),
                  textAlign: TextAlign.left, // Align text to the left
                ),
                SizedBox(height: 50),
                Center(
                  child: ElevatedButton.icon(
                    onPressed: () {
                      // Navigate to the home page and clear the entire navigation stack
                      Navigator.of(context).pushNamedAndRemoveUntil(
                          '/', (Route<dynamic> route) => false);
                    },
                    icon: Image.asset(
                      'assets/google_icon.png', // Make sure to add your Google icon in the assets folder
                      height: 24,
                      width: 24,
                    ),
                    label: Text('Continue with Google'),
                    style: ElevatedButton.styleFrom(
                      padding:
                          EdgeInsets.symmetric(horizontal: 35, vertical: 15),
                      textStyle: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        fontFamily:
                            Theme.of(context).textTheme.bodyLarge?.fontFamily,
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 20),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
