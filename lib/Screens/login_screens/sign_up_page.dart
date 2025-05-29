import 'package:flutter/material.dart';
import 'package:flutter_auth/Screens/login_screens/login_screens_constants/const_var.dart';

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

  @override
  Widget build(BuildContext context) {
    // calculating screen's width and height dynamically
    final double screenWidth = MediaQuery.of(context).size.width;
    final double screenHeight = MediaQuery.of(context).size.height;

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        backgroundColor: bgColor,
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            SizedBox(height: screenHeight * 0.1),
            SizedBox(
              width: screenWidth * 0.5 > 300 ? 250 : screenWidth * 0.5,
              height: screenHeight * 0.3 > 200 ? 150 : screenHeight * 0.3,
              child: Image.asset('assets/sign_up.webp', fit: BoxFit.contain),
            ),
            SizedBox(height: screenHeight * 0.03),
            Text(
              'Sign Up!',
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
            SizedBox(height: screenHeight * 0.03),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: screenHeight * 0.02),
              child: Material(
                color: Colors.transparent,
                borderRadius: BorderRadius.circular(screenHeight * 0.01),
                clipBehavior: Clip.hardEdge,
                child: InkWell(
                  splashColor: splashColor,
                  onTap: () {},
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
                    padding: EdgeInsets.all(screenHeight * 0.01),
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
                  onTap: () {},
                ),
              ],
            ),
            SizedBox(height: screenHeight * 0.04),
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
        splashColor: splashColor,
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
