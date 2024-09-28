import 'package:image_picker/image_picker.dart';
import 'package:flutter/material.dart';
import '../model/database.dart';

import 'package:flutter/material.dart';
import 'package:style_sorter/constants/colors.dart';
import 'dart:io';

class TypeDialog extends StatefulWidget {
  const TypeDialog({super.key});

  @override
  _TypeDialogState createState() => _TypeDialogState();
}

class _TypeDialogState extends State<TypeDialog> {
  late TextEditingController name_controller;
  late String? image_path;
  bool imageornot = false;

  @override
  void initState() {
    super.initState();
    name_controller = TextEditingController(); // Initialize the controller
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('Add Type'),
      content: SizedBox(
        width: double.maxFinite,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Row(
              children: [
                Text(
                  'Name: ',
                  style: TextStyle(
                      fontWeight: FontWeight.w500,
                      fontSize: 20,
                      color: tdblack),
                ),
                Expanded(
                  child: TextField(
                    controller: name_controller,
                    decoration: InputDecoration(
                        hintText: 'Type Name',
                        hintStyle: TextStyle(
                            fontWeight: FontWeight.w400, color: tdblack)),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 20),
            GestureDetector(
              onTap: () async {
                setState(() async {
                  image_path = await getImageGallery();
                });
              },
              child: Container(
                width: double.infinity,
                height: 100,
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.grey),
                  borderRadius: BorderRadius.circular(8),
                ),
                alignment: Alignment.center,
                child: imageornot
                    ? Image.file(File(image_path!))
                    : const Text(
                        'Tap to select an image',
                        style: TextStyle(color: Colors.grey),
                      ),
              ),
            ),
          ],
        ),
      ),
      actions: [
        TextButton(
          onPressed: () {
            if (name_controller.text.isEmpty) {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text('Please enter a type name!'),
                  duration: Duration(seconds: 2),
                  behavior: SnackBarBehavior.floating,
                  margin: EdgeInsets.all(10),
                ),
              );

              print(name_controller.text);
            } else if ((image_path == '')) {
              Navigator.pop(context, {
                'name': name_controller.text,
                'imagePath': image_path, // Empty if no image
                'imageornot': false
              });
            } else {
              Navigator.pop(context, {
                'name': name_controller.text,
                'imagePath': image_path, // Empty if no image
                'imageornot': true
              });
            }
          },
          child: const Text('Submit'),
        ),
        TextButton(
          onPressed: () {
            Navigator.of(context).pop(); // Close the dialog
          },
          child: const Text('Cancel'),
        ),
      ],
    );
  }

  final picker = ImagePicker();

  Future<String?> getImageGallery() async {
    final pickedFile = await picker.pickImage(
      source: ImageSource.gallery,
      imageQuality: 80,
    );

    if (pickedFile != null) {
      setState(() {
        imageornot = true;
      });
      return pickedFile.path;
    } else {
      setState(() {
        imageornot = false;
      });
      return null;
    }
  }
}
