import 'package:flutter/material.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:intl/intl.dart';
import 'package:organize_me/core/constants/colors.dart';
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
                "Todos",
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

  AppBar _buildAppbar() {
    String formattedDateTime() {
      initializeDateFormatting();
      final DateTime now = DateTime.now();

      final DateFormat customDateFormat = DateFormat('E d MMM', 'en_EN');
      String formattedDate = customDateFormat.format(now);

      return formattedDate;
    }

    return AppBar(
      backgroundColor: lightGreen,
      centerTitle: true,
      title: Text(formattedDateTime()),
      actions: [
        IconButton(
            onPressed: () {},
            icon: const Icon(
              Icons.add,
              size: 40,
            ))
      ],
    );
  }
}
