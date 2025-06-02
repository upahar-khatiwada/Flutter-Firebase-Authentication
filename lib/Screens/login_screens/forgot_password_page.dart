import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_auth/Screens/login_screens/login_screens_constants/const_var.dart';
import 'package:flutter_auth/Screens/login_screens/sign_up_helper_methods/display_error_message.dart';

class ForgotPasswordPage extends StatefulWidget {
  const ForgotPasswordPage({super.key});

  @override
  State<ForgotPasswordPage> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<ForgotPasswordPage> {
  late final TextEditingController forgotEmailController;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    forgotEmailController = TextEditingController();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    forgotEmailController.dispose();
    super.dispose();
  }

  // function to reset the password
  void resetPassword() async {
    if (forgotEmailController.text.trim().isEmpty) {
      displayErrorMessage("Text Field can't be empty", 'Error', context);
      return;
    }

    try {
      await FirebaseAuth.instance.sendPasswordResetEmail(
        email: forgotEmailController.text.trim(),
      );

      if (mounted) {
        displayErrorMessage(
          'Reset password Link Sent!',
          'Check Inbox!',
          context,
        );
        Navigator.pop(context); // to send the user back to login screen
      }
    } on FirebaseAuthException catch (e) {
      if (mounted) {
        displayErrorMessage('Error: ${e.code}', 'Error', context);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    // calculating screen's width and height dynamically
    final double screenWidth = MediaQuery.of(context).size.width;
    final double screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      body: Center(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              const Icon(Icons.lock, size: 100),
              SizedBox(height: screenHeight * 0.01),
              Text(
                'Forgot Password',
                style: TextStyle(
                  color: textColor,
                  fontSize: screenHeight * 0.04,
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
                    hintText: 'Enter your e-mail',
                    hintStyle: TextStyle(color: hintTextColor),
                    prefixIcon: const Icon(Icons.mail),
                    filled: true,
                    fillColor: fillColor,
                  ),
                  controller: forgotEmailController,
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
                    onTap: resetPassword,
                    child: Container(
                      width: double.maxFinite,
                      height: screenHeight * 0.07,
                      decoration: BoxDecoration(
                        color: loginButtonColor,
                        borderRadius: BorderRadius.circular(
                          screenHeight * 0.01,
                        ),
                      ),
                      child: Center(
                        child: Text(
                          'Reset Password',
                          style: TextStyle(
                            color: forgotPasswordTextColor,
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
              Padding(
                padding: EdgeInsets.symmetric(horizontal: screenHeight * 0.02),
                child: Material(
                  color: Colors.transparent,
                  borderRadius: BorderRadius.circular(screenHeight * 0.01),
                  clipBehavior: Clip.hardEdge,
                  child: InkWell(
                    splashColor: splashColor,
                    onTap: () {
                      Navigator.pop(context);
                    },
                    child: Container(
                      width: double.maxFinite,
                      height: screenHeight * 0.07,
                      decoration: BoxDecoration(
                        color: goBackButtonColor,
                        borderRadius: BorderRadius.circular(
                          screenHeight * 0.01,
                        ),
                        border: Border.all(color: goBackButtonBorderColor),
                      ),
                      child: Center(
                        child: Text(
                          'Go Back!',
                          style: TextStyle(
                            color: forgotPasswordTextColor,
                            fontSize: screenWidth * 0.07,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// Widget build(BuildContext context) {
//   // calculating screen's width and height dynamically
//   final double screenWidth = MediaQuery.of(context).size.width;
//   final double screenHeight = MediaQuery.of(context).size.height;
//
//   return Scaffold(
//     body: LayoutBuilder(
//       builder: (BuildContext context, BoxConstraints constraints) {
//         return SingleChildScrollView(
//           child: ConstrainedBox(
//             constraints: BoxConstraints(minHeight: constraints.maxHeight),
//             child: Column(
//               mainAxisAlignment: MainAxisAlignment.center,
//               mainAxisSize: MainAxisSize.max,
//               crossAxisAlignment: CrossAxisAlignment.center,
//               children: <Widget>[
//                 const Icon(Icons.lock, size: 100),
//                 SizedBox(height: screenHeight * 0.01),
//                 Text(
//                   'Forgot Password',
//                   style: TextStyle(
//                     color: textColor,
//                     fontSize: screenHeight * 0.04,
//                   ),
//                 ),
//                 SizedBox(height: screenHeight * 0.03),
//                 Padding(
//                   padding: EdgeInsets.symmetric(
//                     horizontal: screenHeight * 0.02,
//                   ),
//                   child: TextField(
//                     decoration: InputDecoration(
//                       enabledBorder: OutlineInputBorder(
//                         borderSide: const BorderSide(color: borderColor),
//                         borderRadius: BorderRadius.circular(
//                           screenWidth * 0.02,
//                         ),
//                       ),
//                       focusedBorder: OutlineInputBorder(
//                         borderSide: const BorderSide(
//                           color: emailAndPasswordOutlineColor,
//                         ),
//                         borderRadius: BorderRadius.circular(
//                           screenWidth * 0.02,
//                         ),
//                       ),
//                       hintText: 'Enter your e-mail',
//                       hintStyle: TextStyle(color: hintTextColor),
//                       prefixIcon: const Icon(Icons.mail),
//                       filled: true,
//                       fillColor: fillColor,
//                     ),
//                     controller: forgotEmailController,
//                     cursorErrorColor: Colors.red,
//                   ),
//                 ),
//                 SizedBox(height: screenHeight * 0.03),
//                 Padding(
//                   padding: EdgeInsets.symmetric(
//                     horizontal: screenHeight * 0.02,
//                   ),
//                   child: Material(
//                     color: Colors.transparent,
//                     borderRadius: BorderRadius.circular(screenHeight * 0.01),
//                     clipBehavior: Clip.hardEdge,
//                     child: InkWell(
//                       onTap: resetPassword,
//                       child: Container(
//                         width: double.maxFinite,
//                         height: screenHeight * 0.07,
//                         decoration: BoxDecoration(
//                           color: loginButtonColor,
//                           borderRadius: BorderRadius.circular(
//                             screenHeight * 0.01,
//                           ),
//                         ),
//                         child: Center(
//                           child: Text(
//                             'Reset Password',
//                             style: TextStyle(
//                               color: forgotPasswordTextColor,
//                               fontSize: screenWidth * 0.07,
//                               fontWeight: FontWeight.bold,
//                             ),
//                           ),
//                         ),
//                       ),
//                     ),
//                   ),
//                 ),
//                 SizedBox(height: screenHeight * 0.02),
//                 Padding(
//                   padding: EdgeInsets.symmetric(
//                     horizontal: screenHeight * 0.02,
//                   ),
//                   child: Material(
//                     color: Colors.transparent,
//                     borderRadius: BorderRadius.circular(screenHeight * 0.01),
//                     clipBehavior: Clip.hardEdge,
//                     child: InkWell(
//                       splashColor: splashColor,
//                       onTap: () {
//                         Navigator.pop(context);
//                       },
//                       child: Container(
//                         width: double.maxFinite,
//                         height: screenHeight * 0.07,
//                         decoration: BoxDecoration(
//                           color: goBackButtonColor,
//                           borderRadius: BorderRadius.circular(
//                             screenHeight * 0.01,
//                           ),
//                           border: Border.all(color: goBackButtonBorderColor),
//                         ),
//                         child: Center(
//                           child: Text(
//                             'Go Back!',
//                             style: TextStyle(
//                               color: forgotPasswordTextColor,
//                               fontSize: screenWidth * 0.07,
//                               fontWeight: FontWeight.bold,
//                             ),
//                           ),
//                         ),
//                       ),
//                     ),
//                   ),
//                 ),
//               ],
//             ),
//           ),
//         );
//       },
//     ),
//   );
// }
