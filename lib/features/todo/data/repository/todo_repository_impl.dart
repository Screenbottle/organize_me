import 'package:organize_me/features/todo/data/data_source/local/DAO/app_database.dart';
import 'package:organize_me/features/todo/data/models/todo.dart';
import 'package:organize_me/features/todo/domain/entities/todo.dart';
import 'package:organize_me/features/todo/domain/repository/todo_repository.dart';

class TodoRepositoryImpl implements TodoRepository {
  final Appdatabase _appdatabase;
  TodoRepositoryImpl(this._appdatabase);
  @override
  Future<void> addToDo(TodoEntity todo) async {
    return _appdatabase.todoDAO.insert(ToDoModel.fomEntity(todo));
  }

  @override
  Future<void> deleteToDo(TodoEntity todo) async {
    return _appdatabase.todoDAO.deleteTodo(ToDoModel.fomEntity(todo));
  }

  @override
  Future<ToDoModel> editToDO(TodoEntity todo) async {
    throw UnimplementedError();
  }

  @override
  Future<List<ToDoModel>> getToDos() async {
    return _appdatabase.todoDAO.getTodo();
  }
}
