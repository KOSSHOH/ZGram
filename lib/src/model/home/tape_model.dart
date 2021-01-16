import 'package:messenger/src/model/home/comment_model.dart';

class TapeModel {
  int id;
  String userImage;
  String userName;
  String message;
  String image;
  int count;
  bool isFavourite;
  List<CommentModel> comments;
  String time;

  TapeModel({
    this.id,
    this.userImage,
    this.userName,
    this.message,
    this.image,
    this.count,
    this.isFavourite,
    this.comments,
    this.time,
  });
}
