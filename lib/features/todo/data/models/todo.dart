import 'package:organize_me/features/todo/domain/entities/todo.dart';

class ToDoModel extends TodoEntity {
 const ToDoModel(
      {final int? id,
      final String? content,
      final String? title,
      final String? description,
      final bool? done,
      final String? createdDate,
      final String? deadlineDate});

  factory ToDoModel.fromJson(Map<String, dynamic> map) {
    return ToDoModel(
      id: map['id'] ?? "",
      content: map["content"] ?? "",
      title: map['title'] ?? "",
      description: map['descripion'] ?? "",
      done: map['done'] ?? "",
      createdDate: map['createdDate'] ?? "",
      deadlineDate: map['deadline'] ?? "",
    );
  }

}
