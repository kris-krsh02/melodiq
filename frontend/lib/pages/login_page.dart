import 'package:flutter/material.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Login Page'),
        automaticallyImplyLeading:
            false, // This will remove the back button if any.
      ),
      body: Center(
        child: ElevatedButton(
          onPressed: () {
            // Navigate to the home page and clear the entire navigation stack
            Navigator.of(context)
                .pushNamedAndRemoveUntil('/', (Route<dynamic> route) => false);
          },
          child: Text('Login with Google'),
        ),
      ),
    );
  }
}
