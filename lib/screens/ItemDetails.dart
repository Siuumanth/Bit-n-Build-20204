import 'dart:io';
import 'dart:convert';
import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../model/model.dart';
import '../model/database.dart';

class ItemDetailScreen extends StatefulWidget {
  final Item item;

  const ItemDetailScreen({Key? key, required this.item}) : super(key: key);

  @override
  _ItemDetailScreenState createState() => _ItemDetailScreenState();
}

class _ItemDetailScreenState extends State<ItemDetailScreen> {
  late TextEditingController nameController;
  late TextEditingController descController;

  @override
  void initState() {
    super.initState();
    nameController = TextEditingController(text: widget.item.title);
    descController = TextEditingController(text: widget.item.desc);
  }

  @override
  void dispose() {
    nameController.dispose();
    descController.dispose();
    super.dispose();
  }

  void saveItem() async {
    setState(() {
      widget.item.title = nameController.text;
      widget.item.desc = descController.text;
    });

    await DatabaseHelper().updateItem(widget.item);

    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Item Details'),
        actions: [
          IconButton(
            icon: const Icon(Icons.save),
            onPressed: saveItem,
          ),
        ],
      ),
      resizeToAvoidBottomInset: true,
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              widget.item.photoPath != null && widget.item.photoPath!.isNotEmpty
                  ? Image.asset(widget.item.photoPath!,
                      height: 200, fit: BoxFit.cover)
                  : const Placeholder(
                      fallbackHeight: 200,
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
    );
  }
}
