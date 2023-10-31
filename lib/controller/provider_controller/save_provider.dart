import 'package:flutter/cupertino.dart';
import 'package:weather_app/controller/hive_controller.dart';
import 'package:weather_app/controller/news_controller.dart';
import 'package:weather_app/model/database_model.dart';

class SaveProvider with ChangeNotifier {
  NewsDbController _newsDbController = NewsDbController();
  final DbHive _dbHive = DbHive();

  void addToSave(DatabaseModel databaseModel) {
    _newsDbController.addtoDb(databaseModel);
    _dbHive.addToDbHive();
    notifyListeners();
  }

  void remove(int index) {
    _newsDbController.removeArticle(index);
    _dbHive.addToDbHive();
    notifyListeners();
  }
}
