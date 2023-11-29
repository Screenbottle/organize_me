import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:organize_me/core/constants/colors.dart';
import 'package:organize_me/features/todo/isar/models/todo.dart';
import 'package:organize_me/features/todo/isar/provider/provider.dart';
import 'package:provider/provider.dart';
import 'package:toastification/toastification.dart';

class AddTodoPage extends StatefulWidget {
  const AddTodoPage({super.key});

  @override
  State<AddTodoPage> createState() => _AddTodoPageState();
}

class _AddTodoPageState extends State<AddTodoPage> {
  TextEditingController dateInput = TextEditingController();
  TextEditingController titleEditingController = TextEditingController();
  TextEditingController descriptionEditingController = TextEditingController();
  DateTime? pickerDate;

  @override
  void initState() {
    dateInput.text = "";
    super.initState();
  }

  @override
  void dispose() {
    dateInput.dispose();
    titleEditingController.dispose();
    descriptionEditingController.dispose();
    super.dispose();
  }

  void _saveToDB(BuildContext context) {
    if (pickerDate != null) {
      final todo = ToDo()
        ..title = titleEditingController.text
        ..description = descriptionEditingController.text
        ..content = "" // TODO insert image URL here?
        ..createdDate = DateTime.now()
        ..deadlineDate = pickerDate!
        ..done = false;

      context.read<TodoProvider>().save(todo, (bool success) {
        if (success) {
          Navigator.pop(context);
          // toastification.show(
          //     context: context,
          //     type: ToastificationType.success,
          //     alignment: Alignment.bottomCenter,
          //     icon: const Icon(Icons.check_circle_outline),
          //     borderRadius: BorderRadius.circular(12),
          //     showProgressBar: false,
          //     title: "Success",
          //     description: "Successfully saved to the database",
          //     autoCloseDuration: const Duration(seconds: 3));
        } else {
          print('Misslyckades med att spara todo');
        }
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: lightGreen,
        title: const Text("Add Todo"),
        centerTitle: true,
      ),
      resizeToAvoidBottomInset: false,
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const SizedBox(
              height: 30,
            ),
            _buildDateInput(),
            _buildTitleInput(),
            _buildDescriptionInput(),
            _buildSelectImage(),
            const SizedBox(
              height: 20,
            ),
            Padding(
              padding: const EdgeInsets.only(bottom: 16.0),
              child: ElevatedButton(
                onPressed: () {
                  _saveToDB(context);
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: darkGreen,
                  foregroundColor: Colors.white,
                  minimumSize: const Size(150, 50),
                ),
                child: const Text("Save"),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Padding _buildDateInput() {
    return Padding(
      padding: const EdgeInsets.only(top: 10, right: 20, left: 20, bottom: 15),
      child: SizedBox(
        height: 100,
        child: Card(
          color: lightGreen,
          child: Align(
            alignment: Alignment.center,
            child: TextField(
              controller: dateInput,
              decoration: const InputDecoration(
                  contentPadding: EdgeInsets.only(left: 10),
                  suffixIcon: Icon(
                    Icons.calendar_today,
                  ),
                  labelText: "Enter Date"),
              readOnly: true,
              onTap: () async {
                pickerDate = await showDatePicker(
                    context: context,
                    firstDate: DateTime.now(),
                    lastDate: DateTime(2100),
                    builder: (BuildContext context, Widget? child) {
                      return Theme(
                          data: ThemeData.light().copyWith(
                              primaryColor: lightBrown,
                              colorScheme: const ColorScheme.light(
                                  onPrimaryContainer: darkGreen,
                                  primary: darkGreen,
                                  onSurface: darkGreen),
                              buttonTheme: const ButtonThemeData(
                                  textTheme: ButtonTextTheme.primary),
                              datePickerTheme: const DatePickerThemeData(
                                  backgroundColor: Colors.white)),
                          child: child!);
                    });

                if (pickerDate != null) {
                  String formattedDate =
                      DateFormat('yyyy-MM-dd').format(pickerDate!);
                  setState(
                    () {
                      dateInput.text = formattedDate;
                    },
                  );
                } else {}
              },
            ),
          ),
        ),
      ),
    );
  }

  Padding _buildTitleInput() {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 25),
      child: TextField(
        controller: titleEditingController,
        decoration: InputDecoration(
            filled: true,
            fillColor: textFieldBackground,
            labelText: "Enter Title",
            suffixIcon: GestureDetector(
              onTap: () {
                titleEditingController.text = "";
              },
              child: const Icon(Icons.close),
            )),
      ),
    );
  }

  Padding _buildDescriptionInput() {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 25),
      child: TextField(
        controller: descriptionEditingController,
        minLines: 5,
        maxLines: 5,
        decoration: InputDecoration(
          filled: true,
          fillColor: textFieldBackground,
          labelText: "Enter Discription",
          alignLabelWithHint: true,
          suffixIcon: Padding(
            padding:
                const EdgeInsets.only(left: 0, top: 0, right: 0, bottom: 90),
            child: GestureDetector(
              onTap: () {
                descriptionEditingController.text = "";
              },
              child: const Icon(Icons.close),
            ),
          ),
        ),
      ),
    );
  }

  Padding _buildSelectImage() {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
      child: SizedBox(
          height: 120,
          width: MediaQuery.of(context).size.width,
          child: Card(
            color: lightGreen,
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 30),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    "Add Image",
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          IconButton(
                            onPressed: () {
                              // TODO navigate to cameraScreen
                            },
                            icon: const Icon(
                              Icons.camera_alt_outlined,
                              size: 50,
                            ),
                          ),
                          const Text("Camera"),
                        ],
                      ),
                      Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          IconButton(
                            onPressed: () {
                              //TODO show ImagePicker
                            },
                            icon: const Icon(
                              Icons.camera_alt_outlined,
                              size: 50,
                            ),
                          ),
                          const Text("Photo"),
                        ],
                      )
                    ],
                  )
                ],
              ),
            ),
          )),
    );
  }
}
