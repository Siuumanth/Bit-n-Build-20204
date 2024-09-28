import 'package:image_picker/image_picker.dart';
import 'package:flutter/material.dart';

import 'package:flutter/material.dart';
import 'package:style_sorter/constants/colors.dart';
import 'dart:io';

class SecDialog extends StatefulWidget {
  @override
  _SecDialogState createState() => _SecDialogState();
}

class _SecDialogState extends State<SecDialog> {
  late TextEditingController name_controller;
  late String? image_path;
  bool returnedornot = false;

  @override
  void initState() {
    super.initState();
    name_controller = TextEditingController(); // Initialize the controller
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text('Add Section'),
      content: Container(
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
                    decoration: InputDecoration(
                        hintText: 'Section Name',
                        hintStyle: TextStyle(
                            fontWeight: FontWeight.w400, color: tdblack)),
                  ),
                ),
              ],
            ),
            SizedBox(height: 20),
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
                child: returnedornot
                    ? Image.file(File(image_path!))
                    : Text(
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
              // Show a Snackbar if the name is empty
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text('Please enter a section name!'),
                  duration: Duration(seconds: 2),
                  behavior: SnackBarBehavior.floating,
                  margin: EdgeInsets.all(10),
                ),
              );

              print(name_controller.text);
            } else {
              Navigator.pop(context, {
                'name': name_controller.text,
                'imagePath': image_path ?? '', // Empty if no image
                'returnedornot': returnedornot
              });
            }
          },
          child: Text('Submit'),
        ),
        TextButton(
          onPressed: () {
            Navigator.of(context).pop(); // Close the dialog
          },
          child: Text('Cancel'),
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
        returnedornot = true;
      });
      return pickedFile.path;
    } else {
      setState(() {
        returnedornot = false;
      });
      return null;
    }
  }
}
