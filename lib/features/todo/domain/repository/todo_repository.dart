import 'package:organize_me/features/todo/domain/entities/todo.dart';

abstract class TodoRepository {
  Future<List<TodoEntity>> getTodos();
}
