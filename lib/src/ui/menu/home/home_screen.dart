import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:messenger/src/app_theme.dart';
import 'package:messenger/src/bloc/home_bloc.dart';
import 'package:messenger/src/model/home/home_model.dart';
import 'package:messenger/src/ui/menu/home/notification_screen.dart';
import 'package:messenger/src/ui/menu/main_screen.dart';
import 'package:messenger/src/ui/profile/profile_friend_screen.dart';
import 'package:messenger/src/utils/styles.dart';

class HomeScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _HomeScreenState();
  }
}

class _HomeScreenState extends State<HomeScreen>
    with AutomaticKeepAliveClientMixin<HomeScreen> {
  @override
  bool get wantKeepAlive => true;

  @override
  void initState() {
    homeBloc.fetchAllHome();
    super.initState();
  }

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
                    Expanded(
                      child: Text(
                        "Home",
                        style: Styles.boldH1(AppTheme.dark),
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => NotificationScreen(),
                          ),
                        );
                      },
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
                accentColor: Color(0xFF327FEB),
                canvasColor: Colors.transparent,
                textTheme: AppTheme.textTheme,
                platform: TargetPlatform.iOS,
              ),
              child: StreamBuilder(
                stream: homeBloc.allHome,
                builder: (context, AsyncSnapshot<HomeModel> snapshot) {
                  if (snapshot.hasData) {
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
                        ),
                        ListView.builder(
                          shrinkWrap: true,
                          physics: NeverScrollableScrollPhysics(),
                          itemCount: snapshot.data.tape.length,
                          padding: EdgeInsets.only(
                            top: 0,
                            bottom: 24,
                          ),
                          itemBuilder: (BuildContext ctxt, int index) {
                            return GestureDetector(
                              onDoubleTap: () {
                                homeBloc.fetchUpdateFav(
                                  index,
                                  !snapshot.data.tape[index].isFavourite,
                                );
                              },
                              child: Container(
                                margin: EdgeInsets.only(
                                  top: 30,
                                  left: 25,
                                  right: 25,
                                ),
                                decoration: BoxDecoration(
                                  color: AppTheme.white,
                                  borderRadius: BorderRadius.circular(
                                    15,
                                  ),
                                ),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    Container(
                                      child: Row(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          GestureDetector(
                                            onTap: () {
                                              Navigator.push(
                                                context,
                                                MaterialPageRoute(
                                                  builder: (context) =>
                                                      FriendProfileScreen(
                                                          snapshot.data
                                                              .tape[index]),
                                                ),
                                              );
                                            },
                                            child: Container(
                                              height: 42,
                                              width: 42,
                                              margin: EdgeInsets.only(
                                                right: 19.0,
                                              ),
                                              child: ClipRRect(
                                                borderRadius: BorderRadius.all(
                                                  Radius.circular(42),
                                                ),
                                                child: Image.asset(
                                                  snapshot.data.tape[index]
                                                      .userImage,
                                                  height: 42,
                                                  width: 42,
                                                  fit: BoxFit.cover,
                                                ),
                                              ),
                                            ),
                                          ),
                                          Expanded(
                                            child: GestureDetector(
                                              onTap: () {
                                                Navigator.push(
                                                  context,
                                                  MaterialPageRoute(
                                                    builder: (context) =>
                                                        FriendProfileScreen(
                                                            snapshot.data
                                                                .tape[index]),
                                                  ),
                                                );
                                              },
                                              child: Text(
                                                snapshot
                                                    .data.tape[index].userName,
                                                style: Styles.boldDisplay(
                                                  AppTheme.dark,
                                                ),
                                              ),
                                            ),
                                          ),
                                          GestureDetector(
                                            onTap: () {},
                                            child: SvgPicture.asset(
                                              "assets/icon/more-vertical.svg",
                                            ),
                                          )
                                        ],
                                      ),
                                      margin: EdgeInsets.only(
                                        top: 17,
                                        left: 15,
                                        right: 19,
                                      ),
                                    ),
                                    Container(
                                      margin: EdgeInsets.only(
                                        top: 17,
                                        left: 20,
                                        right: 20,
                                      ),
                                      height: 1,
                                      color: AppTheme.grey20,
                                    ),
                                    Container(
                                      margin: EdgeInsets.only(
                                        top: 20,
                                        left: 15,
                                        right: 15,
                                      ),
                                      child: Text(
                                        snapshot.data.tape[index].message,
                                        style: Styles.regularContent(
                                          AppTheme.dark80,
                                        ),
                                      ),
                                    ),
                                    Container(
                                      width: MediaQuery.of(context).size.width -
                                          80,
                                      child: ClipRRect(
                                        borderRadius: BorderRadius.all(
                                          Radius.circular(10),
                                        ),
                                        child: Image.asset(
                                          snapshot.data.tape[index].image,
                                          width: MediaQuery.of(context)
                                                  .size
                                                  .width -
                                              80,
                                          fit: BoxFit.fitWidth,
                                        ),
                                      ),
                                      margin: EdgeInsets.only(
                                        left: 15,
                                        top: 20,
                                      ),
                                    ),
                                    Container(
                                      margin: EdgeInsets.only(
                                        left: 15,
                                        right: 15,
                                        top: 20,
                                        bottom: 20,
                                      ),
                                      child: Row(
                                        children: [
                                          GestureDetector(
                                            child: snapshot.data.tape[index]
                                                    .isFavourite
                                                ? SvgPicture.asset(
                                                    "assets/icon/favourite_active.svg",
                                                  )
                                                : SvgPicture.asset(
                                                    "assets/icon/favourite.svg",
                                                  ),
                                            onTap: () {
                                              homeBloc.fetchUpdateFav(
                                                index,
                                                !snapshot.data.tape[index]
                                                    .isFavourite,
                                              );
                                            },
                                          ),
                                          SizedBox(width: 10),
                                          Text(
                                            countFormat.format(
                                              snapshot.data.tape[index].count,
                                            ),
                                            style: Styles.semiBoldContent(
                                              AppTheme.dark80,
                                            ),
                                          ),
                                          SizedBox(width: 23),
                                          GestureDetector(
                                            onTap: () {},
                                            child: SvgPicture.asset(
                                              "assets/icon/message-circle.svg",
                                            ),
                                          ),
                                          SizedBox(width: 10),
                                          Text(
                                            countFormat.format(
                                              snapshot.data.tape[index].comments
                                                  .length,
                                            ),
                                            style: Styles.semiBoldContent(
                                              AppTheme.dark80,
                                            ),
                                          ),
                                          Expanded(child: Container()),
                                          Text(
                                            snapshot.data.tape[index].time,
                                            style: Styles.regularBody(
                                              AppTheme.grey,
                                            ),
                                          )
                                        ],
                                      ),
                                    )
                                  ],
                                ),
                              ),
                            );
                          },
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
