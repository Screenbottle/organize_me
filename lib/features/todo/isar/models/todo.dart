import 'package:isar/isar.dart';

part 'todo.g.dart';

@Collection()
class ToDo {
  Id id = Isar.autoIncrement;
  late String content;
  late String title;
  late String description;
  late bool done;
  late DateTime createdDate;
  late DateTime deadlineDate;
}
