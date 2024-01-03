import 'package:flutter/material.dart';
import 'package:meta_tube/services/file_service.dart';
import 'package:meta_tube/utils/app_style.dart';
import 'package:meta_tube/widgets/custom_textfield.dart';

class Homescreen extends StatefulWidget {
  const Homescreen({super.key});

  @override
  State<Homescreen> createState() => _HomescreenState();
}

class _HomescreenState extends State<Homescreen> {
  FileService fileService = FileService();

  void initState() {
    super.initState();
    addListeners();
  }

  void dispose() {
    removeListeners();
    super.dispose();
  }

  void addListeners() {
    List<TextEditingController> controller = [
      fileService.titleController,
      fileService.descriptionController,
      fileService.tagController,
    ];
    for (TextEditingController controller in controller) {
      controller.addListener(() {
        _onFieldchange();
      });
    }
  }

  void removeListeners() {
    List<TextEditingController> controller = [
      fileService.titleController,
      fileService.descriptionController,
      fileService.tagController,
    ];
    for (TextEditingController controller in controller) {
      controller.removeListener(() {
        _onFieldchange();
      });
    }
  }

  void _onFieldchange() {
    setState(() {
      fileService.FieldsNotEmpty =
          fileService.titleController.text.isNotEmpty &&
              fileService.descriptionController.text.isNotEmpty &&
              fileService.tagController.text.isNotEmpty;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Apptheme.dark,
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  _mainButton(() => fileService.newFile(context), "New File"),
                  Row(
                    children: [
                      _actionButton(
                          () => fileService.loadFile(context), Icons.file_upload),
                      SizedBox(
                        width: 8,
                      ),
                      _actionButton(() => fileService.newDirectory(context), Icons.folder)
                    ],
                  )
                ],
              ),
              SizedBox(
                height: 20,
              ),
              CustomTextfield(
                maxLines: 3,
                maxLength: 100,
                hintText: 'Enter Video Title',
                controller: fileService.titleController,
              ),
              SizedBox(
                height: 40,
              ),
              CustomTextfield(
                maxLines: 6,
                maxLength: 5000,
                hintText: 'Enter Video Description',
                controller: fileService.descriptionController,
              ),
              SizedBox(
                height: 40,
              ),
              CustomTextfield(
                maxLines: 3,
                maxLength: 500,
                hintText: 'Enter Video Tags',
                controller: fileService.tagController,
              ),
              SizedBox(height: 20),
              Row(
                children: [
                  _mainButton(
                      fileService.FieldsNotEmpty
                          ? () => fileService.saveContent(context)
                          : null,
                      "Save File"),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }

  ElevatedButton _mainButton(Function()? onPressed, String text) {
    return ElevatedButton(
        onPressed: onPressed, style: _buttonStyle(), child: Text(text));
  }

  IconButton _actionButton(Function()? onPressed, IconData icon) {
    return IconButton(
        onPressed: onPressed,
        splashRadius: 20,
        highlightColor: Apptheme.accent,
        icon: Icon(
          icon,
          color: Apptheme.medium,
        ));
  }

  ButtonStyle _buttonStyle() {
    return ElevatedButton.styleFrom(
        backgroundColor: Apptheme.accent,
        foregroundColor: Apptheme.dark,
        disabledBackgroundColor: Apptheme.disabledBackgroundColor,
        disabledForegroundColor: Apptheme.disabledForegroundColor);
  }
}
