import 'package:organize_me/features/todo/data/models/todo.dart';
import 'package:organize_me/features/todo/domain/repository/todo_repository.dart';

class TodoRepositoryImpl implements TodoRepository {
  @override
  Future<List<ToDoModel>> getTodos() {
    throw UnimplementedError();
  }
}
