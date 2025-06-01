import 'dart:async';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_auth/Screens/home_page.dart';
import 'package:flutter_auth/Screens/login_screens/login_screens_constants/const_var.dart';
import 'package:flutter_auth/Screens/login_screens/sign_up_helper_methods/display_error_message.dart';

import 'login_page.dart';

class EmailVerificationPage extends StatefulWidget {
  const EmailVerificationPage({super.key});

  @override
  State<EmailVerificationPage> createState() => _EmailVerificationPageState();
}

class _EmailVerificationPageState extends State<EmailVerificationPage> {
  late Timer timer;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    checkIfEmailIsVerified();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    timer.cancel();
    super.dispose();
  }

  void checkIfEmailIsVerified() {
    timer = Timer.periodic(const Duration(seconds: 1, milliseconds: 500), (
      Timer timer,
    ) async {
      final User? user = FirebaseAuth.instance.currentUser;

      if (user == null) {
        timer.cancel();
        if (mounted) {
          Navigator.pushReplacement(
            context,
            MaterialPageRoute<Widget>(
              builder: (BuildContext context) => const LoginScreen(),
            ),
          );
        }
        return;
      }
      try {
        await user.reload();
        if (user.emailVerified) {
          timer.cancel();
          if (mounted) {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute<Widget>(
                builder: (BuildContext context) => const HomePage(),
              ),
            );
          }
        }
      } catch (e) {
        if (mounted) {
          displayErrorMessage('Error :$e', 'Error', context);
        }
      }
    });
  }

  // Future<void> refreshUser() async {
  //   final User? user = FirebaseAuth.instance.currentUser;
  //   if (user != null) {
  //     await user.reload();
  //   }
  // }

  @override
  Widget build(BuildContext context) {
    // refreshUser();
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            const CircularProgressIndicator(
              color: circularProgressIndicatorColor,
            ),
            const SizedBox(height: 20),
            Text(
              'Please Verify Your E-mail',
              textAlign: TextAlign.center,
              style: TextStyle(color: textColor),
            ),
          ],
        ),
      ),
    );
  }
}
