import 'dart:async';

import 'package:messenger/src/model/chat_model.dart';
import 'package:messenger/src/model/explore_model.dart';
import 'package:messenger/src/model/home/comment_model.dart';
import 'package:messenger/src/model/home/home_model.dart';
import 'package:messenger/src/model/home/story_model.dart';
import 'package:messenger/src/model/home/tape_model.dart';
import 'package:messenger/src/utils/repository.dart';
import 'package:rxdart/rxdart.dart';

class ChatBloc {
  final _chatFetcher = PublishSubject<List<ChatModel>>();

  Observable<List<ChatModel>> get allChat => _chatFetcher.stream;

  fetchAllChat() async {
    Timer(Duration(seconds: 1), () {
      _chatFetcher.sink.add(chat);
    });
  }

  dispose() {
    _chatFetcher.close();
  }

  List<ChatModel> chat = [
    ChatModel(
      id: 0,
      name: "Alan Walker",
      image: "assets/images/alan_walker.png",
      lastMessage: "I’m at the office right now.",
      unRead: 2,
    ),
    ChatModel(
      id: 1,
      name: "Anna Jamil",
      image: "assets/images/anna_jamil.png",
      lastMessage: "It’s pretty cheap i think and so pretty  ",
      unRead: 1,
    ),
    ChatModel(
      id: 2,
      name: "James Person",
      image: "assets/images/james_person.png",
      lastMessage: "I’m okay, how about you?",
      unRead: 0,
    ),
    ChatModel(
      id: 3,
      name: "Leo Messi",
      image: "assets/images/messi.png",
      lastMessage: "Can your friends do it tonight?",
      unRead: 0,
    ),
    ChatModel(
      id: 4,
      name: "Thor",
      image: "assets/images/thor.png",
      lastMessage: "Yes of course, I like that very much!",
      unRead: 0,
    ),
  ];
}

ChatBloc chatBloc = ChatBloc();
