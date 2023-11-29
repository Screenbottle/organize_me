import 'dart:io';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:organize_me/core/constants/colors.dart';
import 'package:image_picker/image_picker.dart';
import 'package:video_player/video_player.dart';
import 'dart:async';

class AddTodoPage extends StatefulWidget {
  const AddTodoPage({super.key});

  @override
  State<AddTodoPage> createState() => _AddTodoPageState();
}

class _AddTodoPageState extends State<AddTodoPage> {
  TextEditingController dateInput = TextEditingController();
  TextEditingController titleEditingController = TextEditingController();
  TextEditingController descriptionEditingController = TextEditingController();

  List<XFile>? _mediaFileList;

  void _setImageFileListFromFile(XFile? value) {
    _mediaFileList = value == null ? null : <XFile>[value];
  }

  dynamic _pickImageError;
  bool isVideo = false;

  VideoPlayerController? _controller;
  VideoPlayerController? _toBeDisposed;
  String? _retrieveDataError;

  final ImagePicker _picker = ImagePicker();
  final TextEditingController maxWidthController = TextEditingController();
  final TextEditingController maxHeightController = TextEditingController();
  final TextEditingController qualityController = TextEditingController();

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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Column(
              children: [
                _buildDateInput(),
                _buildTitleInput(),
                _buildDescriptionInput(),
                _buildSelectImage(),
              ],
            ),
            const SizedBox(
              height: 20,
            ),
            ElevatedButton(
              onPressed: () {},
              style: ElevatedButton.styleFrom(
                  backgroundColor: darkGreen,
                  foregroundColor: Colors.white,
                  minimumSize: const Size(150, 50)),
              child: const Text("Save"),
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
                DateTime? pickerDate = await showDatePicker(
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
                      DateFormat('yyyy-MM-dd').format(pickerDate);
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
                  if(_mediaFileList?.isEmpty ?? true) ...[
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
                              isVideo = false;
                              _onImageButtonPressed(ImageSource.gallery, context: context);
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
                      children: [Image.file(File(_mediaFileList![0].path)),],
                    )
                  ]
                ],
              ),
            ),
          )),
    );
  }

  Future<void> _onImageButtonPressed(
    ImageSource source, {
    required BuildContext context,
    bool isMedia = false,
  }) async {
    if (_controller != null) {
      await _controller!.setVolume(0.0);
    }
    if (context.mounted) {
        await _displayPickImageDialog(context,
            (double? maxWidth, double? maxHeight, int? quality) async {
          try {
            final XFile? pickedFile = await _picker.pickImage(
              source: source,
              maxWidth: maxWidth,
              maxHeight: maxHeight,
              imageQuality: quality,
            );
            setState(() {
              _setImageFileListFromFile(pickedFile);
            });
          } catch (e) {
            setState(() {
              _pickImageError = e;
            });
          }
        });
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

  Text? _getRetrieveErrorWidget() {
    if (_retrieveDataError != null) {
      final Text result = Text(_retrieveDataError!);
      _retrieveDataError = null;
      return result;
    }
    return null;
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
    } else {
      _retrieveDataError = response.exception!.code;
    }
  }
}

typedef OnPickImageCallback = void Function(
    double? maxWidth, double? maxHeight, int? quality);
