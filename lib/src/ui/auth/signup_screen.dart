import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:messenger/src/app_theme.dart';

class SignupScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _SignUpScreenState();
  }
}

class _SignUpScreenState extends State<SignupScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.error,
    );
  }
}
