import 'package:flutter/material.dart';
import 'package:organize_me/features/todo/presentation/widgets/todo_tile.dart';
import '../../domain/entities/todo.dart';

class TodoListPage extends StatefulWidget {
  const TodoListPage({super.key});

  @override
  State<TodoListPage> createState() => _TodoListState();
}

class _TodoListState extends State<TodoListPage> {
  final todos = TodoList();

  @override
  void initState() {
    todos.addMockData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        margin: const EdgeInsets.symmetric(horizontal: 10),
        child: ListView(
          children: <Widget>[
            const Padding(
              padding: EdgeInsets.symmetric(vertical: 20),
              child: Center(
                  child: Text(
                "To do's",
                style: TextStyle(fontSize: 30),
              )),
            ),
            ...todos.mockDataTodo.map((todoEntity) {
              return TodoWidget(todoEntity: todoEntity);
            }),
            const SizedBox(
              height: 60,
            )
          ],
        ),
      ),
    );
  }
}
