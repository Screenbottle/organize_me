import 'package:organize_me/features/todo/domain/entities/todo.dart';
import 'package:floor/floor.dart';

@Entity(
  tableName: 'todo',
)
class ToDoModel extends TodoEntity {
  @override
  @PrimaryKey(autoGenerate: true)
  final int? id;

  const ToDoModel(
      {this.id,
      final String? content,
      final String? title,
      final String? description,
      final bool? done,
      final String? createdDate,
      final String? deadlineDate})
      : super(
            id: id,
            content: content,
            title: title,
            description: description,
            done: done,
            createdDate: createdDate,
            deadlineDate: deadlineDate);

  factory ToDoModel.fromJson(Map<String, dynamic> map) {
    return ToDoModel(
      id: map['id'] ?? "",
      content: map["content"] ?? "",
      title: map['title'] ?? "",
      description: map['description'] ?? "",
      done: map['done'] ?? "",
      createdDate: map['createdDate'] ?? "",
      deadlineDate: map['deadline'] ?? "",
    );
  }

  factory ToDoModel.fomEntity(TodoEntity entitiy) {
    return ToDoModel(
      id: entitiy.id,
      content: entitiy.content,
      title: entitiy.title,
      description: entitiy.description,
      done: entitiy.done,
      createdDate: entitiy.createdDate,
      deadlineDate: entitiy.deadlineDate,
      );
  }
}
