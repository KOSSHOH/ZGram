import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:flutter_svg/svg.dart';
import 'package:messenger/src/app_theme.dart';
import 'package:messenger/src/bloc/profile_bloc.dart';
import 'package:messenger/src/model/explore_model.dart';
import 'package:messenger/src/model/home/tape_model.dart';
import 'package:messenger/src/ui/menu/chat/chat_item_screen.dart';
import 'package:messenger/src/utils/styles.dart';
import 'package:shimmer/shimmer.dart';

class FriendProfileScreen extends StatefulWidget {
  final TapeModel tapeModel;

  FriendProfileScreen(this.tapeModel);

  @override
  State<StatefulWidget> createState() {
    return _FriendProfileScreenState();
  }
}

class _FriendProfileScreenState extends State<FriendProfileScreen> {
  bool isFollow = false;

  @override
  void initState() {
    profileBloc.fetchAllProfileFried();
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
                        "Profile",
                        style: Styles.boldH1(AppTheme.dark),
                      ),
                    ),
                    GestureDetector(
                      onTap: () {},
                      child: SvgPicture.asset(
                        "assets/icon/settings.svg",
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
                stream: profileBloc.allProfileFriend,
                builder: (context, AsyncSnapshot<List<ExploreModel>> snapshot) {
                  if (snapshot.hasData) {
                    return ListView(
                      padding: EdgeInsets.only(
                        top: 0,
                        left: 25,
                        right: 25,
                      ),
                      children: [
                        Container(
                          margin: EdgeInsets.only(
                            top: 35,
                          ),
                          height: 86,
                          child: Row(
                            children: [
                              Container(
                                height: 86,
                                width: 86,
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(52.0),
                                  child: Image.asset(
                                    widget.tapeModel.userImage,
                                    height: 86,
                                    width: 86,
                                    fit: BoxFit.cover,
                                  ),
                                ),
                              ),
                              SizedBox(width: 25),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      widget.tapeModel.userName,
                                      maxLines: 1,
                                      overflow: TextOverflow.ellipsis,
                                      style: Styles.boldH3(AppTheme.dark),
                                    ),
                                    Text(
                                      "@" +
                                          widget.tapeModel.userName
                                              .replaceAll(" ", "")
                                              .toLowerCase(),
                                      maxLines: 1,
                                      overflow: TextOverflow.ellipsis,
                                      style:
                                          Styles.semiBoldLabel(AppTheme.dark80),
                                    ),
                                    SizedBox(height: 1),
                                    Text(
                                      "Tashkent, Uzbekistan",
                                      maxLines: 1,
                                      overflow: TextOverflow.ellipsis,
                                      style: Styles.regularContent(
                                          AppTheme.dark60),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                        Container(
                          margin: EdgeInsets.only(
                            top: 25,
                          ),
                          child: Row(
                            children: [
                              GestureDetector(
                                child: Container(
                                  height: 56,
                                  width: 92,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(28.5),
                                    color: AppTheme.screen,
                                    border: Border.all(
                                      color: AppTheme.primary,
                                      width: 2,
                                    ),
                                  ),
                                  child: Center(
                                    child: SvgPicture.asset(
                                      "assets/icon/message-circle.svg",
                                    ),
                                  ),
                                  margin: EdgeInsets.only(
                                    right: 25,
                                  ),
                                ),
                                onTap: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => ChatItemScreen(
                                        image: widget.tapeModel.userImage,
                                        name: widget.tapeModel.userName,
                                      ),
                                    ),
                                  );
                                },
                              ),
                              Expanded(
                                child: GestureDetector(
                                  onTap: () {
                                    setState(() {
                                      isFollow = !isFollow;
                                    });
                                  },
                                  child: AnimatedContainer(
                                    duration: Duration(
                                      milliseconds: 300,
                                    ),
                                    height: 56,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(28.5),
                                      color: isFollow
                                          ? AppTheme.white
                                          : AppTheme.primary,
                                      border: Border.all(
                                        color: AppTheme.primary,
                                        width: 2,
                                      ),
                                    ),
                                    child: Center(
                                      child: Text(
                                        isFollow ? "Following" : "Follow",
                                        style: Styles.boldButton(
                                          isFollow
                                              ? AppTheme.dark
                                              : AppTheme.white,
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        Container(
                          margin: EdgeInsets.only(top: 25),
                          child: Row(
                            children: [
                              Expanded(
                                child: Column(
                                  children: [
                                    Text(
                                      "971",
                                      style: Styles.boldH3(AppTheme.dark),
                                    ),
                                    SizedBox(height: 4),
                                    Text(
                                      "Likes",
                                      style: Styles.regularContent(
                                          AppTheme.dark80),
                                    ),
                                  ],
                                ),
                              ),
                              Expanded(
                                child: Column(
                                  children: [
                                    Text(
                                      "2669",
                                      style: Styles.boldH3(AppTheme.dark),
                                    ),
                                    SizedBox(height: 4),
                                    Text(
                                      "Followers",
                                      style: Styles.regularContent(
                                          AppTheme.dark80),
                                    ),
                                  ],
                                ),
                              ),
                              Expanded(
                                child: Column(
                                  children: [
                                    Text(
                                      "9645",
                                      style: Styles.boldH3(AppTheme.dark),
                                    ),
                                    SizedBox(height: 4),
                                    Text(
                                      "Following",
                                      style: Styles.regularContent(
                                          AppTheme.dark80),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                          padding: EdgeInsets.only(top: 18, bottom: 18),
                          decoration: BoxDecoration(
                            color: AppTheme.white,
                            borderRadius: BorderRadius.circular(
                              10,
                            ),
                          ),
                        ),
                        StaggeredGridView.countBuilder(
                          padding: EdgeInsets.only(
                            top: 25,
                            bottom: 40,
                          ),
                          crossAxisCount: 4,
                          itemCount: snapshot.data.length,
                          itemBuilder: (BuildContext context, int index) {
                            return Container(
                              child: Image.asset(
                                snapshot.data[index].image,
                                fit: BoxFit.fitWidth,
                              ),
                            );
                          },
                          staggeredTileBuilder: (int index) =>
                              new StaggeredTile.fit(2),
                          mainAxisSpacing: 25.0,
                          crossAxisSpacing: 25.0,
                          shrinkWrap: true,
                          physics: NeverScrollableScrollPhysics(),
                        ),
                      ],
                    );
                  }
                  return Shimmer.fromColors(
                    baseColor: AppTheme.shimmerBase,
                    highlightColor: AppTheme.shimmerHighlight,
                    child: ListView(
                      padding: EdgeInsets.only(
                        top: 0,
                        left: 25,
                        right: 25,
                      ),
                      children: [
                        Container(
                          margin: EdgeInsets.only(
                            top: 35,
                          ),
                          height: 86,
                          child: Row(
                            children: [
                              Container(
                                height: 86,
                                width: 86,
                                decoration: BoxDecoration(
                                  color: AppTheme.white,
                                  borderRadius: BorderRadius.circular(52.0),
                                ),
                              ),
                              SizedBox(width: 25),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Container(
                                      height: 25,
                                      decoration: BoxDecoration(
                                          color: AppTheme.white,
                                          borderRadius:
                                              BorderRadius.circular(9)),
                                    ),
                                    Container(
                                      margin: EdgeInsets.only(
                                        top: 12,
                                        right: 75,
                                      ),
                                      height: 18,
                                      decoration: BoxDecoration(
                                        color: AppTheme.white,
                                        borderRadius: BorderRadius.circular(9),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                        Container(
                          margin: EdgeInsets.only(
                            top: 25,
                          ),
                          child: Row(
                            children: [
                              Container(
                                height: 56,
                                width: 92,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(28.5),
                                  color: AppTheme.screen,
                                  border: Border.all(
                                    color: AppTheme.primary,
                                    width: 2,
                                  ),
                                ),
                                margin: EdgeInsets.only(
                                  right: 25,
                                ),
                              ),
                              Expanded(
                                child: Container(
                                  height: 56,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(28.5),
                                    color: isFollow
                                        ? AppTheme.white
                                        : AppTheme.primary,
                                    border: Border.all(
                                      color: AppTheme.primary,
                                      width: 2,
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        Container(
                          margin: EdgeInsets.only(top: 25),
                          padding: EdgeInsets.only(top: 18, bottom: 18),
                          decoration: BoxDecoration(
                            color: AppTheme.white,
                            borderRadius: BorderRadius.circular(
                              10,
                            ),
                          ),
                          height: 92,
                        ),
                        StaggeredGridView.countBuilder(
                          shrinkWrap: true,
                          physics: NeverScrollableScrollPhysics(),
                          padding: EdgeInsets.only(
                            top: 25,
                            bottom: 40,
                          ),
                          crossAxisCount: 4,
                          itemCount: 25,
                          itemBuilder: (BuildContext context, int index) {
                            Random random = new Random();
                            return Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                color: AppTheme.white,
                              ),
                              height: (random.nextInt(70) + 150).toDouble(),
                            );
                          },
                          staggeredTileBuilder: (int index) =>
                              new StaggeredTile.fit(2),
                          mainAxisSpacing: 25.0,
                          crossAxisSpacing: 25.0,
                        )
                      ],
                    ),
                  );
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}
