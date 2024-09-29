import 'package:image_picker/image_picker.dart';
import 'package:flutter/material.dart';

import 'dart:io';
import '../constants/colors.dart';

import '../model/database.dart';

class AddingItem extends StatefulWidget {
  final String sectionName;
  final String typeName;
  const AddingItem(
      {required this.sectionName, required this.typeName, super.key});

  @override
  State<AddingItem> createState() => _AddItemState();
}

class _AddItemState extends State<AddingItem> {
  late TextEditingController nameController;
  late TextEditingController descController;
  late String? image_path;
  bool imageornot = false;

  @override
  void initState() {
    super.initState();
    nameController = TextEditingController();
    descController = TextEditingController();
  }

  @override
  void dispose() {
    nameController.dispose();
    descController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: buildAppBar(),
      resizeToAvoidBottomInset: true,
      body: Stack(
        children: [
          SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  InkWell(
                    onTap: () {
                      showPicker(context);
                    },
                    child: imageornot == false
                        ? Stack(
                            alignment: Alignment.center,
                            children: [
                              Container(
                                height: 300,
                                color: Colors.transparent,
                              ),
                              const Icon(
                                Icons.camera_alt,
                                size: 50,
                                color: Colors.grey,
                              ),
                            ],
                          )
                        : Container(child: Image.file(File(image_path!))),
                  ),
                  const SizedBox(height: 20),
                  TextField(
                    controller: nameController,
                    decoration: const InputDecoration(
                      labelText: 'Item Name',
                      border: OutlineInputBorder(),
                    ),
                  ),
                  const SizedBox(height: 20),
                  TextField(
                    controller: descController,
                    decoration: const InputDecoration(
                      labelText: 'Description',
                      border: OutlineInputBorder(),
                    ),
                    maxLines: 5,
                  ),
                ],
              ),
            ),
          ),
          Align(
            alignment: Alignment.bottomRight,
            child: Container(
              height: 50,
              margin: const EdgeInsets.only(bottom: 20, right: 20),
              child: ElevatedButton(
                onPressed: () {
                  if (nameController.text.isEmpty) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text('Please enter item name.'),
                      ),
                    );
                  } else {
                    addItemsto_db();
                    Navigator.pop(context);
                  }
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: tdyellow,
                  foregroundColor: Colors.white,
                  elevation: 10,
                ),
                child: const Icon(Icons.check),
              ),
            ),
          )
        ],
      ),
    );
  }

  Future<String?> opentheCamera() async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: ImageSource.camera);

    if (pickedFile != null) {
      setState(() {
        image_path = pickedFile.path;
        imageornot = true;
      });
      return image_path;
    } else {
      print("No Image Picked");
      imageornot = false;
      return null;
    }
  }

  void addItemsto_db() {
    DatabaseHelper().insertItem(widget.typeName, widget.sectionName,
        nameController.text, descController.text, image_path!);
  }

  Future<String?> getImageGallery() async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      setState(() {
        image_path = pickedFile.path;
        imageornot = true;
      });
      return image_path;
    } else {
      setState(() {
        imageornot = false;
      });
      print("No Image Picked");
      return null;
    }
  }

  void showPicker(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Select Image'),
          content: const Text('Choose an option to pick an image.'),
          actions: [
            TextButton(
              onPressed: () async {
                image_path = await getImageGallery();
                Navigator.pop(context);
              },
              child: const Text('Choose from Gallery'),
            ),
            TextButton(
              onPressed: () async {
                image_path = await opentheCamera();
                Navigator.pop(context);
              },
              child: const Text('Open Camera'),
            ),
          ],
        );
      },
    ).then((result) {});
  }
}

AppBar buildAppBar() {
  return AppBar(
    title: Row(
      children: [
        const Text('Add item'),
        const Spacer(),
        Container(
          height: 40,
          width: 40,
          decoration: BoxDecoration(borderRadius: BorderRadius.circular(20)),
          child: const ClipOval(
            child: CircleAvatar(
              backgroundColor: Colors.white,
              child: Icon(Icons.person),
            ),
          ),
        ),
      ],
    ),
    backgroundColor: tdyellow,
  );
}
