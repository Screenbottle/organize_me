import 'package:equatable/equatable.dart';
import 'package:organize_me/features/todo/domain/entities/todo.dart';

abstract class LocalTodoEvent extends Equatable {
  final TodoEntity ? todo;

  const LocalTodoEvent({this.todo});

  @override
  List<Object> get props => [todo!];
}

class GetTodo extends LocalTodoEvent {
  const GetTodo();
}

class RemoveTodo extends LocalTodoEvent {
  const RemoveTodo(TodoEntity todo) : super(todo: todo);
}

class SaveTodo extends LocalTodoEvent {
  const SaveTodo(TodoEntity todo) : super(todo: todo);
}