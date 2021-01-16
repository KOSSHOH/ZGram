import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:flutter_svg/svg.dart';
import 'package:messenger/src/app_theme.dart';
import 'package:messenger/src/bloc/explore_bloc.dart';
import 'package:messenger/src/model/explore_model.dart';
import 'package:messenger/src/utils/styles.dart';

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

  @override
  void initState() {
    exploreBloc.fetchAllExplore();
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
                        "Explore",
                        style: Styles.boldH1(AppTheme.dark),
                      ),
                    ),
                    GestureDetector(
                      onTap: () {},
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
                          child: Image.asset(snapshot.data[index].image,fit: BoxFit.fitWidth,),
                        );
                      },
                      staggeredTileBuilder: (int index) =>
                      new StaggeredTile.fit(2),
                      mainAxisSpacing: 25.0,
                      crossAxisSpacing: 25.0,
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
