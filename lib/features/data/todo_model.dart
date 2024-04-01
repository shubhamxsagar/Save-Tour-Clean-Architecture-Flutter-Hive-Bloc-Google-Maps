import 'package:hive_flutter/adapters.dart';

part 'todo_model.g.dart';

@HiveType(typeId: 2)
class TodoModel extends HiveObject {
  @HiveField(0)
  final String code;
  @HiveField(1)
  final String lat;
  @HiveField(2)
  final String lng;
  @HiveField(3)
  final String name;
  @HiveField(4)
  final int time;
  @HiveField(5)
  final int statusIndex;

  TodoModel({
    required this.code,
    required this.lat,
    required this.lng,
    required this.name,
    required this.time,
    required this.statusIndex,
  });
}
