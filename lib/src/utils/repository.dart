import 'dart:async';

import 'package:messenger/src/database/database_helper_comment.dart';
import 'package:messenger/src/model/home/comment_model.dart';

class Repository {
  DatabaseHelperComment databaseHelper = new DatabaseHelperComment();

  Future<List<CommentModel>> databaseItemTape(int id) =>
      databaseHelper.getProductsTapeId(id);

  Future<int> databaseItemSave(CommentModel card) =>
      databaseHelper.saveProducts(card);
}
