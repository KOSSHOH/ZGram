import 'package:flutter/material.dart';
import 'package:messenger/src/app_theme.dart';
import 'package:messenger/src/utils/styles.dart';
import 'package:pinput/pin_put/pin_put.dart';

class DeleteScreen extends StatefulWidget {
  @override
  DeleteScreenState createState() => DeleteScreenState();
}

class DeleteScreenState extends State<DeleteScreen> {
  final TextEditingController _pinPutController = TextEditingController();
  final FocusNode _pinPutFocusNode = FocusNode();

  BoxDecoration get _pinPutDecoration {
    return BoxDecoration(
      borderRadius: BorderRadius.circular(10.0),
      border: Border.all(
        color: AppTheme.grey60,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          Container(
            color: Colors.white,
            margin: const EdgeInsets.only(
              left: 41,
              right: 41,
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
        ],
      ),
    );
  }
}
