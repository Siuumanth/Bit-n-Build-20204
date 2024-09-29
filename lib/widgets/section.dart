import 'package:flutter/material.dart';
import 'package:style_sorter/model/database.dart';
import '../model/model.dart';
import 'dart:io';

class Sectionitem extends StatefulWidget {
  final Section section;
  final bool imageornot;
  final Function on_section_edited;
  final Function on_section_deleted;

  const Sectionitem({
    required this.section,
    required this.on_section_edited,
    required this.on_section_deleted,
    required this.imageornot,
    super.key,
  });

  @override
  State<Sectionitem> createState() => _SectionitemState();
}

class _SectionitemState extends State<Sectionitem> {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity, // Set full width for the container
      margin: const EdgeInsets.only(bottom: 10, right: 15, left: 15),
      child: Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15),
        ),
        clipBehavior: Clip
            .antiAlias, // Ensure the card content is clipped to rounded edges
        child: Stack(
          children: [
            ColorFiltered(
              colorFilter: ColorFilter.mode(
                Colors.black.withOpacity(0.25),
                BlendMode.darken,
              ),
              child: widget.imageornot
                  ? Image.file(
                      File(widget.section.photo!),
                      width: double.infinity,
                      height: 160,
                      fit: BoxFit.cover,
                    )
                  : Image.asset(
                      widget.section.photo!,
                      width: double.infinity, // Ensure image takes full width
                      height: 160,
                      fit: BoxFit.cover,
                    ),
            ),
            Positioned(
              top: 10,
              right: 10,
              child: PopupMenuButton<String>(
                onSelected: (String result) {
                  if (result == 'Edit') {
                    widget.on_section_edited(widget.section);
                  } else if (result == 'Delete') {
                    DatabaseHelper().deleteSection(widget.section.id);
                    widget.on_section_deleted();
                  }
                },
                itemBuilder: (BuildContext context) => <PopupMenuEntry<String>>[
                  const PopupMenuItem<String>(
                    value: 'Edit',
                    child: Text('Edit'),
                  ),
                  const PopupMenuItem<String>(
                    value: 'Delete',
                    child: Text('Delete'),
                  ),
                ],
                icon: const Icon(Icons.more_vert, color: Colors.white),
              ),
            ),
            Positioned(
              bottom: 10,
              left: 10,
              child: Text(
                widget.section.name,
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                  shadows: [
                    Shadow(
                      offset: Offset(0.5, 0.5), // Shadow for readability
                      blurRadius: 3,
                      color: Colors.black,
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
