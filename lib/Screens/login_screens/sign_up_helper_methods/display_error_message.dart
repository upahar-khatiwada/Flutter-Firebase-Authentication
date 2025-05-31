import 'package:flutter/material.dart';
import 'package:flutter_auth/Screens/login_screens/login_screens_constants/const_var.dart';

void displayErrorMessage(String message, BuildContext context) {
  // this schedules a callback to run after current frame is done rendering
  // once building is finished and laying out the current UI, then only this runs
  WidgetsBinding.instance.addPostFrameCallback((_) {
    if (context.mounted) {
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: const Text('Error'),
            content: Text(message, style: TextStyle(color: textColor)),
            actions: <Widget>[
              TextButton(
                onPressed: () => Navigator.of(context).pop(),
                child: const Text('OK'),
              ),
            ],
          );
        },
        useRootNavigator: true, // ensures it works from nested navigators
      );
    }
  });
}
