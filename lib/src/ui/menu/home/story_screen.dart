import 'dart:async';
import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:messenger/src/app_theme.dart';
import 'package:messenger/src/model/home/story_model.dart';
import 'package:messenger/src/utils/styles.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';

class StoryScreen extends StatefulWidget {
  final int index;

  StoryScreen({
    this.index,
  });

  @override
  State<StatefulWidget> createState() {
    return _StoryScreenState();
  }
}

class _StoryScreenState extends State<StoryScreen> {
  PageController _pageController;
  int currentIndex = 0;
  double width = 0.0;

  Timer timer;

  @override
  void initState() {
    _pageController = PageController(initialPage: widget.index);
    currentIndex = widget.index;
    _newScreen();
    super.initState();
  }

  @override
  void dispose() {
    _pageController.dispose();
    timer.cancel();
    super.dispose();
  }

  var _duration = Duration(seconds: 5);

  void _newScreen() {
    if (timer == null) {
      timer = Timer(_duration, () {
        currentIndex++;
        if (currentIndex == story.length) {
          Navigator.pop(context);
        } else {
          _pageController.animateToPage(
            currentIndex,
            duration: Duration(milliseconds: 100),
            curve: Curves.easeInOut,
          );
        }
      });
    } else {
      timer.cancel();
      timer = Timer(_duration, () {
        currentIndex++;
        if (currentIndex == story.length) {
          Navigator.pop(context);
        } else {
          _pageController.animateToPage(
            currentIndex,
            duration: Duration(milliseconds: 100),
            curve: Curves.easeInOut,
          );
        }
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.screen,
      body: Theme(
        data: ThemeData(
          accentColor: Color(0xFF327FEB),
          canvasColor: Colors.transparent,
          textTheme: AppTheme.textTheme,
          platform: TargetPlatform.android,
        ),
        child: PageView(
          onPageChanged: (int page) {
            setState(() {
              currentIndex = page;
              _newScreen();
            });
          },
          controller: _pageController,
          children: story.map(
            (e) {
              return Container(
                height: MediaQuery.of(context).size.height,
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage(e.storyImage),
                    fit: BoxFit.cover,
                  ),
                ),
                child: Column(
                  children: [
                    Container(
                      margin: EdgeInsets.only(top: 30, left: 20),
                      child: LinearPercentIndicator(
                        width: MediaQuery.of(context).size.width - 50,
                        animation: true,
                        lineHeight: 6.0,
                        animationDuration: 5000,
                        percent: 1,
                        linearStrokeCap: LinearStrokeCap.roundAll,
                        progressColor: Colors.white,
                        backgroundColor: AppTheme.grey40,
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.only(
                        top: 30,
                        left: 25,
                        right: 25,
                      ),
                      child: Row(
                        children: [
                          Container(
                            height: 52,
                            width: 52,
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(52.0),
                              child: Image.asset(
                                e.image,
                                height: 52,
                                width: 52,
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                          SizedBox(width: 16),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  e.name,
                                  style: Styles.boldLabel(AppTheme.white),
                                ),
                                SizedBox(height: 2),
                                Text(
                                  "@" +
                                      e.name.toLowerCase().replaceAll(" ", ""),
                                  style: Styles.regularContent(AppTheme.white),
                                )
                              ],
                            ),
                          )
                        ],
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.only(
                        left: 25,
                        right: 25,
                        top: 75,
                      ),
                      child: Text(
                        e.storyMessage == null ? "" : e.storyMessage,
                        style: Styles.boldH2(AppTheme.white),
                      ),
                    ),
                    Expanded(child: Container()),
                    Container(
                      padding: EdgeInsets.only(
                        top: 20,
                        left: 25,
                        right: 25,
                        bottom: 48,
                      ),
                      child: Container(
                        padding: EdgeInsets.only(
                          top: 13,
                          bottom: 13,
                          right: 20,
                          left: 20,
                        ),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(26),
                          border: Border.all(
                            color: AppTheme.white,
                            width: 2,
                          ),
                        ),
                        child: Row(
                          children: [
                            Expanded(
                              child: TextField(
                                style: Styles.semiBoldContent(AppTheme.dark),
                                decoration: InputDecoration.collapsed(
                                  hintText: "Reply Diane Richards story ...",
                                  hintStyle:
                                      Styles.regularContent(AppTheme.white),
                                ),
                              ),
                            ),
                            SizedBox(width: 15),
                            GestureDetector(
                              onTap: () {},
                              child:
                                  SvgPicture.asset("assets/icon/send_white.svg"),
                            )
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              );
            },
          ).toList(),
        ),
      ),
    );
  }

  List<StoryModel> story = [
    StoryModel(
      isNew: true,
      image: "assets/images/messi.png",
      name: "Lionel Messi",
      storyImage: "assets/images/img.png",
      storyMessage: "Yummy! Let’s eat with me!",
    ),
    StoryModel(
      isNew: true,
      image: "assets/images/anna_jamil.png",
      name: "Anna Jamil",
      storyImage: "assets/images/christmas.jpg",
      storyMessage: "Yummy!\nLet’s eat with me!",
    ),
    StoryModel(
      isNew: true,
      image: "assets/images/alan_walker.png",
      name: "Alan Walker",
      storyImage: "assets/images/holiday.jpg",
    ),
    StoryModel(
      isNew: true,
      image: "assets/images/thor.png",
      name: "Thor",
      storyImage: "assets/images/img.png",
    ),
    StoryModel(
      isNew: true,
      image: "assets/images/james_person.png",
      name: "James Person",
      storyImage: "assets/images/img.png",
    ),
  ];
}
