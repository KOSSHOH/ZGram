import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:messenger/src/app_theme.dart';
import 'package:messenger/src/ui/auth/login_screen.dart';
import 'package:messenger/src/ui/auth/signup_screen.dart';
import 'package:messenger/src/utils/styles.dart';

class AuthScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _AuthScreenState();
  }
}

class _AuthScreenState extends State<AuthScreen> {
  PageController _pageController;
  int currentIndex = 0;

  @override
  void initState() {
    _pageController = PageController(initialPage: 0);
    super.initState();
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  var _duration = Duration(milliseconds: 300);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.screen,
      body: Column(
        children: [
          Container(
            width: double.infinity,
            margin: EdgeInsets.only(
              top: 64,
            ),
            child: Center(
              child: Image.asset(
                "assets/images/logo.png",
              ),
            ),
          ),
          Container(
            margin: EdgeInsets.only(
              top: 40,
              left: 28,
              right: 28,
              bottom: 11,
            ),
            child: Row(
              children: [
                GestureDetector(
                  onTap: () {
                    if (currentIndex != 0) {
                      setState(() {
                        currentIndex = 0;
                        _pageController.animateToPage(
                          0,
                          duration: _duration,
                          curve: Curves.easeInOut,
                        );
                      });
                    }
                  },
                  child: Column(
                    children: [
                      Text(
                        "Log In",
                        style: currentIndex == 0
                            ? Styles.boldH3(AppTheme.dark)
                            : Styles.boldH3(AppTheme.grey),
                      ),
                      AnimatedContainer(
                        margin: EdgeInsets.only(top: 4),
                        duration: _duration,
                        curve: Curves.easeInOut,
                        height: 6,
                        width: 6,
                        decoration: BoxDecoration(
                            color: currentIndex == 0
                                ? AppTheme.primary
                                : AppTheme.white,
                            borderRadius: BorderRadius.circular(6)),
                      )
                    ],
                  ),
                ),
                SizedBox(width: 44),
                GestureDetector(
                  onTap: () {
                    if (currentIndex != 1) {
                      setState(() {
                        currentIndex = 1;
                        _pageController.animateToPage(
                          1,
                          duration: _duration,
                          curve: Curves.easeInOut,
                        );
                      });
                    }
                  },
                  child: Column(
                    children: [
                      Text(
                        "Sign Up",
                        style: currentIndex == 1
                            ? Styles.boldH3(AppTheme.dark)
                            : Styles.boldH3(AppTheme.grey),
                      ),
                      AnimatedContainer(
                        margin: EdgeInsets.only(top: 4),
                        duration: _duration,
                        curve: Curves.easeInOut,
                        height: 6,
                        width: 6,
                        decoration: BoxDecoration(
                            color: currentIndex == 1
                                ? AppTheme.primary
                                : AppTheme.white,
                            borderRadius: BorderRadius.circular(6)),
                      )
                    ],
                  ),
                )
              ],
            ),
          ),
          Expanded(
            child: PageView(
              onPageChanged: (int page) {
                setState(() {
                  currentIndex = page;
                });
              },
              controller: _pageController,
              children: <Widget>[
                LoginScreen(),
                SignupScreen(),
              ],
            ),
          )
        ],
      ),
    );
  }
}
