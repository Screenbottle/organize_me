import 'package:flutter/material.dart';
import 'package:organize_me/features/todo/presentation/pages/add_todo.dart';
import 'package:organize_me/features/todo/presentation/pages/todo_list.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int myIndex = 0;
  List<Widget> widgetList = const [TodoListPage(), AddTodoPage()];

  @override
  Widget build(BuildContext context) {
    return const TodoListPage();
  }
}
