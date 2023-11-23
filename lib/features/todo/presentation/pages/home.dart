import 'package:flutter/material.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:intl/intl.dart';
import 'package:organize_me/core/constants/colors.dart';
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

  void _onTap(index) {
    setState(() {
      myIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(child: widgetList[myIndex]),
      // appBar: _buildAppbar(myIndex),
      bottomNavigationBar: BottomNavigationBar(
        onTap: _onTap,
        currentIndex: myIndex,
        items: const [
          BottomNavigationBarItem(
              icon: Icon(Icons.home), label: "Home", tooltip: "Todo List"),
          BottomNavigationBarItem(
              icon: Icon(Icons.add), label: "Add Todo", tooltip: "Add todo"),
        ],
        selectedItemColor: darkPurple,
        backgroundColor: lightGreen,
      ),
    );
  }

  AppBar _buildAppbar(index) {
    String formattedDateTime() {
      initializeDateFormatting();
      final DateTime now = DateTime.now();

      final DateFormat customDateFormat = DateFormat('E d MMM', 'en_EN');
      String formattedDate = customDateFormat.format(now);

      return formattedDate;
    }

    List<Widget> appBarTitle = [
      Text(formattedDateTime()),
      const Text("add todo")
    ];

    return AppBar(
      backgroundColor: lightGreen,
      centerTitle: true,
      title: appBarTitle[index],
    );
  }
}
