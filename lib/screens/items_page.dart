import 'package:image_picker/image_picker.dart';
import 'package:flutter/material.dart';
import '../widgets/itemcard.dart';

import 'package:flutter/material.dart';

import '../widgets/section.dart';
import '../model/model.dart';
import 'dart:io';

import '../constants/colors.dart';
import 'addItems.dart';

import '../model/database.dart';
import '../widgets/typedialog.dart';
import '../widgets/itemcard.dart';

class ItemSection extends StatefulWidget {
  final String sectionName;
  final String typeName;
  const ItemSection(
      {required this.sectionName, required this.typeName, super.key});

  @override
  State<ItemSection> createState() => _ItemSectionState();
}

class _ItemSectionState extends State<ItemSection> {
  List<Item> ItemList = [];
  late TextEditingController typecontroller;

  @override
  void initState() {
    super.initState();
    loadItemsFromDatabase().then((_) {});
    typecontroller = TextEditingController();
  }

  Future<void> loadItemsFromDatabase() async {
    final allItems =
        await DatabaseHelper().getItems(widget.typeName, widget.sectionName);
    setState(() {
      ItemList = allItems;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: buildAppBar(),
        body: Stack(children: [
          Container(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
              color: tdbg,
              child: Column(
                children: [
                  searchbox(),
                  const SizedBox(height: 15),
                  Expanded(
                    child: ListView.builder(
                      itemCount: (ItemList.length / 2).ceil(), // Number of rows
                      itemBuilder: (context, index) {
                        // Calculate first and second item in the row
                        int firstIndex = index * 2;
                        int secondIndex = firstIndex + 1;

                        return Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            // First card in the row
                            Expanded(
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: ItemCard(
                                  item: ItemList[
                                      firstIndex], // Pass the entire Item object
                                  imageornot: (ItemList[firstIndex].id == '1' ||
                                          ItemList[firstIndex].id == '2' ||
                                          ItemList[firstIndex].id == '3')
                                      ? false
                                      : true,
                                ),
                              ),
                            ),
                            // Conditionally show second card if it exists
                            if (secondIndex < ItemList.length)
                              Expanded(
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: ItemCard(
                                    item: ItemList[secondIndex],
                                    imageornot: (ItemList[secondIndex].id ==
                                                '1' ||
                                            ItemList[secondIndex].id == '2' ||
                                            ItemList[secondIndex].id == '3')
                                        ? false
                                        : true,
                                  ),
                                ),
                              ),
                            if (secondIndex >= ItemList.length)
                              const Spacer(), // Fills empty space if there's no second card
                          ],
                        );
                      },
                    ),
                  )
                ],
              )),
          Align(
            alignment: Alignment.bottomRight,
            child: Container(
              margin: const EdgeInsets.only(bottom: 20, right: 20),
              child: ElevatedButton(
                onPressed: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => AddingItem(
                              sectionName: widget.sectionName,
                              typeName: widget.typeName)));
                  loadItemsFromDatabase();
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: tdyellow,
                  foregroundColor: Colors.white,
                  elevation: 10,
                ),
                child: const Text(
                  '+',
                  style: TextStyle(
                    fontSize: 40,
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ),
            ),
          )
        ]));
  }

  AppBar buildAppBar() {
    return AppBar(
      title: Row(
        children: [
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

  Widget searchbox() {
    return Container(
      margin: const EdgeInsets.only(left: 15, right: 15),
      padding: const EdgeInsets.only(left: 30, right: 30),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(30), color: Colors.white),
      child: TextField(
          //   onChanged: (value) => runfilter(value),
          decoration: InputDecoration(
              contentPadding: const EdgeInsets.all(0),
              prefixIcon: Icon(Icons.search, color: tdblack, size: 20),
              border: InputBorder.none,
              prefixIconConstraints:
                  const BoxConstraints(minWidth: 25, maxHeight: 20),
              hintText: 'Search ${widget.typeName}',
              hintStyle: TextStyle(color: tdblack))),
    );
  }

  Widget dividierline() {
    return Row(
      children: [
        const Expanded(
            child: Divider(
          indent: 20,
        )),
        ElevatedButton(
          style: ElevatedButton.styleFrom(backgroundColor: Colors.white),
          onPressed: () {
            //   _showSecDialog(context);
          },
          child: const Icon(Icons.add),
        ),
        const Expanded(
            child: Divider(
          endIndent: 20,
        )),
      ],
    );
  }
}
