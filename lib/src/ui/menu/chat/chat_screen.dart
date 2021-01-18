import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:messenger/src/app_theme.dart';
import 'package:messenger/src/bloc/chat_bloc.dart';
import 'package:messenger/src/dialog/bottom_dialog.dart';
import 'package:messenger/src/model/chat_model.dart';
import 'package:messenger/src/ui/menu/chat/chat_item_screen.dart';
import 'package:messenger/src/utils/styles.dart';

class ChatScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _ChatScreenState();
  }
}

class _ChatScreenState extends State<ChatScreen>
    with AutomaticKeepAliveClientMixin<ChatScreen> {
  @override
  bool get wantKeepAlive => true;

  @override
  void initState() {
    chatBloc.fetchAllChat();
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
                        "Chats",
                        style: Styles.boldH1(AppTheme.dark),
                      ),
                    ),
                    GestureDetector(
                      onTap: () {},
                      child: SvgPicture.asset(
                        "assets/icon/more-vertical.svg",
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
                stream: chatBloc.allChat,
                builder: (context, AsyncSnapshot<List<ChatModel>> snapshot) {
                  if (snapshot.hasData) {
                    return ListView.builder(
                      itemCount: snapshot.data.length,
                      padding: EdgeInsets.only(
                        top: 30,
                        bottom: 30,
                      ),
                      itemBuilder: (BuildContext context, int index) {
                        return Slidable(
                          key: Key(snapshot.data[index].id.toString()),
                          direction: Axis.horizontal,
                          dismissal: SlidableDismissal(
                            child: SlidableDrawerDismissal(),
                            onDismissed: (actionType) {
                              BottomDialog.deleteChat(context, index);
                            },
                          ),
                          actionPane: SlidableBehindActionPane(),
                          actionExtentRatio: 0.25,
                          child: GestureDetector(
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) =>
                                      ChatItemScreen(snapshot.data[index]),
                                ),
                              );
                            },
                            child: Container(
                              margin: EdgeInsets.only(
                                bottom: 40,
                              ),
                              padding: EdgeInsets.only(
                                left: 25,
                                right: 39,
                              ),color: AppTheme.screen,
                              child: Row(
                                children: [
                                  Container(
                                    height: 52,
                                    width: 52,
                                    child: ClipRRect(
                                      borderRadius: BorderRadius.circular(52.0),
                                      child: Hero(
                                        child: Image.asset(
                                          snapshot.data[index].image,
                                          height: 52,
                                          width: 52,
                                          fit: BoxFit.cover,
                                        ),
                                        tag: snapshot.data[index],
                                      ),
                                    ),
                                  ),
                                  SizedBox(width: 16),
                                  Expanded(
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Text(
                                          snapshot.data[index].name,
                                          maxLines: 1,
                                          overflow: TextOverflow.ellipsis,
                                          style:
                                              Styles.boldLabel(AppTheme.dark),
                                        ),
                                        SizedBox(height: 2),
                                        Text(
                                          snapshot.data[index].lastMessage,
                                          maxLines: 1,
                                          overflow: TextOverflow.ellipsis,
                                          style: Styles.semiBoldContent(
                                            AppTheme.dark80,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  SizedBox(width: 12),
                                  snapshot.data[index].unRead > 0
                                      ? Container(
                                          // height: 24,
                                          // width: 24,
                                          decoration: BoxDecoration(
                                            color: AppTheme.primary,
                                            borderRadius:
                                                BorderRadius.circular(24),
                                          ),
                                          padding: EdgeInsets.only(
                                            bottom: 4,
                                            right: 9,
                                            left: 9,
                                          ),
                                          child: Center(
                                            child: Text(
                                              snapshot.data[index].unRead
                                                  .toString(),
                                              style: Styles.boldContent(
                                                AppTheme.white,
                                              ),
                                            ),
                                          ),
                                        )
                                      : Container(),
                                ],
                              ),
                            ),
                          ),
                          actions: <Widget>[
                            Container(
                              margin: EdgeInsets.only(
                                bottom: 40,
                              ),
                              child: IconSlideAction(
                                iconWidget:
                                    SvgPicture.asset("assets/icon/trash.svg"),
                                onTap: () => {
                                  BottomDialog.deleteChat(context, index),
                                },
                                color: AppTheme.screen,
                              ),
                              color: AppTheme.screen,
                            ),
                          ],
                          secondaryActions: <Widget>[
                            Container(
                              margin: EdgeInsets.only(
                                bottom: 40,
                              ),
                              child: IconSlideAction(
                                iconWidget:
                                    SvgPicture.asset("assets/icon/trash.svg"),
                                onTap: () => {
                                  BottomDialog.deleteChat(context, index),
                                },
                                color: AppTheme.screen,
                              ),
                              color: AppTheme.screen,
                            ),
                          ],
                        );
                      },
                    );
                  }
                  return Container();
                },
              ),
            ),
          )
        ],
      ),
    );
  }
}
