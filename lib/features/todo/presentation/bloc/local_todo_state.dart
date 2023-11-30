import 'package:equatable/equatable.dart';

import 'package:organize_me/features/todo/domain/entities/todo.dart';



abstract class LocalTodoState extends Equatable {
  final List<TodoEntity> ? todo;

  const LocalTodoState({this.todo});

  @override
  List<Object> get props => [todo!];
}

class LocaltodoLoading extends LocalTodoState {
  const LocaltodoLoading();
}

class LocaltodoDone extends LocalTodoState {
  const LocaltodoDone(List<TodoEntity> todo) : super(todo: todo);
}