import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_auth/Screens/login_screens/login_screens_constants/const_var.dart';

class HomePage extends StatelessWidget {
  HomePage({super.key});

  final User user = FirebaseAuth.instance.currentUser!;

  void signOut() async {
    await FirebaseAuth.instance.signOut();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Home Page', style: TextStyle(color: textColor)),
        centerTitle: true,
      ),
      body: Center(
        child: Column(
          children: <Widget>[
            Text('${user.email} logged in', style: TextStyle(color: textColor)),
            const SizedBox(height: 10),
            ElevatedButton.icon(
              onPressed: signOut,
              label: Text('Sign Out!', style: TextStyle(color: textColor)),
              icon: const Icon(Icons.logout),
            ),
          ],
        ),
      ),
    );
  }
}
