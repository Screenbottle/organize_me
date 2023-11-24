import 'package:flutter/material.dart';
import 'package:organize_me/core/constants/colors.dart';

class AddTodoPage extends StatefulWidget {
  const AddTodoPage({super.key});

  @override
  State<AddTodoPage> createState() => _AddTodoPageState();
}

class _AddTodoPageState extends State<AddTodoPage> {
  TextEditingController titleEditingController = TextEditingController();
  TextEditingController descriptionEditingController = TextEditingController();

  @override
  void dispose() {
    titleEditingController.dispose();
    descriptionEditingController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Column(
      children: [
        const SizedBox(
          height: 60,
        ),
        const Text(
          "Add new todo",
          style: TextStyle(fontSize: 30),
        ),
        _buildSelectDate(context)
        //Container(
        // margin: const EdgeInsets.symmetric(horizontal: 20),
        // width: double.infinity,
        // child: Card(
        //   color: lightGreen,
        //   child: Container(
        //     width: 200,
        //     padding: const EdgeInsets.all(10),
        //     child: const Column(
        //       crossAxisAlignment: CrossAxisAlignment.start,
        //       children: [
        //         Row(
        //           children: [
        //             SizedBox(
        //               width: 10,
        //             ),
        //             Text(
        //               "Select date",
        //             ),
        //           ],
        //         ),
        //         TextField(
        //           decoration: InputDecoration(
        //               contentPadding: EdgeInsets.only(left: 10),
        //               labelText: "Enter date"),
        //         ),
        //  ,
        //),
      ],
    ));
  }

  Expanded _buildSelectDate(BuildContext context) {
    return Expanded(
      child: Container(
        margin: const EdgeInsets.only(left: 20, right: 20, top: 20),
        width: double.infinity,
        child: Column(
          children: [
            Card(
              color: lightGreen,
              child: InkWell(
                onTap: () {
                  //TODO Navigate to other page to select date
                },
                child: Container(
                  width: 300,
                  height: 80, // Set a specific height
                  padding: const EdgeInsets.all(10),
                  child: const Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      "Select date",
                      style: TextStyle(fontSize: 20, color: darkPurple),
                    ),
                  ), // TODO if the date is selected, show it here
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(25),
              child: TextField(
                controller: titleEditingController,
                decoration: InputDecoration(
                    hintText: "Enter title",
                    filled: true,
                    fillColor: lightGreen,
                    suffixIcon: GestureDetector(
                      onTap: () {
                        titleEditingController.text = "";
                      },
                      child: const Icon(Icons.close),
                    )),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(25),
              child: TextField(
                controller: descriptionEditingController,
                minLines: 5,
                maxLines: 5,
                decoration: InputDecoration(
                  hintText: "Enter description",
                  filled: true,
                  fillColor: lightGreen,
                  suffixIcon: Padding(
                    padding: const EdgeInsets.only(
                        left: 0, top: 0, right: 0, bottom: 100),
                    child: GestureDetector(
                      onTap: () {
                        descriptionEditingController.text = "";
                      },
                      child: const Icon(Icons.close),
                    ),
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
