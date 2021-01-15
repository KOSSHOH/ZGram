import 'dart:async';
import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:messenger/src/app_theme.dart';
import 'package:messenger/src/utils/styles.dart';
import 'package:messenger/src/utils/utils.dart';

class ForgotPasswordScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _ForgotPasswordScreenState();
  }
}

class _ForgotPasswordScreenState extends State<ForgotPasswordScreen> {
  TextEditingController mailController = TextEditingController();
  bool loading = false;

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
              top: 80,
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
                  "Forgot Password",
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
              "Enter your email for the verification proccess, and we will send 4 digits code to your email for the verification.",
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
          GestureDetector(
            onTap: () {
              if (!loading && mailController.text.length > 0) {
                setState(() {
                  loading = true;
                });
                FocusScopeNode currentFocus = FocusScope.of(context);
                Timer(Duration(milliseconds: 1500), () {
                  setState(() {
                    loading = false;
                  });
                  Utils.isMail(mailController.text).then((value) => {
                        if (value)
                          {
                            if (!currentFocus.hasPrimaryFocus)
                              {
                                currentFocus.unfocus(),
                              },
                            ///verfy screen
                          },
                      });
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
                        "Continue",
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
