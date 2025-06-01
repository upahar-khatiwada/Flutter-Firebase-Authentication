import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_auth/Screens/home_page.dart';
import 'package:flutter_auth/Screens/login_screens/login_page.dart';
import 'package:flutter_auth/Screens/login_screens/login_screens_constants/const_var.dart';

class AuthPage extends StatelessWidget {
  const AuthPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder<User?>(
        stream: FirebaseAuth.instance
            .authStateChanges(), // listens to the auth changes
        // and navigates the app accordingly
        builder: (BuildContext context, AsyncSnapshot<User?> snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(
                color: circularProgressIndicatorColor,
              ),
            );
          } else if (snapshot.hasData) {
            return const HomePage(); // if login was successful returns home page
          } else {
            return const LoginScreen(); // else back to login screen
          }
        },
      ),
    );
  }
}
