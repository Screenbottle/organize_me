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
      super.content,
      super.title,
      super.description,
      super.done,
      super.createdDate,
      super.deadlineDate})
      : super(id: id);

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
