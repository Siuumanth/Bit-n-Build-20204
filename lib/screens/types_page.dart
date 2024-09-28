import 'package:flutter/material.dart';

import '../widgets/section.dart';
import '../model/model.dart';
import 'dart:io';
import './home.dart';
import '../constants/colors.dart';
import '../widgets/type_card.dart';
import '../model/model.dart';

class TypeSection extends StatefulWidget {
  final String sectionName;
  const TypeSection({required this.sectionName, super.key});

  @override
  State<TypeSection> createState() => _TypeSectionState();
}

class _TypeSectionState extends State<TypeSection> {
  List<Type> typesList = Type.typeslist();

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
                  SizedBox(height: 15),
                  Expanded(
                    child: ListView.builder(
                      itemCount:
                          (typesList.length / 2).ceil(), // Number of rows
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
                                child: TypeCard(
                                  type_name: typesList[firstIndex].type_name,
                                  type_image_path:
                                      typesList[firstIndex].type_image_path,
                                  imageornot:
                                      (typesList[firstIndex].id == '1' ||
                                              typesList[firstIndex].id == '2')
                                          ? false
                                          : true,
                                ),
                              ),
                            ),
                            // Conditionally show second card if it exists
                            if (secondIndex < typesList.length)
                              Expanded(
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: TypeCard(
                                    type_name: typesList[secondIndex].type_name,
                                    type_image_path:
                                        typesList[secondIndex].type_image_path,
                                    imageornot: (typesList[secondIndex].id ==
                                                '1' ||
                                            typesList[secondIndex].id == '2')
                                        ? false
                                        : true,
                                  ),
                                ),
                              ),
                            if (secondIndex >= typesList.length)
                              const Spacer(), // Fills empty space if there's no second card
                          ],
                        );
                      },
                    ),
                  )
                ],
              ))
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
              hintText: 'Search ' + widget.sectionName,
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
