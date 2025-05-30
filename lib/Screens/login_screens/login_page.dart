import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_auth/Screens/login_screens/login_screens_constants/const_var.dart';
import 'package:flutter_auth/Screens/login_screens/sign_up_helper_methods/sign_up_with_google.dart';
import 'package:flutter_auth/main.dart';
import 'package:logger/logger.dart';

final Logger logger = Logger();

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  late final TextEditingController emailController; // controller for email
  late final TextEditingController
  passwordController; // controller for password

  // initializing the controllers
  @override
  void initState() {
    super.initState();

    emailController = TextEditingController();
    passwordController = TextEditingController();
  }

  // disposing the controllers
  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();

    super.dispose();
  }

  void displayErrorMessage(String message) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Center(
            child: Text(message, style: TextStyle(color: textColor)),
          ),
        );
      },
      useRootNavigator: false,
    );
  }

  void signIn() async {
    if (emailController.text.trim().isEmpty ||
        passwordController.text.trim().isEmpty) {
      displayErrorMessage('Please fill out the respective fields!');
      return;
    }

    try {
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return const Center(
            child: CircularProgressIndicator(
              color: circularProgressIndicatorColor,
            ),
          );
        },
        useRootNavigator: false,
      );

      await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: emailController.text.trim(),
        password: passwordController.text.trim(),
      );
    } on FirebaseAuthException catch (e) {
      displayErrorMessage(e.code);
      logger.e(e.message);
    } finally {
      navigatorKey.currentState?.pop();
    }
  }

  @override
  Widget build(BuildContext context) {
    // calculating screen's width and height dynamically
    final double screenWidth = MediaQuery.of(context).size.width;
    final double screenHeight = MediaQuery.of(context).size.height;
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            SizedBox(height: screenHeight * 0.1),
            SizedBox(
              width: screenWidth * 0.5 > 300 ? 300 : screenWidth * 0.5,
              height: screenHeight * 0.3 > 200 ? 200 : screenHeight * 0.3,
              child: Image.asset(
                'assets/default_profile.png',
                fit: BoxFit.contain,
              ),
            ),
            SizedBox(height: screenHeight * 0.03),
            Text(
              'Sign In!',
              style: TextStyle(
                color: textColor,
                fontSize: screenWidth * 0.05,
                letterSpacing: 3.0,
              ),
            ),
            SizedBox(height: screenHeight * 0.03),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: screenHeight * 0.02),
              child: TextField(
                decoration: InputDecoration(
                  enabledBorder: OutlineInputBorder(
                    borderSide: const BorderSide(color: borderColor),
                    borderRadius: BorderRadius.circular(screenWidth * 0.02),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: const BorderSide(
                      color: emailAndPasswordOutlineColor,
                    ),
                    borderRadius: BorderRadius.circular(screenWidth * 0.02),
                  ),
                  hintText: 'E-mail',
                  hintStyle: TextStyle(color: hintTextColor),
                  prefixIcon: const Icon(Icons.mail),
                  filled: true,
                  fillColor: fillColor,
                ),
                controller: emailController,
                cursorErrorColor: Colors.red,
              ),
            ),
            SizedBox(height: screenHeight * 0.01),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: screenHeight * 0.02),
              child: TextField(
                decoration: InputDecoration(
                  enabledBorder: OutlineInputBorder(
                    borderSide: const BorderSide(color: borderColor),
                    borderRadius: BorderRadius.circular(screenWidth * 0.02),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: const BorderSide(
                      color: emailAndPasswordOutlineColor,
                    ),
                    borderRadius: BorderRadius.circular(screenWidth * 0.02),
                  ),
                  filled: true,
                  fillColor: fillColor,
                  alignLabelWithHint: true,
                  hintText: 'Password',
                  hintStyle: TextStyle(color: hintTextColor),
                  prefixIcon: const Icon(Icons.password),
                ),
                obscureText: true,
                controller: passwordController,
                enableSuggestions: false,
                autofocus: false,
                cursorErrorColor: Colors.red,
              ),
            ),
            SizedBox(height: screenHeight * 0.009),
            Align(
              alignment: Alignment.centerRight,
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: screenHeight * 0.02),
                child: InkWell(
                  onTap: () {},
                  child: Text(
                    'Forgot Password?',
                    style: TextStyle(color: textColor, letterSpacing: 1.0),
                  ),
                ),
              ),
            ),
            SizedBox(height: screenHeight * 0.03),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: screenHeight * 0.02),
              child: Material(
                color: Colors.transparent,
                borderRadius: BorderRadius.circular(screenHeight * 0.01),
                clipBehavior: Clip.hardEdge,
                child: InkWell(
                  onTap: signIn,
                  child: Container(
                    width: double.maxFinite,
                    height: screenHeight * 0.07,
                    decoration: BoxDecoration(
                      color: loginButtonColor,
                      borderRadius: BorderRadius.circular(screenHeight * 0.01),
                    ),
                    child: Center(
                      child: Text(
                        'Sign In',
                        style: TextStyle(
                          color: signInTextColor,
                          fontSize: screenWidth * 0.07,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),
            SizedBox(height: screenHeight * 0.03),
            Padding(
              padding: EdgeInsets.all(screenHeight * 0.009),
              child: Row(
                children: <Widget>[
                  Expanded(
                    child: Divider(
                      color: dividerColor,
                      indent: screenWidth * 0.01,
                      endIndent: screenWidth * 0.01,
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.all(screenHeight * 0.007),
                    child: Text(
                      'or continue with',
                      style: TextStyle(color: textColor),
                    ),
                  ),
                  Expanded(
                    child: Divider(
                      color: dividerColor,
                      indent: screenWidth * 0.01,
                      endIndent: screenWidth * 0.01,
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: screenHeight * 0.02),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                LoginWith(
                  screenHeight: screenHeight,
                  screenWidth: screenWidth,
                  paddingValue: 0.0001,
                  assetLocation: 'assets/apple.png',
                  onTap: () {},
                ),
                LoginWith(
                  screenHeight: screenHeight,
                  screenWidth: screenWidth,
                  paddingValue: 0.0001,
                  assetLocation: 'assets/facebook1.webp',
                  onTap: () {},
                ),
                LoginWith(
                  screenHeight: screenHeight,
                  screenWidth: screenWidth,
                  paddingValue: 0.02,
                  assetLocation: 'assets/google.png',
                  onTap: () {
                    signInWithGoogle(context);
                  },
                ),
              ],
            ),
            SizedBox(height: screenHeight * 0.04),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Text(
                  'Not a member yet?',
                  style: TextStyle(
                    color: Colors.grey[800],
                    fontSize: screenWidth * 0.04,
                    letterSpacing: 0.5,
                  ),
                ),
                SizedBox(width: screenWidth * 0.02),
                InkWell(
                  onTap: () {
                    Navigator.pushNamed(context, '/signup');
                  },
                  child: Text(
                    'Register Now!',
                    style: TextStyle(
                      color: Colors.red,
                      fontSize: screenWidth * 0.04,
                      letterSpacing: 1.0,
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class LoginWith extends StatelessWidget {
  final double screenHeight, screenWidth, paddingValue;
  final String assetLocation;
  final VoidCallback onTap;
  const LoginWith({
    super.key,
    required this.screenHeight,
    required this.screenWidth,
    required this.paddingValue,
    required this.assetLocation,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        borderRadius: BorderRadius.circular(screenHeight * 0.01),
        onTap: onTap,
        child: Container(
          padding: EdgeInsets.all(screenHeight * paddingValue),
          width: screenWidth * 0.2,
          height: screenHeight * 0.08,
          decoration: BoxDecoration(
            color: fillColor,
            borderRadius: BorderRadius.circular(screenHeight * 0.01),
          ),
          child: Image.asset(assetLocation, fit: BoxFit.contain),
        ),
      ),
    );
  }
}
