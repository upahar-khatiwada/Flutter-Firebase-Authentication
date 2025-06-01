import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_auth/Screens/home_page.dart';
import 'package:flutter_auth/Screens/login_screens/login_screens_constants/const_var.dart';
import 'package:flutter_auth/Screens/login_screens/sign_up_helper_methods/display_error_message.dart';
import 'package:flutter_auth/Screens/login_screens/login_page.dart';

class EmailVerificationPage extends StatefulWidget {
  const EmailVerificationPage({super.key});

  @override
  State<EmailVerificationPage> createState() => _EmailVerificationPageState();
}

class _EmailVerificationPageState extends State<EmailVerificationPage> {
  // function to check whether the email has been verified or not so that
  // app can navigate accordingly
  void refreshUserStatus() async {
    User? user = FirebaseAuth.instance.currentUser;
    if (user == null) {
      if (mounted) {
        Navigator.of(context).pushAndRemoveUntil(
          MaterialPageRoute<Widget>(
            builder: (BuildContext context) => const LoginScreen(),
          ),
          (Route<dynamic> route) => false,
        );
      }
      return;
    }
    try {
      await user.reload(); // reloading the user's status
      // have to reassign the user's instance again for reload() method to work
      user = FirebaseAuth.instance.currentUser;
      if (user!.emailVerified) {
        if (mounted) {
          Navigator.of(context).pushAndRemoveUntil(
            MaterialPageRoute<Widget>(
              builder: (BuildContext context) => const HomePage(),
            ),
            (Route<dynamic> route) => false,
          );
        }
      } else {
        if (mounted) {
          displayErrorMessage(
            'E-mail has not been verified yet!',
            'Error',
            context,
          );
        }
      }
    } catch (e) {
      if (mounted) {
        displayErrorMessage('Error occurred: $e', 'Error', context);
      }
    }
  }

  // function to resend the email to user
  // firebase has a rate limit to resend the email but that has not been handled here yet
  void resendEmail() async {
    final User? user = FirebaseAuth.instance.currentUser;

    try {
      // final User? user = FirebaseAuth.instance.currentUser;
      if (user != null && !(user.emailVerified)) {
        await user.sendEmailVerification();
        if (mounted) {
          displayErrorMessage(
            'Check your inbox!',
            'Resent Verification E-mail',
            context,
          );
        }
      }
    } catch (e) {
      if (mounted) {
        displayErrorMessage(
          'Error while resending the e-mail : $e',
          'Error',
          context,
        );
      }
      // print('Error while resending email: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: <Widget>[
          Center(
            child: Column(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                const CircularProgressIndicator(
                  color: circularProgressIndicatorColor,
                ),
                SizedBox(height: MediaQuery.of(context).size.width * 0.06),
                Text(
                  'Please Verify Your E-mail',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: textColor,
                    fontSize: MediaQuery.of(context).size.width * 0.05,
                  ),
                ),
                SizedBox(height: MediaQuery.of(context).size.width * 0.06),
                ElevatedButton.icon(
                  onPressed: resendEmail,
                  label: Text(
                    'Resend Email!',
                    style: TextStyle(
                      color: textColor,
                      fontSize: MediaQuery.of(context).size.width * 0.05,
                    ),
                  ),
                  icon: Icon(
                    Icons.refresh,
                    size: MediaQuery.of(context).size.width * 0.06,
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: EdgeInsets.all(MediaQuery.of(context).size.width * 0.05),
            child: Align(
              alignment: Alignment.bottomRight,
              child: FloatingActionButton(
                onPressed: refreshUserStatus,
                splashColor: splashColor,
                backgroundColor: floatingActionButtonColor,
                // backgroundColor: appBarColor,
                child: const Icon(Icons.navigate_next),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
