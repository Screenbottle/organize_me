import 'package:flutter/material.dart';
import 'package:organize_me/core/constants/colors.dart';
import 'package:organize_me/features/todo/presentation/pages/todo.dart';

class TodoWidget extends StatelessWidget {
  final Todo todo;
  const TodoWidget({super.key, required this.todo});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: _onTap,
      child: Container(
        width: 150,
        margin: const EdgeInsets.only(bottom: 20),
        child: Card(
          margin: const EdgeInsets.symmetric(horizontal: 20),
          color: yellow,
          child: Column(children: [
            Padding(
              padding: const EdgeInsets.only(top: 10.0),
              child: Text(
                todo.title ?? "",
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
                    child: Image.asset(
                      'assets/laundry.jpeg',
                      fit: BoxFit.fill,
                      width: 100,
                      height: 150,
                    ),
                  ),
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
                  child: Padding(
                    padding: const EdgeInsets.only(top: 10.0),
                    child: Text(
                      todo.description ?? "",
                      softWrap: true,
                      style: const TextStyle(fontSize: 20),
                    ),
                  ),
                ),
              ],
            )
          ]),
        ),
      ),
    );
  }

  void _onTap() {
    print("hej");
  }
}
