import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:messenger/src/app_theme.dart';
import 'package:messenger/src/bloc/home_bloc.dart';
import 'package:messenger/src/model/home/home_model.dart';
import 'package:messenger/src/utils/styles.dart';

class HomeScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _HomeScreenState();
  }
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {
    homeBloc.fetchAllHome();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    homeBloc.fetchAllHome();
    return Scaffold(
      backgroundColor: AppTheme.screen,
      body: Column(
        children: [
          Container(
            color: AppTheme.white,
            height: 120,
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
                    Expanded(
                      child: Text(
                        "Home",
                        style: Styles.boldH1(AppTheme.dark),
                      ),
                    ),
                    GestureDetector(
                      onTap: () {},
                      child: SvgPicture.asset(
                        "assets/icon/inactive.svg",
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          Expanded(
            child: Theme(
              data: ThemeData(
                platform: TargetPlatform.iOS,
              ),
              child: StreamBuilder(
                stream: homeBloc.allHome,
                builder: (context, AsyncSnapshot<HomeModel> snapshot) {
                  if (snapshot.hasData) {
                    print("SSSSSS" + snapshot.data.story.length.toString());
                    return ListView(
                      padding: EdgeInsets.only(
                        top: 0,
                        bottom: 24,
                      ),
                      children: [
                        Container(
                          margin: EdgeInsets.only(
                            top: 25,
                          ),
                          color: AppTheme.screen,
                          height: 92,
                          child: ListView.builder(
                            itemCount: snapshot.data.story.length + 1,
                            scrollDirection: Axis.horizontal,
                            padding: EdgeInsets.only(left: 25),
                            itemBuilder: (context, index) {
                              return index == 0
                                  ? GestureDetector(
                                      child: Container(
                                        margin: EdgeInsets.only(
                                          right: 16,
                                        ),
                                        width: 57,
                                        child: Column(
                                          children: [
                                            DottedBorder(
                                              borderType: BorderType.RRect,
                                              radius: Radius.circular(9),
                                              strokeWidth: 3,
                                              dashPattern: [15, 5],
                                              color: AppTheme.primary,
                                              child: ClipRRect(
                                                borderRadius: BorderRadius.all(
                                                  Radius.circular(9),
                                                ),
                                                child: Container(
                                                  height: 57,
                                                  width: 57,
                                                  color: AppTheme.screen,
                                                  child: Center(
                                                    child: SvgPicture.asset(
                                                      "assets/icon/plus.svg",
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            ),
                                            SizedBox(height: 6),
                                            Text(
                                              "Add Story",
                                              maxLines: 1,
                                              style: Styles.regularBody(
                                                  AppTheme.dark),
                                            ),
                                          ],
                                        ),
                                      ),
                                    )
                                  : GestureDetector(
                                      child: Container(
                                        margin: EdgeInsets.only(
                                          left: 8,
                                          right: 8,
                                        ),
                                        width: 73,
                                        child: Column(
                                          children: [
                                            Container(
                                              height: 63,
                                              width: 63,
                                              decoration: BoxDecoration(
                                                borderRadius:
                                                    BorderRadius.circular(9),
                                                border: Border.all(
                                                  color: AppTheme.primary,
                                                  width: 3,
                                                ),
                                              ),
                                              child: ClipRRect(
                                                borderRadius:
                                                    BorderRadius.circular(6.0),
                                                child: Image.asset(
                                                  snapshot.data.story[index - 1]
                                                      .image,
                                                  height: 63,
                                                  width: 63,
                                                  fit: BoxFit.cover,
                                                ),
                                              ),
                                            ),
                                            SizedBox(height: 5),
                                            Text(
                                              snapshot
                                                  .data.story[index - 1].name,
                                              maxLines: 1,
                                              overflow: TextOverflow.ellipsis,
                                              style: Styles.regularBody(
                                                  AppTheme.dark),
                                            ),
                                          ],
                                        ),
                                      ),
                                    );
                            },
                          ),
                        )
                      ],
                    );
                  }
                  return Container();
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}
