import 'package:flutter/material.dart';

import 'package:organize_me/core/constants/colors.dart';
import 'package:organize_me/features/todo/domain/entities/todo.dart';

class TodoWidget extends StatefulWidget {
  TodoEntity todoEntity;
  TodoWidget({super.key, required this.todoEntity});

  @override
  State<TodoWidget> createState() => _TodoWidgetState();
}

class _TodoWidgetState extends State<TodoWidget> {
  double cardOpacity = 1.0;

  void onTap() {
    setState(() {
      setState(() {
        if (widget.todoEntity.done != null) {
          print("setState onTap körs");
          widget.todoEntity.done = !widget.todoEntity.done!;
          
        }
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 150,
        margin: const EdgeInsets.only(bottom: 20),
        child: Stack(
          children: [
            Opacity(
              opacity: widget.todoEntity.done! ? 0.5 : 1.0,
              child: Card(
                margin: const EdgeInsets.symmetric(horizontal: 20),
                color: widget.todoEntity.done! ? lightGray : yellow,
                child: Column(children: [
                  Padding(
                    padding: const EdgeInsets.only(top: 10.0),
                    child: Text(
                      widget.todoEntity.title ?? "",
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
                                widget.todoEntity.done!
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
                          widget.todoEntity.description ?? "",
                          softWrap: true,
                          style: const TextStyle(fontSize: 20),
                        ),
                      ),
                    ],
                  )
                ]),
              ),
            ),
            Positioned(
              bottom: 10,
              right: 25,
              child: Visibility(
                  visible: widget.todoEntity.done!,
                  child: Image.asset(
                    "assets/check.png",
                    width: 50,
                    height: 50,
                  )),
            )
          ],
        ),
      ),
    );
  }
}
