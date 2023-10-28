import 'package:weather_app/controller/hive_controller.dart';
import 'package:weather_app/model/database_model.dart';

class NewsDbController {
  static List<DatabaseModel> savedArticles = [];
  DbHive _dbHive = DbHive();

  void addtoDb(DatabaseModel databaseModel) {
    savedArticles.add(databaseModel);
    _dbHive.addToDb();
  }

  void removeArticle(int index) {
    _dbHive.removeFromDb(index);
    savedArticles.removeAt(index);
  }
}
