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

class LoginScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _LoginScreenState();
  }
}

class _LoginScreenState extends State<LoginScreen> {
  TextEditingController userNameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  bool loading = false;
  bool _obscureText = true;

  FocusScopeNode currentFocus;

  @override
  void initState() {
    _registerBus();
    super.initState();
  }

  @override
  void dispose() {
    RxBus.destroy();
    super.dispose();
  }

  void _toggle() {
    setState(() {
      _obscureText = !_obscureText;
    });
  }

  @override
  Widget build(BuildContext context) {
    currentFocus = FocusScope.of(context);
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
              "Username or Email",
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
                      hintText: "Enter your username or email",
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
            onTap: () {},
            child: Container(
              margin: EdgeInsets.only(
                top: 25,
                right: 25,
              ),
              width: double.infinity,
              child: Align(
                alignment: Alignment.centerRight,
                child: Text(
                  "Forgot Password?",
                  style: Styles.regularDisplay(AppTheme.dark80),
                ),
              ),
            ),
          ),
          GestureDetector(
            onTap: () {
              if (!loading &&
                  userNameController.text.length > 0 &&
                  passwordController.text.length > 0) {
                setState(() {
                  loading = true;
                });
                FocusScopeNode currentFocus = FocusScope.of(context);
                Timer(Duration(milliseconds: 1500), () {
                  Utils.isLoginCheck(
                          userNameController.text, passwordController.text)
                      .then((value) => {
                            if (value)
                              {
                                setState(() {
                                  loading = false;
                                }),

                                ///login
                              }
                            else
                              {
                                setState(() {
                                  loading = false;
                                }),
                                if (!currentFocus.hasPrimaryFocus)
                                  {
                                    currentFocus.unfocus(),
                                  },
                                BottomDialog.sendComplain(context),
                              }
                          });
                });
              }
            },
            child: Container(
              margin: EdgeInsets.only(
                left: 25,
                right: 25,
                top: 30,
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
          Container(
            margin: EdgeInsets.only(
              left: 25,
              right: 25,
              top: 20,
            ),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Expanded(
                  child: Container(
                    margin: EdgeInsets.only(top: 7),
                    height: 1,
                    color: AppTheme.grey60,
                  ),
                ),
                SizedBox(width: 20),
                Text(
                  "Or login with",
                  style: Styles.regularDisplay(AppTheme.dark80),
                ),
                SizedBox(width: 20),
                Expanded(
                  child: Container(
                    margin: EdgeInsets.only(top: 7),
                    height: 1,
                    color: AppTheme.grey60,
                  ),
                ),
              ],
            ),
          ),
          Container(
            margin: EdgeInsets.only(
              top: 20,
              left: 25,
              right: 25,
              bottom: 69,
            ),
            height: 56,
            decoration: BoxDecoration(
              color: AppTheme.white,
              borderRadius: BorderRadius.circular(
                28.5,
              ),
              boxShadow: [
                BoxShadow(
                  offset: Offset(0, 6),
                  blurRadius: 75,
                  spreadRadius: 0,
                  color: Color.fromRGBO(100, 87, 87, 0.15),
                )
              ],
            ),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SvgPicture.asset(
                  'assets/icon/icon_google.svg',
                ),
                SizedBox(width: 15),
                Text(
                  "Google",
                  style: Styles.boldButton(AppTheme.dark),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }

  Future<void> _registerBus() async {
    RxBus.register<LoadingModel>(tag: "EVENT_LOADING_LOGIN").listen(
      (event) => {
        if (!event.loading)
          {
            if (!loading &&
                userNameController.text.length > 0 &&
                passwordController.text.length > 0)
              {
                setState(() {
                  loading = true;
                }),
                Timer(Duration(milliseconds: 1500), () {
                  Utils.isLoginCheck(
                          userNameController.text, passwordController.text)
                      .then((value) => {
                            if (value)
                              {
                                setState(() {
                                  loading = false;
                                }),

                                ///login
                              }
                            else
                              {
                                setState(() {
                                  loading = false;
                                }),
                                if (!currentFocus.hasPrimaryFocus)
                                  {
                                    currentFocus.unfocus(),
                                  },
                                BottomDialog.sendComplain(context),
                              }
                          });
                }),
              }
          }
      },
    );
  }
}
