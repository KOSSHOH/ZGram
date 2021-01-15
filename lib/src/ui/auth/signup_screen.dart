import 'dart:async';
import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:messenger/src/app_theme.dart';
import 'package:messenger/src/dialog/bottom_dialog.dart';
import 'package:messenger/src/model/bus/loading_model.dart';
import 'package:messenger/src/utils/styles.dart';
import 'package:messenger/src/utils/utils.dart';
import 'package:rxbus/rxbus.dart';

class SignUpScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _SignUpScreenState();
  }
}

class _SignUpScreenState extends State<SignUpScreen> {
  TextEditingController userNameController = TextEditingController();
  TextEditingController mailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  bool loading = false;
  bool _obscureText = true;

  void _toggle() {
    setState(() {
      _obscureText = !_obscureText;
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
              top: 30,
              left: 25,
              right: 25,
            ),
            child: Text(
              "Username",
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
                platform: Platform.isAndroid
                    ? TargetPlatform.android
                    : TargetPlatform.iOS,
              ),
              child: Container(
                height: 56,
                padding: EdgeInsets.only(left: 15, right: 15, bottom: 3),
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
                child: Center(
                  child: TextFormField(
                    style: Styles.semiBoldDisplay(AppTheme.dark),
                    decoration: InputDecoration(
                      border: InputBorder.none,
                      hintText: "Create your username",
                      hintStyle: Styles.regularDisplay(AppTheme.grey80),
                    ),
                    controller: userNameController,
                  ),
                ),
              ),
            ),
          ),
          Container(
            margin: EdgeInsets.only(
              top: 35,
              left: 25,
              right: 25,
            ),
            child: Text(
              "Email",
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
                platform: Platform.isAndroid
                    ? TargetPlatform.android
                    : TargetPlatform.iOS,
              ),
              child: Container(
                height: 56,
                padding: EdgeInsets.only(left: 15, right: 15, bottom: 3),
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
                child: Center(
                  child: TextFormField(
                    style: Styles.semiBoldDisplay(AppTheme.dark),
                    decoration: InputDecoration(
                      border: InputBorder.none,
                      hintText: "Enter your email",
                      hintStyle: Styles.regularDisplay(AppTheme.grey80),
                    ),
                    controller: mailController,
                  ),
                ),
              ),
            ),
          ),
          Container(
            margin: EdgeInsets.only(
              top: 35,
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
                          obscureText: _obscureText,
                          style: Styles.semiBoldDisplay(AppTheme.dark),
                          decoration: InputDecoration(
                            border: InputBorder.none,
                            hintText: "Enter your password",
                            hintStyle: Styles.regularDisplay(AppTheme.grey80),
                          ),
                          controller: passwordController,
                        ),
                      ),
                    ),
                    GestureDetector(
                      onTap: _toggle,
                      child: Container(
                        height: 24,
                        width: 24,
                        child: _obscureText
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
                  userNameController.text.length > 0 &&
                  passwordController.text.length > 0 &&
                  mailController.text.length > 0) {
                setState(() {
                  loading = true;
                });

                Timer(Duration(milliseconds: 1500), () {
                  Utils.saveData(
                    userNameController.text,
                    passwordController.text,
                    mailController.text,
                  );
                  FocusScopeNode currentFocus = FocusScope.of(context);
                  if (!currentFocus.hasPrimaryFocus) {
                    currentFocus.unfocus();
                  }
                  setState(() {
                    loading = false;
                  });
                  ///next screen
                });
              }
            },
            child: Container(
              margin: EdgeInsets.only(
                left: 25,
                right: 25,
                top: 50,
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
                        "Login",
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
