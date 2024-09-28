import 'package:flutter/material.dart';
import '../constants/colors.dart';

Widget dropdownMenu() {
  final List<String> items = ['Wardrobe 1', 'Wardrobe 2', 'Wardrobe 3'];

  String selectedItem = 'Wardrobe 1';

  return StatefulBuilder(
    builder: (BuildContext context, StateSetter setState) {
      return Align(
        alignment: Alignment.centerLeft,
        child: Container(
          padding: const EdgeInsets.only(left: 15),
          child: DropdownButton<String>(
            value: selectedItem,
            icon: const Icon(Icons.arrow_downward),
            iconSize: 24,
            elevation: 16,
            style: TextStyle(
              color: tdblack,
              fontWeight: FontWeight.w600,
              fontSize: 18,
            ),
            underline: const SizedBox(), // Remove underline
            onChanged: (String? newValue) {
              setState(() {
                selectedItem = newValue!; // Update the selected value
              });
            },
            items: items.map<DropdownMenuItem<String>>((String value) {
              return DropdownMenuItem<String>(
                value: value,
                child: Text(value),
              );
            }).toList(),
          ),
        ),
      );
    },
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
            hintText: 'Search wardrobe',
            hintStyle: TextStyle(color: tdblack))),
  );
}
