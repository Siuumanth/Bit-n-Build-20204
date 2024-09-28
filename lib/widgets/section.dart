import 'package:flutter/material.dart';
import '../model/model.dart';

class Sectionitem extends StatefulWidget {
  final Section section;
  final on_section_edited;
  final on_section_deleted;

  const Sectionitem(
      {required this.section,
      required this.on_section_edited,
      required this.on_section_deleted,
      super.key});

  @override
  State<Sectionitem> createState() => _SectionitemState();
}

class _SectionitemState extends State<Sectionitem> {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 160,
      margin: const EdgeInsets.only(bottom: 10, right: 15, left: 15),
      child: Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15), // Card shape
        ),
        child: Stack(
          children: [
            ClipRRect(
                borderRadius: BorderRadius.circular(15),
                child: ColorFiltered(
                  colorFilter: ColorFilter.mode(
                      Colors.black.withOpacity(
                          0.2), // Apply black color to darken the image
                      BlendMode.darken),
                  child: Image.asset(
                    widget.section.photo!,
                    fit: BoxFit.cover,
                    width: double.infinity,
                  ),
                )),
            Positioned(
              top: 10,
              right: 10,
              child: PopupMenuButton<String>(
                onSelected: (String result) {},
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
                widget.section.name, // Display the section name
                style: const TextStyle(
                  color: Colors.white, // White text color
                  fontSize: 22, // Font size
                  fontWeight: FontWeight.bold, // Bold text
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
