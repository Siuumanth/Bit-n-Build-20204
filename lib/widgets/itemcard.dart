import 'package:flutter/material.dart';
import 'package:style_sorter/screens/ItemDetails.dart';

import 'dart:io';
import '../model/model.dart';
import '../model/database.dart';

class ItemCard extends StatefulWidget {
  final Item item;
  final VoidCallback onDelete;
  final bool imageornot;

  const ItemCard({
    required this.item,
    required this.imageornot,
    required this.onDelete,
    super.key,
  });

  @override
  State<ItemCard> createState() => _ItemCardState();
}

class _ItemCardState extends State<ItemCard> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {},
      child: GestureDetector(
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => ItemDetailScreen(
                item: widget.item,
              ),
            ),
          );
        },
        child: Stack(
          children: [
            Container(
              height: 150,
              width: double.infinity,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12),
                image: DecorationImage(
                  image: widget.imageornot == true
                      ? FileImage(File(widget.item.photoPath!))
                      : AssetImage(widget.item.photoPath!) as ImageProvider,
                  fit: BoxFit.cover,
                ),
              ),
            ),

            Positioned.fill(
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12),
                  color: Colors.black.withOpacity(0.2),
                ),
              ),
            ),

            Positioned(
              top: 8,
              right: 8,
              child: PopupMenuButton<String>(
                onSelected: (value) {
                  if (value == 'edit') {
                    // edit logic
                  } else if (value == 'delete') {
                    DatabaseHelper().deleteItem(widget.item.id);
                  }
                },
                itemBuilder: (context) => [
                  const PopupMenuItem(
                    value: 'edit',
                    child: Text('Edit'),
                  ),
                  const PopupMenuItem(
                    value: 'delete',
                    child: Text('Delete'),
                  ),
                ],
                icon: const Icon(Icons.more_vert, color: Colors.white),
              ),
            ),

            // Text at the bottom
            Positioned(
              bottom: 8,
              left: 8,
              right: 8,
              child: Text(
                widget.item.title!,
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
