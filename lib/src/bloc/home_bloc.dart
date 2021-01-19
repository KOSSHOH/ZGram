import 'dart:async';

import 'package:messenger/src/model/home/home_model.dart';
import 'package:messenger/src/model/home/story_model.dart';
import 'package:messenger/src/model/home/tape_model.dart';
import 'package:messenger/src/utils/repository.dart';
import 'package:rxdart/rxdart.dart';

class HomeBloc {
  final _repository = Repository();

  final _homeFetcher = PublishSubject<HomeModel>();

  Observable<HomeModel> get allHome => _homeFetcher.stream;

  fetchAllHome() async {
    for (int i = 0; i < tape.length; i++) {
      tape[i].comments = await _repository.databaseItemTape(tape[i].id);
    }
    Timer(Duration(seconds: 1), () {
      _homeFetcher.sink.add(HomeModel(
        story: story,
        tape: tape,
      ));
    });
  }

  fetchUpdateComment() async {
    for (int i = 0; i < tape.length; i++) {
      tape[i].comments = await _repository.databaseItemTape(tape[i].id);
    }
    _homeFetcher.sink.add(HomeModel(
      story: story,
      tape: tape,
    ));
  }

  fetchUpdateFav(int index, bool fav) async {
    for (int i = 0; i < tape.length; i++) {
      tape[i].comments = await _repository.databaseItemTape(tape[i].id);
    }
    tape[index].isFavourite = fav;
    if (fav) {
      tape[index].count = tape[index].count + 1;
    } else {
      tape[index].count = tape[index].count - 1;
    }
    _homeFetcher.sink.add(HomeModel(
      story: story,
      tape: tape,
    ));
  }

  dispose() {
    _homeFetcher.close();
  }

  List<TapeModel> tape = [
    TapeModel(
      id: 0,
      userImage: "assets/images/james_person.png",
      userName: "James Person",
      message:
          "My last day for this year holiday! So excited to share my memories with you guys! 😁😍",
      image: "assets/images/holiday.jpg",
      count: 1556,
      isFavourite: false,
      time: "2 Hours ago",
    ),
    TapeModel(
      id: 1,
      userImage: "assets/images/alan_walker.png",
      userName: "Alan Walker",
      message:
          "Christmas is a special time. It’s time for miracles and for dreams to come true. There is a wise saying that during the Christmas night all angels come down from heaven to earth, but nobody sees them as everyone hurries home. At night when people sleep these little cute creatures enter the houses and leave some gifts under the Christmas tree.",
      image: "assets/images/christmas.jpg",
      count: 25958,
      isFavourite: false,
      time: "5 Hours ago",
    ),
    TapeModel(
      id: 2,
      userImage: "assets/images/anna_jamil.png",
      userName: "Anna Jamil",
      message:
          "Travelling by ship is also very popular now. It is very pleasant to feel the deck of the ship under the feet, to see the rise and fall of the waves, to feel the fresh sea wind blowing in the face and hear the cry of the seagulls.",
      image: "assets/images/travel.jpg",
      count: 8558,
      isFavourite: false,
      time: "6 Hours ago",
    ),
  ];

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
}

HomeBloc homeBloc = HomeBloc();
