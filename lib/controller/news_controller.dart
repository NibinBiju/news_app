import 'package:weather_app/controller/hive_controller.dart';
import 'package:weather_app/model/database_model.dart';

class NewsDbController {
  static List<DatabaseModel> savedArticles = [];
  final DbHive _dbHive = DbHive();

  void addtoDb(DatabaseModel databaseModel) {
    savedArticles.add(databaseModel);
    _dbHive.addToDbHive();
  }

  void removeArticle(int index) {
    savedArticles.removeAt(index);
    _dbHive.removeFromDbHive(index);
  }
}
