import 'package:hive/hive.dart';

import 'package:weather_app/controller/news_controller.dart';
import 'package:weather_app/model/database_model.dart';

class DbHive {
  final _db = Hive.box('NewsDb');

  void addToDbHive() {
    _db.put("NEWSDB", NewsDbController.savedArticles);
  }

  void removeFromDbHive(int index) {
    _db.deleteAt(index);
  }

  void getData() {
    final List mylist = _db.get("NEWSDB") ?? [];
    NewsDbController.savedArticles = mylist.cast<DatabaseModel>();
  }
}
