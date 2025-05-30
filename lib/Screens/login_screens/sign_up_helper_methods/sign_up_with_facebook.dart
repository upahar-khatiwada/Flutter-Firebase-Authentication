import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:logger/logger.dart';
import 'package:flutter/material.dart';
import 'package:flutter_auth/main.dart';
import 'package:flutter_auth/Screens/login_screens/login_screens_constants/const_var.dart';

final Logger logger = Logger();

Future<UserCredential?> signInWithFacebook(BuildContext context) async {
  try {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return const Center(
          child: CircularProgressIndicator(
            color: circularProgressIndicatorColor,
          ),
        );
      },
      useRootNavigator: false,
    );

    // Trigger the sign-in flow
    final LoginResult loginResult = await FacebookAuth.instance.login(
      permissions: <String>[
        'public_profile',
      ], // add 'email' in the list for getting the email
    );

    // Check if login was successful
    if (loginResult.status == LoginStatus.success &&
        loginResult.accessToken != null) {
      // Create a credential from the access token
      final OAuthCredential facebookAuthCredential =
          FacebookAuthProvider.credential(loginResult.accessToken!.tokenString);

      // Sign in with the credential
      return await FirebaseAuth.instance.signInWithCredential(
        facebookAuthCredential,
      );
    }
  } on FirebaseAuthException catch (e) {
    logger.e(e.code);
  } finally {
    navigatorKey.currentState?.pop();
  }
  return null;
}
