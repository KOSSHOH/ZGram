import 'dart:async';
import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:messenger/src/app_theme.dart';
import 'package:messenger/src/utils/styles.dart';
import 'package:messenger/src/utils/utils.dart';
import 'package:pinput/pin_put/pin_put.dart';

class ResetPasswordScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _ResetPasswordScreenState();
  }
}

class _ResetPasswordScreenState extends State<ResetPasswordScreen> {
  bool loading = false;

  TextEditingController passwordController = TextEditingController();
  TextEditingController passwordConfirmController = TextEditingController();

  bool _password = true;
  bool _passwordConfirm = true;

  void _passwordToggle() {
    setState(() {
      _password = !_password;
    });
  }

  void _passwordConfirmToggle() {
    setState(() {
      _passwordConfirm = !_passwordConfirm;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.screen,
      body: ListView(
        padding: EdgeInsets.only(
          top: 0,
        ),
        children: [
          Container(
            margin: EdgeInsets.only(
              top: 64,
              left: 25,
              right: 25,
            ),
            child: Row(
              children: [
                GestureDetector(
                  child: SvgPicture.asset("assets/icon/arrow-left.svg"),
                  onTap: () {
                    Navigator.pop(context);
                  },
                ),
                SizedBox(width: 20),
                Text(
                  "Reset Password",
                  style: Styles.boldH4(AppTheme.dark),
                ),
              ],
            ),
          ),
          Container(
            width: double.infinity,
            margin: EdgeInsets.only(
              top: 50,
            ),
            child: Center(
              child: Image.asset(
                "assets/images/logo.png",
              ),
            ),
          ),
          Container(
            margin: EdgeInsets.only(
              left: 25,
              right: 25,
              top: 50,
            ),
            child: Text(
              "Set your new password for your account so you can login and access all the features in Zelio App.",
              style: Styles.regularLabel(
                Color(0xFF616161),
              ),
            ),
          ),
          Container(
            margin: EdgeInsets.only(
              top: 52,
              left: 25,
              right: 25,
            ),
            child: Text(
              "Password",
              style: Styles.semiBoldLabel(AppTheme.dark),
            ),
          ),
          Container(
            margin: EdgeInsets.only(
              top: 15,
              left: 25,
              right: 25,
            ),
            child: Theme(
              data: ThemeData(
                accentColor: Color(0xFF327FEB),
                canvasColor: Colors.transparent,
                textTheme: AppTheme.textTheme,
                platform: Platform.isAndroid
                    ? TargetPlatform.android
                    : TargetPlatform.iOS,
              ),
              child: Container(
                height: 56,
                padding: EdgeInsets.only(
                  left: 20,
                  right: 25,
                ),
                decoration: BoxDecoration(
                  color: AppTheme.white,
                  borderRadius: BorderRadius.circular(
                    27.5,
                  ),
                  boxShadow: [
                    BoxShadow(
                      offset: Offset(0, 10),
                      color: Color.fromRGBO(147, 147, 147, 0.1),
                      blurRadius: 75,
                      spreadRadius: 0,
                    )
                  ],
                ),
                child: Row(
                  children: [
                    Expanded(
                      child: Container(
                        padding: EdgeInsets.only(
                          bottom: 3,
                          right: 15,
                        ),
                        child: TextFormField(
                          obscureText: _password,
                          style: Styles.semiBoldDisplay(AppTheme.dark),
                          decoration: InputDecoration(
                            border: InputBorder.none,
                            hintText: "Enter your new password",
                            hintStyle: Styles.regularDisplay(AppTheme.grey80),
                          ),
                          controller: passwordController,
                        ),
                      ),
                    ),
                    GestureDetector(
                      onTap: _passwordToggle,
                      child: Container(
                        height: 24,
                        width: 24,
                        child: _password
                            ? SvgPicture.asset("assets/icon/eye.svg")
                            : SvgPicture.asset("assets/icon/eye-off.svg"),
                      ),
                    )
                  ],
                ),
              ),
            ),
          ),
          Container(
            margin: EdgeInsets.only(
              top: 40,
              left: 25,
              right: 25,
            ),
            child: Text(
              "Confirm Password",
              style: Styles.semiBoldLabel(AppTheme.dark),
            ),
          ),
          Container(
            margin: EdgeInsets.only(
              top: 15,
              left: 25,
              right: 25,
            ),
            child: Theme(
              data: ThemeData(
                accentColor: Color(0xFF327FEB),
                canvasColor: Colors.transparent,
                textTheme: AppTheme.textTheme,
                platform: Platform.isAndroid
                    ? TargetPlatform.android
                    : TargetPlatform.iOS,
              ),
              child: Container(
                height: 56,
                padding: EdgeInsets.only(
                  left: 20,
                  right: 25,
                ),
                decoration: BoxDecoration(
                  color: AppTheme.white,
                  borderRadius: BorderRadius.circular(
                    27.5,
                  ),
                  boxShadow: [
                    BoxShadow(
                      offset: Offset(0, 10),
                      color: Color.fromRGBO(147, 147, 147, 0.1),
                      blurRadius: 75,
                      spreadRadius: 0,
                    )
                  ],
                ),
                child: Row(
                  children: [
                    Expanded(
                      child: Container(
                        padding: EdgeInsets.only(
                          bottom: 3,
                          right: 15,
                        ),
                        child: TextFormField(
                          obscureText: _passwordConfirm,
                          style: Styles.semiBoldDisplay(AppTheme.dark),
                          decoration: InputDecoration(
                            border: InputBorder.none,
                            hintText: "Enter your new password",
                            hintStyle: Styles.regularDisplay(AppTheme.grey80),
                          ),
                          controller: passwordConfirmController,
                        ),
                      ),
                    ),
                    GestureDetector(
                      onTap: _passwordConfirmToggle,
                      child: Container(
                        height: 24,
                        width: 24,
                        child: _passwordConfirm
                            ? SvgPicture.asset("assets/icon/eye.svg")
                            : SvgPicture.asset("assets/icon/eye-off.svg"),
                      ),
                    )
                  ],
                ),
              ),
            ),
          ),
          GestureDetector(
            onTap: () {
              if (!loading &&
                  passwordController.text.length > 0 &&
                  passwordConfirmController.text.length > 0 &&
                  (passwordConfirmController.text == passwordController.text)) {
                setState(() {
                  loading = true;
                });
                Timer(Duration(milliseconds: 1500), () {
                  setState(() {
                    loading = false;
                  });
                  Utils.savePassword(passwordController.text);
                  Navigator.of(context).popUntil((route) => route.isFirst);
                });
              }
            },
            child: Container(
              margin: EdgeInsets.only(
                left: 25,
                right: 25,
                top: 45,
                bottom: 69,
              ),
              height: 56,
              decoration: BoxDecoration(
                color: AppTheme.primary,
                borderRadius: BorderRadius.circular(28.5),
                boxShadow: [
                  BoxShadow(
                    offset: Offset(0, 6),
                    blurRadius: 75,
                    spreadRadius: 0,
                    color: Color.fromRGBO(100, 87, 87, 0.05),
                  )
                ],
              ),
              child: Center(
                child: loading
                    ? CircularProgressIndicator(
                        strokeWidth: 3.0,
                        valueColor:
                            AlwaysStoppedAnimation<Color>(AppTheme.white),
                      )
                    : Text(
                        "Reset Password",
                        style: Styles.boldButton(AppTheme.white),
                      ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
