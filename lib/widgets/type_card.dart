import 'package:flutter/material.dart';
import 'dart:io';

import 'package:style_sorter/model/database.dart';

class TypeCard extends StatelessWidget {
  final String type_name;
  final String type_image_path;
  final bool imageornot;
  final VoidCallback ondeletetype;
  final String id;

  const TypeCard({
    required this.type_name,
    required this.type_image_path,
    required this.imageornot,
    required this.id,
    required this.ondeletetype,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        // Background image
        Container(
          height: 150,
          width: double.infinity,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12),
            image: DecorationImage(
              image: imageornot == true
                  ? FileImage(
                      File(type_image_path)) // Use FileImage for file paths
                  : AssetImage(type_image_path)
                      as ImageProvider, // Use AssetImage for assets
              fit: BoxFit.cover,
            ),
          ),
        ),

        // Dark overlay
        Positioned.fill(
          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12),
              color: Colors.black.withOpacity(0.1), // Dark overlay
            ),
          ),
        ),

        // Three-dot menu at the top right
        Positioned(
          top: 8,
          right: 8,
          child: PopupMenuButton<String>(
            onSelected: (value) {
              if (value == 'edit') {
                // edit logic
              } else if (value == 'delete') {
                DatabaseHelper().deleteType(id);
                ondeletetype();
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
            type_name,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ],
    );
  }
}
