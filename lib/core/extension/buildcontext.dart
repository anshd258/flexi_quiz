import 'package:flutter/material.dart';

extension BuildContextExtension on BuildContext{
  ThemeData get theme => Theme.of(this);
  ColorScheme get colorSchema => theme.colorScheme;
  TextTheme get textTheme => theme.textTheme;

   void showErrorDialog(String message) {
    showDialog(
      context: this,
      builder: (context) => AlertDialog(
        title: const Text('Error'),
        content: Text(message),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('OK'),
          ),
        ],
      ),
    );
  }

}