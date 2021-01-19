import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:messenger/src/app_theme.dart';
import 'package:messenger/src/bloc/chat_bloc.dart';
import 'package:messenger/src/dialog/bottom_dialog.dart';
import 'package:messenger/src/model/chat_item_model.dart';
import 'package:messenger/src/model/chat_model.dart';
import 'package:messenger/src/utils/styles.dart';

class NotificationScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _NotificationScreenState();
  }
}

class _NotificationScreenState extends State<NotificationScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.screen,
      body: Column(
        children: [
          Container(
            color: AppTheme.white,
            height: 96,
            padding: EdgeInsets.only(
              left: 25,
              right: 25,
              bottom: 20,
            ),
            child: Column(
              children: [
                Expanded(child: Container()),
                Row(
                  children: [
                    GestureDetector(
                      onTap: () {
                        Navigator.pop(context);
                      },
                      child: SvgPicture.asset(
                        "assets/icon/arrow-left.svg",
                      ),
                    ),
                    SizedBox(width: 20),
                    Expanded(
                      child: Text(
                        "Notifications",
                        style: Styles.boldH1(AppTheme.dark),
                      ),
                    ),
                    GestureDetector(
                      onTap: () {},
                      child: SvgPicture.asset(
                        "assets/icon/more-vertical.svg",
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SvgPicture.asset("assets/icon/failed_dark.svg"),
                SizedBox(height: 35),
                Text(
                  "Notification Empty",
                  style: Styles.boldH2(AppTheme.dark),
                ),
                Container(
                  margin: EdgeInsets.only(
                    top: 20,
                    left: 25,
                    right: 25,
                  ),
                  child: Text(
                    "There are no notifications in this account, let’s discover and take a look this later.",
                    textAlign: TextAlign.center,
                    style: Styles.regularLabel(AppTheme.dark80),
                  ),
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}
