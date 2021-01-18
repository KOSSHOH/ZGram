import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:messenger/src/app_theme.dart';
import 'package:messenger/src/bloc/chat_bloc.dart';
import 'package:messenger/src/model/bus/loading_model.dart';
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

  static void deleteChat(BuildContext context,int index) {
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
}
