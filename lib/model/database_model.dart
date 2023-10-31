import 'package:hive_flutter/hive_flutter.dart';
part 'database_model.g.dart';

@HiveType(typeId: 1)
class DatabaseModel {
  @HiveField(0)
  String? image;

  @HiveField(1)
  String? title;

  @HiveField(2)
  String source;

  @HiveField(3)
  String decription;

  @HiveField(4)
  String content;

  DatabaseModel({
    this.image,
    this.title,
    required this.source,
    required this.decription,
    required this.content,
  });
}
