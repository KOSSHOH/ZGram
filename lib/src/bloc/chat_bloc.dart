import 'dart:async';

import 'package:messenger/src/model/chat_item_model.dart';
import 'package:messenger/src/model/chat_model.dart';
import 'package:rxdart/rxdart.dart';

class ChatBloc {
  final _chatFetcher = PublishSubject<List<ChatModel>>();
  final _chatItemFetcher = PublishSubject<List<ChatItemModel>>();

  Observable<List<ChatModel>> get allChat => _chatFetcher.stream;

  Observable<List<ChatItemModel>> get allChatItem => _chatItemFetcher.stream;

  fetchAllChat() async {
    Timer(Duration(seconds: 1), () {
      _chatFetcher.sink.add(chat);
    });
  }

  fetchDeleteItem(int index) {
    chat.removeAt(index);
    _chatFetcher.sink.add(chat);
  }

  fetchUserMessage() {
    Timer(Duration(seconds: 1), () {
      _chatItemFetcher.sink.add(userMessage);
    });
  }

  fetchSendUserMessage(ChatItemModel chatItemModel) {
    userMessage.insert(0, chatItemModel);
    _chatItemFetcher.sink.add(userMessage);
  }

  dispose() {
    _chatFetcher.close();
    _chatItemFetcher.close();
  }

  List<ChatItemModel> userMessage = [
    ChatItemModel(
      id: 4,
      message: "I’m at the office right now.",
      time: "15.17",
      isMe: false,
    ),
    ChatItemModel(
      id: 3,
      message: "Thanks once again!",
      time: "15.15",
      isMe: false,
    ),
    ChatItemModel(
      id: 2,
      message: "Where are you at right now?",
      time: "15.03",
      isMe: true,
    ),
    ChatItemModel(
      id: 1,
      message: "Your welcome!",
      time: "15.03",
      isMe: true,
    ),
    ChatItemModel(
      id: 0,
      message: "Hey! Thank you for the coupons!",
      time: "15.01",
      isMe: false,
    ),
  ];

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
