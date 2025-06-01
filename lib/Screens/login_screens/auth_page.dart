import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_auth/Screens/home_page.dart';
import 'package:flutter_auth/Screens/login_screens/email_verification_page.dart';
import 'package:flutter_auth/Screens/login_screens/login_page.dart';
import 'package:flutter_auth/Screens/login_screens/login_screens_constants/const_var.dart';

class AuthPage extends StatelessWidget {
  const AuthPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder<User?>(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (BuildContext context, AsyncSnapshot<User?> snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(
                color: circularProgressIndicatorColor,
              ),
            );
          }
          // final User? user = FirebaseAuth.instance.currentUser;
          //
          // if (user == null) {
          //   return const LoginScreen();
          // } else if (!user.emailVerified) {
          //   print('FDNFVKJDBFVUEBFIUEWBFWEIUFBWEIUFBWEE');
          //   return HomePage();
          // } else {
          //   return HomePage();
          // }
          else if (snapshot.hasData) {
            return const HomePage();
          } else {
            return const LoginScreen();
          }
        },
      ),
    );
  }
}
