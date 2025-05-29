import 'package:flutter/material.dart';
import 'package:flutter_auth/Screens/login_screens/login_page.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_auth/Screens/login_screens/sign_up_page.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: '/signup',
      routes: <String, WidgetBuilder>{
        '/': (BuildContext context) => const LoginScreen(),
        '/signup': (BuildContext context) => SignUpScreen(),
      },
    );
  }
}
