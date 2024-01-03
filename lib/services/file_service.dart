import 'dart:io';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:meta_tube/utils/snackbar.dart';
import 'package:intl/intl.dart';

class FileService {
  final TextEditingController titleController = TextEditingController();
  final TextEditingController descriptionController = TextEditingController();
  final TextEditingController tagController = TextEditingController();

  bool FieldsNotEmpty = false;
  File? _selectedFiled;
  String _selectedDirectory = '';

  void saveContent(context) async {
    final title = titleController.text;
    final description = descriptionController.text;
    final tags = tagController.text;
    final textContext =
        "Title:\n\n$title\n\nDescription:\n\n$description\n\nTags:\n\n$tags";
    try {
      if (_selectedFiled != null) {
        await _selectedFiled!.writeAsString(textContext);
      } else {
        final todayDate = getTodayDate();
        String metadataDirPath = _selectedDirectory;
        if (metadataDirPath.isEmpty) {
          final directory = await FilePicker.platform.getDirectoryPath();
          _selectedDirectory = metadataDirPath = directory!;
        }
        final filePath = '$metadataDirPath/$todayDate - $title - Metadata.txt';
        final newFile = File(filePath);
        await newFile.writeAsString(textContext);
        Snack_bar.showSnackbar(
            context, Icons.check_circle, "File saved successfully");
      }
    } catch (e) {
      Snack_bar.showSnackbar(context, Icons.error, "File not saved");
    }
  }

  void loadFile(context) async {
    try {
      FilePickerResult? result = await FilePicker.platform.pickFiles();
      if (result != null) {
        File file = File(result.files.single.path!);
        _selectedFiled = file;

        final fileContent = await file.readAsString();
        final lines = fileContent.split('\n\n');

        titleController.text = lines[1];
        descriptionController.text = lines[3];
        tagController.text = lines[5];
        Snack_bar.showSnackbar(context, Icons.upload_file, "File uploaded");
      } else {
        Snack_bar.showSnackbar(context, Icons.error, "No file selected");
      }
    } catch (e) {
      Snack_bar.showSnackbar(context, Icons.error, "No file selected");
    }
  }

  void newFile(context) {
    _selectedFiled = null;
    tagController.clear();
    titleController.clear();
    descriptionController.clear();

    Snack_bar.showSnackbar(context, Icons.error, "New file created");
  }

  void newDirectory(context) async {
    try {String? directory= await FilePicker.platform.getDirectoryPath();
    _selectedDirectory = directory!;
    _selectedFiled =null;
          Snack_bar.showSnackbar(context, Icons.folder, "New folder selected");

    } catch (e) {
      Snack_bar.showSnackbar(context, Icons.error, "No folder was selected");
    }
  }

  static String getTodayDate() {
    final now = DateTime.now();
    final formatter = DateFormat('yyyy-MM-dd');
    final formattedDate = formatter.format(now);
    return formattedDate;
  }
}
