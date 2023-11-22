import 'package:hive/hive.dart';

import 'package:weather_app/controller/db_controller/news_controller.dart';
import 'package:weather_app/model/database_model.dart';

class DbHive {
  final _db = Hive.box('NewsDb');

  void addToDbHive() {
    _db.put("NEWSDB", NewsDbController.savedArticles);
  }

  void getData() {
    final List mylist = _db.get("NEWSDB") ?? [];
    NewsDbController.savedArticles = mylist.cast<DatabaseModel>();
  }
}
