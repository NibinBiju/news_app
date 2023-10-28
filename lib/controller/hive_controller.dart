import 'package:hive/hive.dart';
import 'package:hive/hive.dart';
import 'package:provider/provider.dart';
import 'package:weather_app/controller/news_controller.dart';
import 'package:weather_app/controller/provider_controller/save_provider.dart';

class DbHive {
  final _db = Hive.box("NewsDb");

  void initialData() {
    NewsDbController.savedArticles = [];
  }

  void addToDb() {
    _db.put("NEWSDB", NewsDbController.savedArticles);
    print("added sucessfully");
  }

  void removeFromDb(int index) {
    _db.deleteAt(index);
  }

  void getData() {
    NewsDbController.savedArticles = _db.get("NEWSDB");
  }
}
