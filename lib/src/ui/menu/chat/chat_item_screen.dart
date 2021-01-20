import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:messenger/src/app_theme.dart';
import 'package:messenger/src/bloc/chat_bloc.dart';
import 'package:messenger/src/model/chat_item_model.dart';
import 'package:messenger/src/utils/styles.dart';
import 'package:shimmer/shimmer.dart';

class ChatItemScreen extends StatefulWidget {
  final String image;
  final String name;

  ChatItemScreen({
    this.image,
    this.name,
  });

  @override
  State<StatefulWidget> createState() {
    return _ChatItemScreenState();
  }
}

class _ChatItemScreenState extends State<ChatItemScreen> {
  TextEditingController chatController = TextEditingController();
  final FocusNode focusNode = FocusNode();
  bool isSend = false;

  _ChatItemScreenState() {
    chatController.addListener(() {
      if (chatController.text.length > 0) {
        setState(() {
          isSend = true;
        });
      } else {
        setState(() {
          isSend = false;
        });
      }
    });
  }

  @override
  void initState() {
    chatBloc.fetchUserMessage();
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
            height: 125,
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
                    Container(
                      margin: EdgeInsets.only(
                        left: 20,
                        right: 16,
                      ),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(52.0),
                        child: Image.asset(
                          widget.image,
                          height: 52,
                          width: 52,
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            widget.name,
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: Styles.boldLabel(AppTheme.dark),
                          ),
                          SizedBox(height: 2),
                          Text(
                            "@" + widget.name.toLowerCase().replaceAll(" ", ""),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: Styles.semiBoldContent(
                              AppTheme.dark80,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          Expanded(
            child: StreamBuilder(
              stream: chatBloc.allChatItem,
              builder: (context, AsyncSnapshot<List<ChatItemModel>> snapshot) {
                if (snapshot.hasData) {
                  return ListView.builder(
                    padding: EdgeInsets.only(
                      left: 25,
                      right: 25,
                    ),
                    itemCount: snapshot.data.length,
                    reverse: true,
                    itemBuilder: (context, index) {
                      return Align(
                        alignment: snapshot.data[index].isMe
                            ? Alignment.centerRight
                            : Alignment.centerLeft,
                        child: Container(
                          margin: snapshot.data[index].isMe
                              ? EdgeInsets.only(
                                  left: 35,
                                  top: 30,
                                )
                              : EdgeInsets.only(
                                  right: 35,
                                  top: 30,
                                ),
                          padding: EdgeInsets.only(
                            top: 7.0,
                            bottom: 7.0,
                            left: 15,
                            right: 15,
                          ),
                          decoration: BoxDecoration(
                            color: snapshot.data[index].isMe
                                ? AppTheme.primary
                                : AppTheme.white,
                            borderRadius: snapshot.data[index].isMe
                                ? BorderRadius.only(
                                    topLeft: Radius.circular(10.0),
                                    topRight: Radius.circular(10.0),
                                    bottomLeft: Radius.circular(10.0),
                                  )
                                : BorderRadius.only(
                                    topLeft: Radius.circular(10.0),
                                    topRight: Radius.circular(10.0),
                                    bottomRight: Radius.circular(10.0),
                                  ),
                          ),
                          child: Column(
                            crossAxisAlignment: snapshot.data[index].isMe
                                ? CrossAxisAlignment.end
                                : CrossAxisAlignment.start,
                            children: [
                              Text(
                                snapshot.data[index].message,
                                textAlign: snapshot.data[index].isMe
                                    ? TextAlign.right
                                    : TextAlign.left,
                                style: Styles.semiBoldContent(
                                  snapshot.data[index].isMe
                                      ? AppTheme.white
                                      : AppTheme.dark,
                                ),
                              ),
                              SizedBox(
                                height: 7,
                              ),
                              Text(
                                snapshot.data[index].time,
                                textAlign: snapshot.data[index].isMe
                                    ? TextAlign.right
                                    : TextAlign.left,
                                style: Styles.regularContent(
                                  snapshot.data[index].isMe
                                      ? AppTheme.white
                                      : AppTheme.dark,
                                ),
                              )
                            ],
                          ),
                        ),
                      );
                    },
                  );
                }
                return Shimmer.fromColors(
                  baseColor: AppTheme.shimmerBase,
                  highlightColor: AppTheme.shimmerHighlight,
                  child: ListView.builder(
                    padding: EdgeInsets.only(
                      left: 25,
                      right: 25,
                    ),
                    itemCount: 25,
                    reverse: true,
                    itemBuilder: (context, index) {
                      Random random = new Random();
                      int randomNumber = random.nextInt(25)+50;
                      return Align(
                        alignment: randomNumber % 2 == 0
                            ? Alignment.centerRight
                            : Alignment.centerLeft,
                        child: Container(
                          height: randomNumber.toDouble(),
                          margin: randomNumber % 2 == 0
                              ? EdgeInsets.only(
                                  left: 35,
                                  top: 30,
                                )
                              : EdgeInsets.only(
                                  right: 35,
                                  top: 30,
                                ),
                          padding: EdgeInsets.only(
                            top: 7.0,
                            bottom: 7.0,
                            left: 15,
                            right: 15,
                          ),
                          decoration: BoxDecoration(
                            color: randomNumber % 2 == 0
                                ? AppTheme.white
                                : AppTheme.white,
                            borderRadius: randomNumber % 2 == 0
                                ? BorderRadius.only(
                                    topLeft: Radius.circular(10.0),
                                    topRight: Radius.circular(10.0),
                                    bottomLeft: Radius.circular(10.0),
                                  )
                                : BorderRadius.only(
                                    topLeft: Radius.circular(10.0),
                                    topRight: Radius.circular(10.0),
                                    bottomRight: Radius.circular(10.0),
                                  ),
                          ),
                        ),
                      );
                    },
                  ),
                );
              },
            ),
          ),
          Container(
            color: AppTheme.white,
            padding: EdgeInsets.only(
              top: 20,
              left: 25,
              right: 25,
              bottom: 48,
            ),
            child: Container(
              padding: EdgeInsets.only(
                top: 13,
                bottom: 13,
                right: 20,
                left: 20,
              ),
              decoration: BoxDecoration(
                color: AppTheme.grey20,
                borderRadius: BorderRadius.circular(26),
              ),
              child: Row(
                children: [
                  SvgPicture.asset("assets/icon/smile.svg"),
                  SizedBox(width: 15),
                  Expanded(
                    child: TextField(
                      style: Styles.semiBoldContent(AppTheme.dark),
                      controller: chatController,
                      decoration: InputDecoration.collapsed(
                        hintText: "Type your messages ...",
                        hintStyle: Styles.regularContent(AppTheme.dark60),
                      ),
                      focusNode: focusNode,
                    ),
                  ),
                  SizedBox(width: 15),
                  GestureDetector(
                    onTap: () {
                      var now = new DateTime.now();
                      if (isSend) {
                        chatBloc.fetchSendUserMessage(
                          ChatItemModel(
                            message: chatController.text,
                            time: _toTwoDigitString(now.hour) +
                                ":" +
                                _toTwoDigitString(now.minute),
                            isMe: true,
                          ),
                        );
                        setState(() {
                          chatController.text = "";
                        });
                      }
                    },
                    child: !isSend
                        ? SvgPicture.asset("assets/icon/not_send.svg")
                        : SvgPicture.asset("assets/icon/send.svg"),
                  )
                ],
              ),
            ),
          )
        ],
      ),
    );
  }

  String _toTwoDigitString(int value) {
    return value.toString().padLeft(2, '0');
  }
}
