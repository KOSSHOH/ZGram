import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:messenger/src/app_theme.dart';
import 'package:messenger/src/bloc/chat_bloc.dart';
import 'package:messenger/src/bloc/home_bloc.dart';
import 'package:messenger/src/database/database_helper_comment.dart';
import 'package:messenger/src/model/bus/loading_model.dart';
import 'package:messenger/src/model/home/comment_model.dart';
import 'package:messenger/src/utils/styles.dart';
import 'package:messenger/src/utils/utils.dart';
import 'package:rxbus/rxbus.dart';

class BottomDialog {
  static void sendComplain(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (BuildContext context) {
        return StatefulBuilder(
          builder: (BuildContext context, setState) {
            return Container(
              height: 487,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(10),
                  topRight: Radius.circular(10),
                ),
                color: AppTheme.white,
              ),
              child: Column(
                children: [
                  Container(
                    margin: EdgeInsets.only(
                      top: 15,
                    ),
                    height: 5,
                    width: 114,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(
                        3,
                      ),
                      color: AppTheme.grey20,
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(
                      top: 50,
                    ),
                    height: 78,
                    width: 78,
                    child: SvgPicture.asset(
                      "assets/icon/failed.svg",
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(
                      top: 45,
                    ),
                    child: Text(
                      "Login Failed",
                      style: Styles.boldH2(AppTheme.dark),
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(
                      top: 20,
                      left: 25,
                      right: 25,
                    ),
                    child: Text(
                      "You cannot login at the moment, check your internet connection and try again.",
                      textAlign: TextAlign.center,
                      style: Styles.regularLabel(AppTheme.dark80),
                    ),
                  ),
                  Expanded(
                    child: Center(
                      child: GestureDetector(
                        onTap: () {
                          RxBus.post(
                            LoadingModel(loading: false),
                            tag: "EVENT_LOADING_LOGIN",
                          );
                          Navigator.pop(context);
                        },
                        child: Container(
                          height: 56,
                          width: double.infinity,
                          margin: EdgeInsets.only(
                            left: 25,
                            right: 25,
                          ),
                          decoration: BoxDecoration(
                            color: AppTheme.primary,
                            borderRadius: BorderRadius.circular(28.5),
                            boxShadow: [
                              BoxShadow(
                                offset: Offset(0, 6),
                                blurRadius: 75,
                                spreadRadius: 0,
                                color: Color.fromRGBO(100, 87, 87, 0.05),
                              )
                            ],
                          ),
                          child: Center(
                            child: Text(
                              "Try Again",
                              style: Styles.boldButton(AppTheme.white),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            );
          },
        );
      },
    );
  }

  static void deleteChat(BuildContext context, int index) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (BuildContext context) {
        return StatefulBuilder(
          builder: (BuildContext context, setState) {
            return Container(
              height: 487,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(10),
                  topRight: Radius.circular(10),
                ),
                color: AppTheme.white,
              ),
              child: Column(
                children: [
                  Container(
                    margin: EdgeInsets.only(
                      top: 15,
                    ),
                    height: 5,
                    width: 114,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(
                        3,
                      ),
                      color: AppTheme.grey20,
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(
                      top: 50,
                    ),
                    height: 78,
                    width: 78,
                    child: SvgPicture.asset(
                      "assets/icon/alert.svg",
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(
                      top: 45,
                    ),
                    child: Text(
                      "Delete Chat?",
                      style: Styles.boldH2(AppTheme.dark),
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(
                      top: 20,
                      left: 25,
                      right: 25,
                    ),
                    child: Text(
                      "All the messages will be deleted permanently and can’t be restored, are you sure?",
                      textAlign: TextAlign.center,
                      style: Styles.regularLabel(AppTheme.dark80),
                    ),
                  ),
                  Expanded(
                    child: Center(
                      child: GestureDetector(
                        onTap: () {
                          chatBloc.fetchDeleteItem(index);
                          Navigator.pop(context);
                          BottomDialog.deleteSuccess(context);
                        },
                        child: Container(
                          height: 56,
                          width: double.infinity,
                          margin: EdgeInsets.only(
                            left: 25,
                            right: 25,
                          ),
                          decoration: BoxDecoration(
                            color: AppTheme.primary,
                            borderRadius: BorderRadius.circular(28.5),
                            boxShadow: [
                              BoxShadow(
                                offset: Offset(0, 6),
                                blurRadius: 75,
                                spreadRadius: 0,
                                color: Color.fromRGBO(100, 87, 87, 0.05),
                              )
                            ],
                          ),
                          child: Center(
                            child: Text(
                              "Delete",
                              style: Styles.boldButton(AppTheme.white),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            );
          },
        );
      },
    );
  }

  static void deleteSuccess(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (BuildContext context) {
        return StatefulBuilder(
          builder: (BuildContext context, setState) {
            return Container(
              height: 487,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(10),
                  topRight: Radius.circular(10),
                ),
                color: AppTheme.white,
              ),
              child: Column(
                children: [
                  Container(
                    margin: EdgeInsets.only(
                      top: 15,
                    ),
                    height: 5,
                    width: 114,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(
                        3,
                      ),
                      color: AppTheme.grey20,
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(
                      top: 50,
                    ),
                    height: 78,
                    width: 78,
                    child: SvgPicture.asset(
                      "assets/icon/success.svg",
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(
                      top: 45,
                    ),
                    child: Text(
                      "Delete Success",
                      style: Styles.boldH2(AppTheme.dark),
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(
                      top: 20,
                      left: 25,
                      right: 25,
                    ),
                    child: Text(
                      "All the messages have successfully deleted, start a new chat now!",
                      textAlign: TextAlign.center,
                      style: Styles.regularLabel(AppTheme.dark80),
                    ),
                  ),
                  Expanded(
                    child: Center(
                      child: GestureDetector(
                        onTap: () {
                          Navigator.pop(context);
                        },
                        child: Container(
                          height: 56,
                          width: double.infinity,
                          margin: EdgeInsets.only(
                            left: 25,
                            right: 25,
                          ),
                          decoration: BoxDecoration(
                            color: AppTheme.primary,
                            borderRadius: BorderRadius.circular(28.5),
                            boxShadow: [
                              BoxShadow(
                                offset: Offset(0, 6),
                                blurRadius: 75,
                                spreadRadius: 0,
                                color: Color.fromRGBO(100, 87, 87, 0.05),
                              )
                            ],
                          ),
                          child: Center(
                            child: Text(
                              "Done",
                              style: Styles.boldButton(AppTheme.white),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            );
          },
        );
      },
    );
  }

  static void sendComment(BuildContext context, int tapeId) {
    TextEditingController chatController = TextEditingController();
    final FocusNode focusNode = FocusNode();
    bool isSend = false;

    DatabaseHelperComment dataBase = new DatabaseHelperComment();
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (BuildContext context) {
        return StatefulBuilder(
          builder: (BuildContext context, setState) {
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

            return Padding(
              padding: EdgeInsets.only(
                bottom: MediaQuery.of(context).viewInsets.bottom,
              ),
              child: Container(
                height: 537,
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(10),
                      topRight: Radius.circular(10),
                    ),
                    color: AppTheme.white,
                  ),
                  child: Column(
                    children: [
                      Container(
                        margin: EdgeInsets.only(
                          top: 15,
                          bottom: 15,
                        ),
                        height: 5,
                        width: 114,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(
                            3,
                          ),
                          color: AppTheme.grey20,
                        ),
                      ),
                      Expanded(
                        child: FutureBuilder<List<CommentModel>>(
                          future: dataBase.getProductsTapeId(tapeId),
                          builder: (context, snapshot) {
                            if (snapshot.hasData) {
                              return ListView(
                                padding: EdgeInsets.only(
                                  left: 25,
                                  right: 25,
                                  top: 15,
                                ),
                                children: [
                                  Text(
                                    "Comments",
                                    style: Styles.boldH3(
                                      AppTheme.dark,
                                    ),
                                  ),
                                  ListView.builder(
                                    shrinkWrap: true,
                                    physics: ClampingScrollPhysics(),
                                    scrollDirection: Axis.vertical,
                                    itemCount: snapshot.data.length,
                                    itemBuilder: (context, index) {
                                      return Container(
                                        margin: EdgeInsets.only(
                                          top: 25,
                                        ),
                                        child: Row(
                                          children: [
                                            Container(
                                              height: 38,
                                              width: 38,
                                              margin: EdgeInsets.only(
                                                right: 15,
                                              ),
                                              child: ClipRRect(
                                                borderRadius: BorderRadius.all(
                                                  Radius.circular(38),
                                                ),
                                                child: Image.asset(
                                                  "assets/images/thor.png",
                                                  height: 38,
                                                  width: 38,
                                                  fit: BoxFit.cover,
                                                ),
                                              ),
                                            ),
                                            Expanded(
                                              child: Text.rich(
                                                TextSpan(
                                                  children: <InlineSpan>[
                                                    TextSpan(
                                                      text: snapshot.data[index]
                                                              .userName +
                                                          " ",
                                                      style: Styles.boldContent(
                                                        AppTheme.dark,
                                                      ),
                                                    ),
                                                    TextSpan(
                                                      text: snapshot.data[index]
                                                              .comment +
                                                          " ",
                                                      style:
                                                          Styles.regularContent(
                                                        AppTheme.dark,
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            )
                                          ],
                                        ),
                                      );
                                    },
                                  ),
                                ],
                              );
                            }
                            return Container(
                              child: Center(
                                child: Text("shimmer"),
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
                                    hintStyle:
                                        Styles.regularContent(AppTheme.dark60),
                                  ),
                                  focusNode: focusNode,
                                ),
                              ),
                              SizedBox(width: 15),
                              GestureDetector(
                                onTap: () {
                                  var now = new DateTime.now();
                                  FocusScopeNode currentFocus = FocusScope.of(context);
                                  if (isSend) {
                                    Utils.getName().then(
                                      (value) => {
                                        dataBase.saveProducts(CommentModel(
                                          userName: value,
                                          comment: chatController.text,
                                          dateTime: now,
                                          tapeId: tapeId,
                                        )),
                                        homeBloc.fetchUpdateComment(),
                                        BottomDialog.sendCommentSuccess(
                                            context),
                                        setState(() {
                                          chatController.text = "";
                                        }),
                                        if (!currentFocus.hasPrimaryFocus)
                                          {
                                            currentFocus.unfocus(),
                                          },
                                      },
                                    );
                                  }
                                },
                                child: !isSend
                                    ? SvgPicture.asset(
                                        "assets/icon/not_send.svg")
                                    : SvgPicture.asset("assets/icon/send.svg"),
                              )
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            );
          },
        );
      },
    );
  }

  static void sendCommentSuccess(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (BuildContext context) {
        return StatefulBuilder(
          builder: (BuildContext context, setState) {
            return Container(
              height: 487,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(10),
                  topRight: Radius.circular(10),
                ),
                color: AppTheme.white,
              ),
              child: Column(
                children: [
                  Container(
                    margin: EdgeInsets.only(
                      top: 15,
                    ),
                    height: 5,
                    width: 114,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(
                        3,
                      ),
                      color: AppTheme.grey20,
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(
                      top: 50,
                    ),
                    height: 78,
                    width: 78,
                    child: SvgPicture.asset(
                      "assets/icon/success.svg",
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(
                      top: 45,
                    ),
                    child: Text(
                      "Comment Added",
                      style: Styles.boldH2(AppTheme.dark),
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(
                      top: 20,
                      left: 25,
                      right: 25,
                    ),
                    child: Text(
                      "Your comment was succesfully published to this post.",
                      textAlign: TextAlign.center,
                      style: Styles.regularLabel(AppTheme.dark80),
                    ),
                  ),
                  Expanded(
                    child: Center(
                      child: GestureDetector(
                        onTap: () {
                          Navigator.of(context)
                              .popUntil((route) => route.isFirst);
                        },
                        child: Container(
                          height: 56,
                          width: double.infinity,
                          margin: EdgeInsets.only(
                            left: 25,
                            right: 25,
                          ),
                          decoration: BoxDecoration(
                            color: AppTheme.primary,
                            borderRadius: BorderRadius.circular(28.5),
                            boxShadow: [
                              BoxShadow(
                                offset: Offset(0, 6),
                                blurRadius: 75,
                                spreadRadius: 0,
                                color: Color.fromRGBO(100, 87, 87, 0.05),
                              )
                            ],
                          ),
                          child: Center(
                            child: Text(
                              "Done",
                              style: Styles.boldButton(AppTheme.white),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            );
          },
        );
      },
    );
  }
}
