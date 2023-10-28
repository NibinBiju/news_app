import 'package:hive/hive.dart';
part 'database_model.g.dart';

@HiveType(typeId: 1)
class DatabaseModel {
  @HiveField(0)
  String image;

  @HiveField(1)
  String title;

  @HiveField(2)
  String author;

  @HiveField(3)
  String source;

  @HiveField(4)
  String decription;

  @HiveField(5)
  String content;
  @HiveField(6)
  int index;

  DatabaseModel({
    required this.image,
    required this.title,
    required this.source,
    required this.author,
    required this.decription,
    required this.content,
    required this.index,
  });
}
