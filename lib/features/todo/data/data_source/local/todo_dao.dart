import 'package:floor/floor.dart';
import 'package:organize_me/features/todo/data/models/todo.dart';

@dao
abstract class TodoDao {
  @Insert()
  Future<void> insert(ToDoModel todo);

  @delete
  Future<void> deleteTodo(ToDoModel toDoModel);

  @Query('SELECT * FROM model')
  Future<List<ToDoModel>> getTodo();
}
