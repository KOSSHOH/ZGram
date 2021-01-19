import 'dart:async';

import 'package:messenger/src/model/explore_model.dart';
import 'package:rxdart/rxdart.dart';

class ExploreBloc {
  final _exploreFetcher = PublishSubject<List<ExploreModel>>();

  Observable<List<ExploreModel>> get allExplore => _exploreFetcher.stream;

  fetchAllExplore() async {
    Timer(Duration(seconds: 1), () {
      _exploreFetcher.sink.add(explore);
    });
  }

  dispose() {
    _exploreFetcher.close();
  }

  List<ExploreModel> explore = [
    ExploreModel(
      id: 4,
      image: "assets/explore/4.png",
    ),
    ExploreModel(
      id: 1,
      image: "assets/explore/1.png",
    ),
    ExploreModel(
      id: 2,
      image: "assets/explore/2.png",
    ),
    ExploreModel(
      id: 3,
      image: "assets/explore/3.png",
    ),
    ExploreModel(
      id: 4,
      image: "assets/explore/4.png",
    ),
    ExploreModel(
      id: 5,
      image: "assets/explore/5.png",
    ),
    ExploreModel(
      id: 6,
      image: "assets/explore/6.png",
    ),
    ExploreModel(
      id: 7,
      image: "assets/explore/7.png",
    ),
    ExploreModel(
      id: 8,
      image: "assets/explore/8.png",
    ),
    ExploreModel(
      id: 9,
      image: "assets/explore/9.png",
    ),
    ExploreModel(
      id: 10,
      image: "assets/explore/10.png",
    ),
    ExploreModel(
      id: 11,
      image: "assets/explore/11.png",
    ),
    ExploreModel(
      id: 12,
      image: "assets/explore/12.png",
    ),
    ExploreModel(
      id: 13,
      image: "assets/explore/13.png",
    ),
    ExploreModel(
      id: 14,
      image: "assets/explore/14.png",
    ),
  ];
}

ExploreBloc exploreBloc = ExploreBloc();
