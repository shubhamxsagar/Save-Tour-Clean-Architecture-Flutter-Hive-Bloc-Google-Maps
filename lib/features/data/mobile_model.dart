import 'package:hive/hive.dart';

part 'mobile_model.g.dart';

@HiveType(typeId: 1)
class LockModel extends HiveObject {
  @HiveField(0)
  final int code;

  LockModel(this.code);
}
