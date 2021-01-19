import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:flutter_svg/svg.dart';
import 'package:messenger/src/app_theme.dart';
import 'package:messenger/src/bloc/profile_bloc.dart';
import 'package:messenger/src/ui/menu/profile/setting_screen.dart';
import 'package:messenger/src/utils/styles.dart';

import 'dart:io' as Io;

class ProfileScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _ProfileScreenState();
  }
}

class _ProfileScreenState extends State<ProfileScreen>
    with AutomaticKeepAliveClientMixin<ProfileScreen> {
  @override
  bool get wantKeepAlive => true;

  @override
  void initState() {
    profileBloc.fetchAllProfile();
    super.initState();
  }

  @override
  // ignore: must_call_super
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
                        "Profile",
                        style: Styles.boldH1(AppTheme.dark),
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => SettingScreen(),
                          ),
                        );
                      },
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
                stream: profileBloc.allProfile,
                builder: (context, AsyncSnapshot<List<String>> snapshot) {
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
                                child: Stack(
                                  children: [
                                    ClipRRect(
                                      borderRadius: BorderRadius.circular(52.0),
                                      child: Image.asset(
                                        "assets/images/messi.png",
                                        height: 86,
                                        width: 86,
                                        fit: BoxFit.cover,
                                      ),
                                    ),
                                    Align(
                                      alignment: Alignment.bottomRight,
                                      child: Container(
                                        height: 36,
                                        width: 36,
                                        padding: EdgeInsets.all(2),
                                        decoration: BoxDecoration(
                                          color: AppTheme.screen,
                                          borderRadius: BorderRadius.circular(
                                            36.0,
                                          ),
                                        ),
                                        child: Container(
                                          padding: EdgeInsets.all(5),
                                          decoration: BoxDecoration(
                                            color: AppTheme.primary,
                                            borderRadius: BorderRadius.circular(
                                              36.0,
                                            ),
                                          ),
                                          child: Center(
                                            child: SvgPicture.asset(
                                              "assets/icon/camera.svg",
                                            ),
                                          ),
                                        ),
                                      ),
                                    )
                                  ],
                                ),
                              ),
                              SizedBox(width: 25),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      "Shahboz Turonov",
                                      maxLines: 1,
                                      overflow: TextOverflow.ellipsis,
                                      style: Styles.boldH3(AppTheme.dark),
                                    ),
                                    Text(
                                      "@shahbozturonov",
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
                          margin: EdgeInsets.only(top: 35),
                          child: Row(
                            children: [
                              Expanded(
                                child: Column(
                                  children: [
                                    Text(
                                      "890",
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
                                      "1293",
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
                                      "1436",
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
                            return showImage(snapshot.data[index]);
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
                  return Container();
                },
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget showImage(String image) {
    var file = Io.File(image);
    return ClipRRect(
      borderRadius: BorderRadius.circular(10.0),
      child: Image.file(
        file,
        fit: BoxFit.fitWidth,
      ),
    );
  }
}
