import 'package:weather_app/controller/hive_controller.dart';
import 'package:weather_app/model/database_model.dart';

class NewsDbController {
  static List<DatabaseModel> savedArticles = [];
  // final DbHive _dbHive = DbHive();

  void addtoDb(DatabaseModel databaseModel) {
    savedArticles.add(databaseModel);
    // _dbHive.addToDbHive();
  }

  void removeArticle(int index) {
    // _dbHive.removeFromDbHive(index);
    savedArticles.removeAt(index);
  }
}
