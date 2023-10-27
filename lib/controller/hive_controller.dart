// // import 'package:hive/hive.dart';
// import 'package:hive/hive.dart';
// import 'package:provider/provider.dart';
// import 'package:weather_app/controller/provider_controller/save_provider.dart';

// class DbHive {
//   final _db = Hive.box("NewsDb");

//   void addToDb() {
//     _db.put("NewsDb", SaveProvider().savedArticles);
//     print("added sucessfully");
//   }

//   void removeFromDb(int index) {
//     _db.deleteAt(index);
//   }

//   void getData() {
//     SaveProvider().savedArticles = _db.get("NewsDb");
//   }
// }
