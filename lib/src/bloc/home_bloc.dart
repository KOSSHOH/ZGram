import 'dart:async';

import 'package:messenger/src/model/home/home_model.dart';
import 'package:messenger/src/model/home/story_model.dart';
import 'package:rxdart/rxdart.dart';

class HomeBloc {
  HomeModel homeModel = new HomeModel();

  final _homeFetcher = PublishSubject<HomeModel>();

  Observable<HomeModel> get allHome => _homeFetcher.stream;

  fetchAllHome() async {
    List<StoryModel> story = [
      StoryModel(
        isNew: true,
        image: "assets/images/messi.png",
        name: "Lionel Messi",
      ),
      StoryModel(
        isNew: true,
        image: "assets/images/anna_jamil.png",
        name: "Anna Jamil",
      ),
      StoryModel(
        isNew: true,
        image: "assets/images/alan_walker.png",
        name: "Alan Walker",
      ),
      StoryModel(
        isNew: true,
        image: "assets/images/thor.png",
        name: "Thor",
      ),
      StoryModel(
        isNew: true,
        image: "assets/images/james_person.png",
        name: "James Person",
      ),
    ];
    homeModel = new HomeModel(story: story);
    Timer(Duration(seconds: 1), () {
      _homeFetcher.sink.add(homeModel);
    });
  }

  dispose() {
    _homeFetcher.close();
  }
}

HomeBloc homeBloc = HomeBloc();
