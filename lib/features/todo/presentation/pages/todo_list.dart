import 'package:flutter/material.dart';
import 'package:organize_me/core/constants/colors.dart';
import 'package:organize_me/features/todo/isar/provider/provider.dart';
import 'package:organize_me/features/todo/presentation/widgets/todo_tile.dart';
import 'package:provider/provider.dart';
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
          children: [
            const Padding(
              padding: EdgeInsets.symmetric(vertical: 20),
              child: Center(
                  child: Text(
                "To do's",
                style: TextStyle(fontSize: 30),
              )),
            ),
            ...context.watch<TodoProvider>().todos.map(
                  (todo) => Column(
                    children: [
                      Dismissible(
                        key: Key(todo.id.toString()),
                        direction: DismissDirection.endToStart,
                        onDismissed: (DismissDirection direction) {
                          context.read<TodoProvider>().deleteTodo(todo);
                        },
                        background: Container(
                          color: Colors.red,
                          child: const Align(
                            alignment: Alignment.centerRight,
                            child: Icon(
                              Icons.delete,
                              color: Colors.white,
                            ),
                          ),
                        ),
                        child: TodoWidget(todoEntity: todo, context: context),
                      ),
                      const SizedBox(height: 20),
                    ],
                  ),
                ),
            const SizedBox(
              height: 60,
            )
          ],
        ),
      ),
    );
  }
}
