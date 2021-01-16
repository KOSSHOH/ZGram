import 'dart:async';

import 'package:messenger/src/model/home/comment_model.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class DatabaseHelperComment {
  static final DatabaseHelperComment _instance = new DatabaseHelperComment.internal();

  factory DatabaseHelperComment() => _instance;

  final String tableNote = 'cardTable';
  final String columnId = '_id';
  final String columnUserName = 'userName';
  final String columnComment = 'comment';
  final String columnDateTime = 'dateTime';
  final String columnTapeId = 'tapeId';

  static Database _db;

  DatabaseHelperComment.internal();

  Future<Database> get db async {
    if (_db != null) {
      return _db;
    }
    _db = await initDb();

    return _db;
  }

  initDb() async {
    String databasesPath = await getDatabasesPath();
    String path = join(databasesPath, 'comment.db');
    var db = await openDatabase(path, version: 1, onCreate: _onCreate);
    return db;
  }

  void _onCreate(Database db, int newVersion) async {
    await db.execute('CREATE TABLE $tableNote('
        '$columnId INTEGER PRIMARY KEY AUTOINCREMENT, '
        '$columnUserName TEXT, '
        '$columnComment TEXT, '
        '$columnDateTime TEXT, '
        '$columnTapeId INTEGER)');
  }

  Future<int> saveProducts(CommentModel item) async {
    var dbClient = await db;
    var result = await dbClient.insert(tableNote, item.toMap());
    return result;
  }

  Future<List> getAllProducts() async {
    var dbClient = await db;
    var result = await dbClient.query(tableNote, columns: [
      columnId,
      columnUserName,
      columnComment,
      columnDateTime,
      columnTapeId,
    ]);

    return result.toList();
  }

  Future<List<CommentModel>> getProducts() async {
    var dbClient = await db;
    List<Map> list = await dbClient.rawQuery('SELECT * FROM $tableNote');
    List<CommentModel> item = new List();
    for (int i = 0; i < list.length; i++) {
      var items = new CommentModel(
        id: list[i][columnId],
        userName: list[i][columnUserName],
        comment: list[i][columnComment],
        dateTime: list[i][columnDateTime],
        tapeId: list[i][columnTapeId],
      );
      item.add(items);
    }
    return item;
  }

  Future<List<CommentModel>> getProductsTapeId(int id) async {
    var dbClient = await db;
    List<Map> list = await dbClient.rawQuery('SELECT * FROM $tableNote');
    List<CommentModel> item = new List();
    for (int i = 0; i < list.length; i++) {
      if (id == list[i][columnTapeId]) {
        var items = new CommentModel(
          id: list[i][columnId],
          userName: list[i][columnUserName],
          comment: list[i][columnComment],
          dateTime: list[i][columnDateTime],
          tapeId: list[i][columnTapeId],
        );
        item.add(items);
      }
    }
    return item;
  }

  Future<int> getCount() async {
    var dbClient = await db;
    return Sqflite.firstIntValue(
        await dbClient.rawQuery('SELECT COUNT(*) FROM $tableNote'));
  }

  Future<CommentModel> getProduct(int id) async {
    var dbClient = await db;
    List<Map> result = await dbClient.query(tableNote,
        columns: [
          columnId,
          columnUserName,
          columnComment,
          columnDateTime,
          columnTapeId,
        ],
        where: '$columnTapeId = ?',
        whereArgs: [id]);

    if (result.length > 0) {
      return CommentModel.fromMap(result.first);
    }

    return null;
  }

  Future<int> deleteProducts(int id) async {
    var dbClient = await db;
    return await dbClient
        .delete(tableNote, where: '$columnId = ?', whereArgs: [id]);
  }

  Future<int> updateProduct(CommentModel item) async {
    var dbClient = await db;
    return await dbClient.update(tableNote, item.toMap(),
        where: "$columnId = ?", whereArgs: [item.tapeId]);
  }

  Future close() async {
    var dbClient = await db;
    return dbClient.close();
  }

  Future<void> clear() async {
    var dbClient = await db;
    await dbClient.rawQuery('DELETE FROM $tableNote');
  }
}
