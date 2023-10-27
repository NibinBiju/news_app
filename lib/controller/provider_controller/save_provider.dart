import 'package:flutter/cupertino.dart';
import 'package:weather_app/model/database_model.dart';

class SaveProvider with ChangeNotifier {
  List<DatabaseModel> savedArticles = [];

  void addToSave(DatabaseModel databaseModel) {
    savedArticles.add(databaseModel);
    notifyListeners();
  }
}
