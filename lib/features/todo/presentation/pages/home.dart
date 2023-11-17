import 'package:flutter/material.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:intl/intl.dart';
import 'package:organize_me/core/constants/colors.dart';
import 'package:organize_me/features/todo/presentation/pages/todo.dart';
import 'package:organize_me/features/todo/presentation/widgets/todo_tile.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final todoList = TodoList();

  @override
  void initState() {
    todoList.addMockData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _buildAppbar(),
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
            ...todoList.mockDataTodo.map((todo) {
              return TodoWidget(todo: todo);
            }),
            const SizedBox(
              height: 60,
            )
          ],
        ),
      ),
      // floatingActionButton: FloatingActionButton(
      //   onPressed: () {
      //     // navigate to AddTodoPage
      //   },
      //   backgroundColor: orange,
      //   shape: const CircleBorder(),
      //   child: const Icon(Icons.add),
      // ),
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
