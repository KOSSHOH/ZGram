import 'package:messenger/src/model/home/story_model.dart';
import 'package:messenger/src/model/home/tape_model.dart';

class HomeModel {
  List<StoryModel> story;
  List<TapeModel> tape;

  HomeModel({
    this.story,
    this.tape,
  });
}
