import 'package:flutter/cupertino.dart';
import 'package:weather_app/controller/news_controller.dart';
import 'package:weather_app/model/database_model.dart';

class SaveProvider with ChangeNotifier {
  NewsDbController _newsDbController = NewsDbController();

  void addToSave(DatabaseModel databaseModel) {
    _newsDbController.addtoDb(databaseModel);

    notifyListeners();
  }

  void remove(int index) {
    _newsDbController.removeArticle(index);

    notifyListeners();
  }
}
