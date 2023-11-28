import 'package:flutter/material.dart';
import 'package:isar/isar.dart';
import 'package:organize_me/features/todo/isar/models/todo.dart';
import 'package:path_provider/path_provider.dart';

class TodoProvider with ChangeNotifier {
  List<ToDo> _todos = [];

  List<ToDo> get todos => _todos;

  Isar? isar;

  TodoProvider() {
    init();
  }

  void init() async {
    final directory = await getApplicationDocumentsDirectory();
    isar = await Isar.open([ToDoSchema], directory: directory.path);

    await isar!.txn(() async {
      final todosCollection = isar?.toDos;
      _todos = (await todosCollection?.where().findAll())!;
      notifyListeners();
    });
  }

  void addTodo(ToDo todo) async {
    await isar!.writeTxn<void>(() async {
      await isar?.toDos.put(todo);
    });

    _todos.add(todo);
    notifyListeners();
  }

  Future<void> save(ToDo todo, void Function(bool success) callback) async {
    try {
      await isar!.writeTxn<void>(() async {
        await isar?.toDos.put(todo);
      });

      _todos.add(todo);
      notifyListeners();

      // Notify that the operation was successful
      callback(true);
    } catch (error) {
      // Notify that the operation failed
      callback(false);
    }
  }

  void deleteTodo(ToDo todo) async {
    await isar!.writeTxn(() async {
      bool deleted = await isar!.toDos.delete(todo.id);
      if (deleted) _todos.remove(todo);
      notifyListeners();
    });
  }

  void toggleDone(int id) async {
    await isar!.writeTxn(() async {
      ToDo? todo = await isar?.toDos.get(id);
      todo!.done = !todo.done;
      await isar?.toDos.put(todo);
      int todoIndex = todos.indexWhere((todo) => todo.id == id);
      todos[todoIndex].done = todo.done;
      notifyListeners();
    });
  }
}
