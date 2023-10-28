import 'package:flutter/cupertino.dart';
import 'package:weather_app/controller/hive_controller.dart';
import 'package:weather_app/controller/news_controller.dart';
import 'package:weather_app/model/database_model.dart';

class SaveProvider with ChangeNotifier {
  // DbHive _dbHive = DbHive();

  void addToSave(DatabaseModel databaseModel) {
    // _dbHive.addToDb();

    notifyListeners();
  }

  void remove(int index) {
    // _dbHive.removeFromDb(index);
    notifyListeners();
  }
}
