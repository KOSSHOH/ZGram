import 'dart:async';
import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:flutter_svg/svg.dart';
import 'package:messenger/src/app_theme.dart';
import 'package:messenger/src/bloc/explore_bloc.dart';
import 'package:messenger/src/model/explore_model.dart';
import 'package:messenger/src/utils/styles.dart';
import 'package:shimmer/shimmer.dart';

class ExploreScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _ExploreScreenState();
  }
}

class _ExploreScreenState extends State<ExploreScreen>
    with AutomaticKeepAliveClientMixin<ExploreScreen> {
  @override
  bool get wantKeepAlive => true;
  bool isSearch = false;
  bool isSearchAnim = false;
  bool isEdit = false;
  TextEditingController searchController = TextEditingController();

  @override
  void initState() {
    exploreBloc.fetchAllExplore();
    super.initState();
  }

  _ExploreScreenState() {
    searchController.addListener(() {
      if (searchController.text.length > 0) {
        setState(() {
          isEdit = true;
        });
      } else {
        setState(() {
          isEdit = false;
        });
      }
    });
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
            height: 120,
            padding: EdgeInsets.only(
              left: 25,
              right: 25,
              bottom: isSearch ? 15 : 20,
            ),
            child: Column(
              children: [
                Expanded(child: Container()),
                isSearch
                    ? Row(
                        children: [
                          AnimatedContainer(
                            duration: Duration(milliseconds: 300),
                            width: isSearchAnim
                                ? 0
                                : MediaQuery.of(context).size.width - 78,
                          ),
                          Expanded(
                            child: TextFormField(
                              controller: searchController,
                              style: Styles.semiBoldLabel(AppTheme.dark),
                              decoration: InputDecoration(
                                hintText: "Search here",
                                hintStyle: Styles.regularLabel(AppTheme.grey),
                                enabledBorder: UnderlineInputBorder(
                                  borderSide: BorderSide(
                                    color: AppTheme.grey40,
                                    width: 0.5,
                                  ),
                                ),
                                focusedBorder: UnderlineInputBorder(
                                  borderSide: BorderSide(
                                    color: AppTheme.grey40,
                                    width: 0.5,
                                  ),
                                ),
                                prefixIcon: GestureDetector(
                                  onTap: () {
                                    if (isEdit) {
                                      setState(() {
                                        searchController.text = "";
                                      });
                                    } else {
                                      setState(() {
                                        isSearchAnim = false;
                                      });

                                      Timer(Duration(milliseconds: 300), () {
                                        setState(() {
                                          setState(() {
                                            isSearch = false;
                                          });
                                        });
                                      });
                                    }
                                  },
                                  child: Container(
                                    padding: EdgeInsets.only(
                                      right: 16,
                                      bottom: 16,
                                      top: 16,
                                    ),
                                    child: isEdit
                                        ? SvgPicture.asset(
                                            "assets/icon/close.svg",
                                            width: 24,
                                            height: 24,
                                          )
                                        : SvgPicture.asset(
                                            "assets/icon/search.svg",
                                            width: 24,
                                            height: 24,
                                          ),
                                  ),
                                ),
                              ),
                            ),
                          )
                        ],
                      )
                    : Row(
                        children: [
                          Expanded(
                            child: Text(
                              "Explore",
                              style: Styles.boldH1(AppTheme.dark),
                            ),
                          ),
                          GestureDetector(
                            onTap: () {
                              setState(() {
                                isSearch = true;
                              });
                              Timer(Duration(milliseconds: 10), () {
                                setState(() {
                                  setState(() {
                                    isSearchAnim = true;
                                  });
                                });
                              });
                            },
                            child: SvgPicture.asset(
                              "assets/icon/search.svg",
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
                stream: exploreBloc.allExplore,
                builder: (context, AsyncSnapshot<List<ExploreModel>> snapshot) {
                  if (snapshot.hasData) {
                    return StaggeredGridView.countBuilder(
                      padding: EdgeInsets.only(
                        left: 25,
                        right: 25,
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
                    );
                  }
                  return Shimmer.fromColors(
                    baseColor: AppTheme.shimmerBase,
                    highlightColor: AppTheme.shimmerHighlight,
                    child: StaggeredGridView.countBuilder(
                      padding: EdgeInsets.only(
                        left: 25,
                        right: 25,
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
