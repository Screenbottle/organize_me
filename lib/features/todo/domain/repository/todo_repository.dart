import 'package:organize_me/features/todo/domain/entities/todo.dart';

abstract class TodoRepository {
  Future<List<TodoEntity>> getToDos();
  Future<void> addToDo(TodoEntity todoEntity);
  Future<void> deleteToDo(TodoEntity todoEntity);
  Future<TodoEntity> editToDO(TodoEntity todoEntity);
}
