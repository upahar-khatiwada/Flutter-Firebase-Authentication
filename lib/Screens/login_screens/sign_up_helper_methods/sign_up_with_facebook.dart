import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';

Future<UserCredential?> signInWithFacebook() async {
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
  } else {
    // Handle login failure or cancellation
    print('Facebook login failed: ${loginResult.status}');
    return null;
  }
}
