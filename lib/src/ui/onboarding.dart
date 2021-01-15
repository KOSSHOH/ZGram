import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:messenger/src/app_theme.dart';

class OnBoarding extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _OnBoardingState();
  }
}

class _OnBoardingState extends State<OnBoarding> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.white,
      body: Text(
        "ssfsfd ff  ",
        style: AppTheme.boldOverline(AppTheme.black80),
      ),
    );
  }
}
