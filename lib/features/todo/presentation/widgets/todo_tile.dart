import 'package:flutter/material.dart';
import 'package:organize_me/core/constants/colors.dart';
import 'package:organize_me/features/todo/isar/models/todo.dart';
import 'package:organize_me/features/todo/isar/provider/provider.dart';
import 'package:provider/provider.dart';

class TodoWidget extends StatefulWidget {
  final ToDo todoEntity;
  final BuildContext context;
  const TodoWidget(
      {super.key, required this.todoEntity, required this.context});

  @override
  State<TodoWidget> createState() => _TodoWidgetState();
}

class _TodoWidgetState extends State<TodoWidget> {
  double cardOpacity = 1.0;

  void toggleDone() {
    context.read<TodoProvider>().toggleDone(widget.todoEntity.id);
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: GestureDetector(
        onTap: toggleDone,
        child: Container(
          width: 320,
          margin: const EdgeInsets.only(bottom: 0),
          child: Stack(
            children: [
              Opacity(
                opacity: widget.todoEntity.done ? 0.7 : 1.0,
                child: Container(
                  width: 320,
                  decoration: BoxDecoration(
                    color: yellow,
                    borderRadius: BorderRadius.circular(5),
                    boxShadow: const [
                      BoxShadow(
                          color: Colors.black54,
                          blurRadius: 10,
                          offset: Offset(1, 3),
                          spreadRadius: 0.1,
                          blurStyle: BlurStyle.normal),
                    ],
                  ),
                  child: Card(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(6.0),
                    ),
                    margin: const EdgeInsets.symmetric(horizontal: 0),
                    color: widget.todoEntity.done ? lightGray : yellow,
                    child: Column(children: [
                      Padding(
                        padding: const EdgeInsets.only(top: 10.0),
                        child: Text(
                          widget.todoEntity.title,
                          style: const TextStyle(fontSize: 25),
                        ),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Container(
                            margin: const EdgeInsets.all(8.0),
                            child: ClipRRect(
                                borderRadius: BorderRadius.circular(5),
                                child: ColorFiltered(
                                  colorFilter: ColorFilter.mode(
                                    widget.todoEntity.done
                                        ? Colors.grey
                                        : Colors.transparent,
                                    BlendMode.saturation,
                                  ),
                                  child: Image.asset(
                                    'assets/laundry.jpeg',
                                    fit: BoxFit.fill,
                                    width: 100,
                                    height: 150,
                                  ),
                                )),
                          ),
                          const SizedBox(
                            width: 20,
                          ),
                          Container(
                            width: 150,
                            constraints: const BoxConstraints(
                              minHeight: 100,
                            ),
                            margin: const EdgeInsets.all(8),
                            child: Text(
                              widget.todoEntity.description,
                              softWrap: true,
                              style: const TextStyle(fontSize: 20),
                            ),
                          ),
                        ],
                      )
                    ]),
                  ),
                ),
              ),
              Positioned(
                bottom: 10,
                right: 25,
                child: Visibility(
                  visible: widget.todoEntity.done,
                  child: Image.asset(
                    "assets/check.png",
                    width: 50,
                    height: 50,
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
