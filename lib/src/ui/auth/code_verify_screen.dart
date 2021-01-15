import 'dart:async';
import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:messenger/src/app_theme.dart';
import 'package:messenger/src/utils/styles.dart';
import 'package:messenger/src/utils/utils.dart';
import 'package:pinput/pin_put/pin_put.dart';

class CodeVerifyScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _CodeVerifyScreenState();
  }
}

class _CodeVerifyScreenState extends State<CodeVerifyScreen> {
  bool loading = false;

  final TextEditingController _pinPutController = TextEditingController();
  final FocusNode _pinPutFocusNode = FocusNode();

  BoxDecoration get _pinPutDecoration {
    return BoxDecoration(
        borderRadius: BorderRadius.circular(10.0),
        border: Border.all(
          color: AppTheme.grey60,
        ),
        boxShadow: [
          BoxShadow(
              offset: Offset(0, 10),
              blurRadius: 75,
              spreadRadius: 0,
              color: Color.fromRGBO(147, 147, 147, 0.1))
        ]);
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
            color: Colors.white,
            margin: const EdgeInsets.only(
              left: 41,
              right: 41,
              top: 52,
            ),
            // padding: const EdgeInsets.all(20.0),
            child: PinPut(
              fieldsCount: 4,
              onSubmit: (String pin) => {
                print(pin),
              },
              focusNode: _pinPutFocusNode,
              controller: _pinPutController,
              submittedFieldDecoration: _pinPutDecoration,
              selectedFieldDecoration: _pinPutDecoration,
              followingFieldDecoration: _pinPutDecoration,
              textStyle: Styles.boldH2(AppTheme.dark),
              eachFieldConstraints: BoxConstraints(
                minHeight: 61.0,
                minWidth: 50.0,
              ),
            ),
          ),
          GestureDetector(
            onTap: () {
              if (!loading && _pinPutController.text.length == 4) {
                setState(() {
                  loading = true;
                });
                Timer(Duration(milliseconds: 1500), () {
                  setState(() {
                    loading = false;
                  });
                  _pinPutFocusNode.unfocus();

                  ///
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
