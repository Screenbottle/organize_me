import 'package:flutter/material.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:intl/intl.dart';
import 'package:organize_me/core/constants/colors.dart';
import 'package:organize_me/features/todo/isar/models/todo.dart';
import 'package:organize_me/features/todo/isar/provider/provider.dart';
import 'package:organize_me/features/todo/presentation/pages/add_todo.dart';
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
  DateTime currentDate = DateTime.now();
  List<ToDo> filteredTodos = [];

  @override
  void initState() {
    todos.addMockData();
    super.initState();
  }

  void _navigateAddTodo() {
    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (BuildContext context) => const AddTodoPage()));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _buildAppbar(),
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
              if (context
                  .watch<TodoProvider>()
                  .todos
                  .where((todo) => todo.deadlineDate.day == currentDate.day)
                  .isEmpty)
                SizedBox(
                  height: MediaQuery.of(context).size.height / 2,
                  child: const Center(
                    child: Text("There are no todos for the selected day."),
                  ),
                )
              else
                ...context
                    .watch<TodoProvider>()
                    .todos
                    .where((todo) => todo.deadlineDate.day == currentDate.day)
                    .map(
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
                            child:
                                TodoWidget(todoEntity: todo, context: context),
                          ),
                          const SizedBox(height: 20),
                        ],
                      ),
                    ),
              const SizedBox(
                height: 60,
              )
            ],
          )),
      floatingActionButton: FloatingActionButton(
        tooltip: "Add Todo",
        backgroundColor: orange,
        onPressed: () {
          _navigateAddTodo();
        },
        child: const Icon(Icons.add),
      ),
    );
  }

  AppBar _buildAppbar() {
    String formattedDateTime() {
      initializeDateFormatting();
      final DateFormat customDateFormat = DateFormat('E d MMM', 'en_EN');
      String formattedDate = customDateFormat.format(currentDate);

      return formattedDate;
    }

    void incrementDay() {
      setState(() {
        currentDate = currentDate.add(const Duration(days: 1));
      });
    }

    void decrementDay() {
      setState(() {
        currentDate = currentDate.subtract(const Duration(days: 1));
      });
    }

    return AppBar(
      backgroundColor: lightGreen,
      centerTitle: true,
      title: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          IconButton(
              onPressed: () {
                decrementDay();
              },
              icon: const Icon(Icons.arrow_back)),
          Expanded(child: Center(child: Text(formattedDateTime()))),
          IconButton(
              onPressed: () {
                incrementDay();
              },
              icon: const Icon(Icons.arrow_forward)),
        ],
      ),
    );
  }
}
