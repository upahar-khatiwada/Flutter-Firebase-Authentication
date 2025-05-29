import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_auth/Screens/login_screens/login_screens_constants/const_var.dart';
import 'package:flutter_auth/Screens/login_screens/auth_page.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  late final TextEditingController signUpEmailController;
  late final TextEditingController signUpPasswordController;
  late final TextEditingController signUpPasswordConfirmController;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    signUpEmailController = TextEditingController();
    signUpPasswordController = TextEditingController();
    signUpPasswordConfirmController = TextEditingController();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    signUpEmailController.dispose();
    signUpPasswordController.dispose();
    signUpPasswordConfirmController.dispose();
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
    );
  }

  void signUp() async {
    if (signUpEmailController.text.trim().isEmpty ||
        signUpPasswordController.text.trim().isEmpty ||
        signUpPasswordConfirmController.text.trim().isEmpty) {
      if (mounted) {
        displayErrorMessage('Please fill out the respective fields!');
      }
      return;
    }

    if (signUpPasswordController.text != signUpPasswordConfirmController.text) {
      if (mounted) {
        displayErrorMessage("Passwords don't match");
      }
      return;
    }

    if (mounted) {
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
      );
    }

    try {
      await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: signUpEmailController.text.trim(),
        password: signUpPasswordController.text.trim(),
      );

      if (mounted) {
        Navigator.pop(context);

        Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute<Widget>(
            builder: (BuildContext context) => const AuthPage(),
          ),
          (Route<dynamic> route) => false,
        );
      }
    } on FirebaseAuthException catch (e) {
      if (mounted) {
        Navigator.pop(context);
        displayErrorMessage(e.code);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    // calculating screen's width and height dynamically
    final double screenWidth = MediaQuery.of(context).size.width;
    final double screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(color: textColor),
        title: Text(
          'Sign Up!',
          style: TextStyle(color: textColor, letterSpacing: 2.0),
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            SizedBox(height: screenHeight * 0.03),
            SizedBox(
              width: screenWidth * 0.5 > 300 ? 250 : screenWidth * 0.5,
              height: screenHeight * 0.3 > 200 ? 150 : screenHeight * 0.3,
              child: Image.asset('assets/sign_up.webp', fit: BoxFit.contain),
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
                controller: signUpEmailController,
                cursorErrorColor: Colors.red,
              ),
            ),
            SizedBox(height: screenHeight * 0.02),
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
                controller: signUpPasswordController,
                cursorErrorColor: Colors.red,
              ),
            ),
            SizedBox(height: screenHeight * 0.02),
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
                  hintText: 'Confirm Password',
                  hintStyle: TextStyle(color: hintTextColor),
                  prefixIcon: const Icon(Icons.password_sharp),
                ),
                obscureText: true,
                controller: signUpPasswordConfirmController,
                cursorErrorColor: Colors.red,
              ),
            ),
            SizedBox(height: screenHeight * 0.05),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: screenHeight * 0.02),
              child: Material(
                color: Colors.transparent,
                borderRadius: BorderRadius.circular(screenHeight * 0.01),
                clipBehavior: Clip.hardEdge,
                child: InkWell(
                  onTap: signUp,
                  child: Container(
                    width: double.maxFinite,
                    height: screenHeight * 0.07,
                    decoration: BoxDecoration(
                      color: loginButtonColor,
                      borderRadius: BorderRadius.circular(screenHeight * 0.01),
                    ),
                    child: Center(
                      child: Text(
                        'Sign Up',
                        style: TextStyle(
                          color: signUpTextColor,
                          fontSize: screenWidth * 0.07,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),
            SizedBox(height: screenHeight * 0.02),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Text(
                  'Already have an account?',
                  style: TextStyle(
                    color: Colors.grey[800],
                    fontSize: screenWidth * 0.04,
                    letterSpacing: 0.5,
                  ),
                ),
                SizedBox(width: screenWidth * 0.02),
                Material(
                  color: Colors.transparent,
                  child: InkWell(
                    onTap: () {
                      Navigator.pop(context);
                      // Navigator.push(
                      //   context,
                      //   MaterialPageRoute(builder: (context) => testPage()),
                      // );
                    },
                    child: Text(
                      'Login Now!',
                      style: TextStyle(
                        color: Colors.red,
                        fontSize: screenWidth * 0.04,
                        letterSpacing: 1.0,
                      ),
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
        onTap: () {},
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
