import 'package:hive_flutter/hive_flutter.dart';
part 'database_model.g.dart';

@HiveType(typeId: 1)
class DatabaseModel {
  // @HiveField(0)
  // String? image;

  @HiveField(0)
  String? title;

  @HiveField(1)
  String? author;

  @HiveField(2)
  String? source;

  @HiveField(3)
  String? decription;

  @HiveField(4)
  String? content;

  DatabaseModel({
    // this.image,
    this.title,
    this.source,
    this.author,
    this.decription,
    this.content,
  });
}
