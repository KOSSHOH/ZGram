import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:messenger/src/app_theme.dart';
import 'package:messenger/src/ui/auth/auth_screen.dart';
import 'package:messenger/src/utils/styles.dart';

class OnBoarding extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _OnBoardingState();
  }
}

class _OnBoardingState extends State<OnBoarding> {
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.screen,
      body: Column(
        children: <Widget>[
          Expanded(
            child: PageView(
              onPageChanged: (int page) {
                setState(() {
                  currentIndex = page;
                });
              },
              controller: _pageController,
              children: <Widget>[
                makePage(
                  image: 'assets/images/step-one.png',
                  title: "We Connect People",
                  content:
                      "Connecting people trough one platform to share the memories together.",
                  index: 0,
                ),
                makePage(
                  image: 'assets/images/step-two.png',
                  title: "Sharing Happiness",
                  content:
                      "Sharing happiness by sharing your memories in Zelio platform.",
                  index: 1,
                ),
                makePage(
                  image: 'assets/images/step-three.png',
                  title: "Last Long Memories",
                  content:
                      "You can store memories of your photos in Zelio app without limit.",
                  index: 2,
                ),
              ],
            ),
          ),
          Container(
            margin: EdgeInsets.only(
              bottom: 44,
              left: 25,
              right: 25,
            ),
            child: Row(
              children: [
                Row(
                  children: _buildIndicator(),
                ),
                Expanded(child: Container()),
                GestureDetector(
                  onTap: () {
                    if (currentIndex == 0) {
                      setState(() {
                        currentIndex = 1;
                        _pageController.animateToPage(
                          1,
                          duration: Duration(milliseconds: 300),
                          curve: Curves.easeInOut,
                        );
                        // _pageController.jumpToPage(1);
                      });
                    } else if (currentIndex == 1) {
                      setState(() {
                        currentIndex = 2;
                        _pageController.animateToPage(
                          2,
                          duration: Duration(milliseconds: 300),
                          curve: Curves.easeInOut,
                        );
                        //_pageController.jumpToPage(2);
                      });
                    } else if (currentIndex == 2) {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => AuthScreen(),
                        ),
                      );
                    }
                  },
                  child: AnimatedContainer(
                    curve: Curves.easeInOut,
                    decoration: BoxDecoration(
                      color: AppTheme.primary,
                      borderRadius: BorderRadius.circular(28),
                    ),
                    duration: Duration(milliseconds: 300),
                    height: 56,
                    width: currentIndex == 2 ? 150 : 124,
                    child: Center(
                      child: Text(
                        currentIndex == 2 ? "Get Started" : "Next",
                        style: Styles.boldButton(AppTheme.white),
                      ),
                    ),
                  ),
                )
              ],
            ),
          )
        ],
      ),
    );
  }

  Widget makePage({image, title, content, index}) {
    return Column(
      children: <Widget>[
        Container(
          margin: EdgeInsets.only(
            top: 88,
            left: index == 0 ? 25 : 0.0,
            right: index == 2 ? 25 : 0.0,
          ),
          color: AppTheme.white,
          child: ClipRRect(
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(
                index == 0 ? 50 : 0.0,
              ),
              bottomLeft: Radius.circular(
                index == 0 ? 50 : 0.0,
              ),
              topRight: Radius.circular(
                index == 2 ? 50 : 0.0,
              ),
              bottomRight: Radius.circular(
                index == 2 ? 50 : 0.0,
              ),
            ),
            child: Image.asset(
              image,
              fit: BoxFit.cover,
              height: MediaQuery.of(context).size.width,
              width: MediaQuery.of(context).size.width,
            ),
          ),
        ),
        SizedBox(
          height: 53,
        ),
        Text(
          title,
          style: Styles.boldH2(AppTheme.dark),
        ),
        Container(
          child: Text(
            content,
            textAlign: TextAlign.center,
            style: Styles.regularLabel(AppTheme.dark80),
          ),
          margin: EdgeInsets.only(
            top: 18,
            left: 25,
            right: 25,
          ),
        ),
      ],
    );
  }

  Widget _indicator(bool isActive) {
    return AnimatedContainer(
      curve: Curves.easeInOut,
      duration: Duration(milliseconds: 300),
      height: 9,
      width: isActive ? 28 : 9,
      margin: EdgeInsets.only(right: 15),
      decoration: BoxDecoration(
        color: isActive ? AppTheme.primary : AppTheme.grey40,
        borderRadius: BorderRadius.circular(5),
      ),
    );
  }

  List<Widget> _buildIndicator() {
    List<Widget> indicators = [];
    for (int i = 0; i < 3; i++) {
      if (currentIndex == i) {
        indicators.add(_indicator(true));
      } else {
        indicators.add(_indicator(false));
      }
    }

    return indicators;
  }
}
