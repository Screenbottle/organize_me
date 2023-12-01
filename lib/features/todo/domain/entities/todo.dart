import 'package:equatable/equatable.dart';

class TodoEntity extends Equatable {
  final int? id;
  final String? content;
  final String? title;
  final String? description;
  final bool? done;
  final String? createdDate;
  final String? deadlineDate;

  const TodoEntity(
      {this.id,
      this.content,
      this.title,
      this.description,
      this.done,
      this.createdDate,
      this.deadlineDate});

  @override
  List<Object?> get props {
    return [id, content, title, description, done, createdDate, deadlineDate];
  }
}
