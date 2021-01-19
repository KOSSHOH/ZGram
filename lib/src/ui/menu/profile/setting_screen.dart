import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:messenger/src/app_theme.dart';
import 'package:messenger/src/utils/styles.dart';

class SettingScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _SettingScreenState();
  }
}

class _SettingScreenState extends State<SettingScreen> {
  bool _notification = false;
  bool _privateAccount = false;

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
                        "Settings",
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
            child: ListView(
              padding: EdgeInsets.only(
                left: 25,
                right: 25,
                top: 30,
                bottom: 30,
              ),
              children: [
                Text(
                  "Account",
                  style: Styles.boldH4(AppTheme.dark),
                ),
                Container(
                  margin: EdgeInsets.only(
                    top: 25,
                  ),
                  decoration: BoxDecoration(
                    color: AppTheme.white,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  height: 56,
                  child: Row(
                    children: [
                      SizedBox(width: 23),
                      Expanded(
                        child: Text(
                          "Personal Information",
                          style: Styles.boldLabel(AppTheme.dark),
                        ),
                      ),
                      Icon(
                        Icons.arrow_forward_ios,
                        color: AppTheme.dark,
                        size: 18,
                      ),
                      SizedBox(width: 16),
                    ],
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(
                    top: 20,
                  ),
                  decoration: BoxDecoration(
                    color: AppTheme.white,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  height: 56,
                  child: Row(
                    children: [
                      SizedBox(width: 23),
                      Expanded(
                        child: Text(
                          "Languange",
                          style: Styles.boldLabel(AppTheme.dark),
                        ),
                      ),
                      Icon(
                        Icons.arrow_forward_ios,
                        color: AppTheme.dark,
                        size: 18,
                      ),
                      SizedBox(width: 16),
                    ],
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(
                    top: 20,
                    bottom: 30,
                  ),
                  decoration: BoxDecoration(
                    color: AppTheme.white,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  height: 56,
                  child: Row(
                    children: [
                      SizedBox(width: 23),
                      Expanded(
                        child: Text(
                          "Liked Post",
                          style: Styles.boldLabel(AppTheme.dark),
                        ),
                      ),
                      Icon(
                        Icons.arrow_forward_ios,
                        color: AppTheme.dark,
                        size: 18,
                      ),
                      SizedBox(width: 16),
                    ],
                  ),
                ),
                Text(
                  "Preferences",
                  style: Styles.boldH4(AppTheme.dark),
                ),
                Container(
                  margin: EdgeInsets.only(
                    top: 25,
                  ),
                  decoration: BoxDecoration(
                    color: AppTheme.white,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  height: 56,
                  child: Row(
                    children: [
                      SizedBox(width: 23),
                      Expanded(
                        child: Text(
                          "Notification",
                          style: Styles.boldLabel(AppTheme.dark),
                        ),
                      ),
                      CupertinoSwitch(
                        activeColor: AppTheme.primary,
                        trackColor: AppTheme.grey40,
                        value: _notification,
                        onChanged: (bool value) {
                          setState(() {
                            _notification = value;
                          });
                        },
                      ),
                      SizedBox(width: 16),
                    ],
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(
                    top: 25,
                    bottom: 30,
                  ),
                  decoration: BoxDecoration(
                    color: AppTheme.white,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  height: 56,
                  child: Row(
                    children: [
                      SizedBox(width: 23),
                      Expanded(
                        child: Text(
                          "Actions",
                          style: Styles.boldLabel(AppTheme.dark),
                        ),
                      ),
                      Icon(
                        Icons.arrow_forward_ios,
                        color: AppTheme.dark,
                        size: 18,
                      ),
                      SizedBox(width: 16),
                    ],
                  ),
                ),
                Text(
                  "Security",
                  style: Styles.boldH4(AppTheme.dark),
                ),
                Container(
                  margin: EdgeInsets.only(
                    top: 25,
                  ),
                  decoration: BoxDecoration(
                    color: AppTheme.white,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  height: 56,
                  child: Row(
                    children: [
                      SizedBox(width: 23),
                      Expanded(
                        child: Text(
                          "Private Account",
                          style: Styles.boldLabel(AppTheme.dark),
                        ),
                      ),
                      CupertinoSwitch(
                        activeColor: AppTheme.primary,
                        trackColor: AppTheme.grey40,
                        value: _privateAccount,
                        onChanged: (bool value) {
                          setState(() {
                            _privateAccount = value;
                          });
                        },
                      ),
                      SizedBox(width: 16),
                    ],
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
