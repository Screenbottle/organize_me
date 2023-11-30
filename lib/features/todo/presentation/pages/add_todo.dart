import 'dart:io';

import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:organize_me/core/constants/colors.dart';

import 'package:image_picker/image_picker.dart';
import 'package:organize_me/features/todo/presentation/pages/camera.dart';
import 'package:toastification/toastification.dart';
import 'package:video_player/video_player.dart';
import 'dart:async';
import 'package:organize_me/features/todo/isar/models/todo.dart';
import 'package:organize_me/features/todo/isar/provider/provider.dart';
import 'package:provider/provider.dart';

class AddTodoPage extends StatefulWidget {
  const AddTodoPage({super.key});

  @override
  State<AddTodoPage> createState() => _AddTodoPageState();
}

class _AddTodoPageState extends State<AddTodoPage> {
  TextEditingController dateInput = TextEditingController();
  TextEditingController titleEditingController = TextEditingController();
  TextEditingController descriptionEditingController = TextEditingController();
  bool pickerDateIsEmpty = false;

  DateTime? pickerDate;

  List<XFile>? _mediaFileList;

  void _setImageFileListFromFile(XFile? value) {
    _mediaFileList = value == null ? null : <XFile>[value];
  }

  bool isVideo = false;

  VideoPlayerController? _controller;
  VideoPlayerController? _toBeDisposed;

  final ImagePicker _picker = ImagePicker();
  final TextEditingController maxWidthController = TextEditingController();
  final TextEditingController maxHeightController = TextEditingController();
  final TextEditingController qualityController = TextEditingController();
  final ScrollController _scrollController = ScrollController();

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

    _disposeVideoController();
    maxWidthController.dispose();
    maxHeightController.dispose();
    qualityController.dispose();
    super.dispose();
  }

  Future<void> _disposeVideoController() async {
    if (_toBeDisposed != null) {
      await _toBeDisposed!.dispose();
    }
    _toBeDisposed = _controller;
    _controller = null;
  }

  void _scrollDown() {
    _scrollController.jumpTo(_scrollController.position.maxScrollExtent);
  }

  void _showToast(String title, String description) {
    toastification.show(
        context: context,
        style: ToastificationStyle.fillColored,
        type: ToastificationType.error,
        alignment: Alignment.bottomCenter,
        icon: const Icon(Icons.check_circle_outline),
        borderRadius: BorderRadius.circular(12),
        showProgressBar: false,
        title: title,
        description: description,
        autoCloseDuration: const Duration(seconds: 3));
  }

  void _saveToDB(BuildContext context) {
    final image = _mediaFileList?[0];

    if (pickerDate == null) {
      _showToast("Error", "No date is selected");
    } else if (titleEditingController.text == "") {
      _showToast("Error", "You need to enter Title");
    } else if (descriptionEditingController.text == "") {
      _showToast("Error", "You need to enter Description");
    } else {
      final todo = ToDo()
        ..title = titleEditingController.text
        ..description = descriptionEditingController.text
        ..content = image?.path ?? ""
        ..createdDate = DateTime.now()
        ..deadlineDate = pickerDate!
        ..done = false;

      context.read<TodoProvider>().save(todo, (bool success) {
        if (success) {
          Navigator.pop(context);
        } else {}
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
      body: ListView(controller: _scrollController, children: [
        Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const SizedBox(
              height: 30,
            ),
            _buildDateInput(),
            _buildTitleInput(),
            _buildDescriptionInput(),
            _mediaFileList?.isEmpty ?? true
                ? _buildSelectImage()
                : Image.file(
                    File(_mediaFileList![0].path),
                    width: 200,
                    height: 250,
                  ),
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
      ]),
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
                    initialDate: DateTime.now(),
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
                  if (_mediaFileList?.isEmpty ?? true) ...[
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
                                _navigateToCamera(context);
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
                                isVideo = false;
                                _onImageButtonPressed(ImageSource.gallery,
                                    context: context);
                              },
                              icon: const Icon(
                                Icons.photo_album_outlined,
                                size: 50,
                              ),
                            ),
                            const Text("Photo"),
                          ],
                        ),
                      ],
                    ),
                  ] else ...[
                    Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Image.file(File(_mediaFileList![0].path)),
                      ],
                    )
                  ]
                ],
              ),
            ),
          )),
    );
  }

  Future<void> _navigateToCamera(BuildContext context) async {
    final List<CameraDescription> cameras = await availableCameras();
    // navigate to the camera page
    if (context.mounted) {
      final result = await Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => CameraPage(cameras: cameras)));

      if (!mounted) return;
      // when it returns, result will either be the XFile that was taken with the camera, or null
      // if it is an XFile, add it to the imagefile list
      if (result.runtimeType == XFile) {
        print("add todo result: $result");
        setState(() {
          _setImageFileListFromFile(result);
        });
      }
    }
  }

  Future<void> _onImageButtonPressed(
    ImageSource source, {
    required BuildContext context,
  }) async {
    try {
      final XFile? pickedFile = await _picker.pickImage(
        source: source,
      );

      if (pickedFile != null) {
        setState(() {
          _setImageFileListFromFile(pickedFile);
        });
        WidgetsBinding.instance.addPostFrameCallback((_) {
          _scrollDown();
        });
      }
    } catch (e) {
      setState(() {});
    }
  }

  Future<void> _displayPickImageDialog(
      BuildContext context, OnPickImageCallback onPick) async {
    return showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: const Text('Add optional parameters'),
            content: Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                TextField(
                  controller: maxWidthController,
                  keyboardType:
                      const TextInputType.numberWithOptions(decimal: true),
                  decoration: const InputDecoration(
                      hintText: 'Enter maxWidth if desired'),
                ),
                TextField(
                  controller: maxHeightController,
                  keyboardType:
                      const TextInputType.numberWithOptions(decimal: true),
                  decoration: const InputDecoration(
                      hintText: 'Enter maxHeight if desired'),
                ),
                TextField(
                  controller: qualityController,
                  keyboardType: TextInputType.number,
                  decoration: const InputDecoration(
                      hintText: 'Enter quality if desired'),
                ),
              ],
            ),
            actions: <Widget>[
              TextButton(
                child: const Text('CANCEL'),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
              TextButton(
                  child: const Text('PICK'),
                  onPressed: () {
                    final double? width = maxWidthController.text.isNotEmpty
                        ? double.parse(maxWidthController.text)
                        : null;
                    final double? height = maxHeightController.text.isNotEmpty
                        ? double.parse(maxHeightController.text)
                        : null;
                    final int? quality = qualityController.text.isNotEmpty
                        ? int.parse(qualityController.text)
                        : null;
                    onPick(width, height, quality);
                    Navigator.of(context).pop();
                  }),
            ],
          );
        });
  }

  Future<void> retrieveLostData() async {
    final LostDataResponse response = await _picker.retrieveLostData();
    if (response.isEmpty) {
      return;
    }
    if (response.file != null) {
      setState(() {
        if (response.files == null) {
          _setImageFileListFromFile(response.file);
        } else {
          _mediaFileList = response.files;
        }
      });
    } else {}
  }
}

typedef OnPickImageCallback = void Function(
    double? maxWidth, double? maxHeight, int? quality);
