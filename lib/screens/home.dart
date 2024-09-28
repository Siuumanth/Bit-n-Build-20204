import 'package:flutter/material.dart';
import 'package:style_sorter/widgets/section.dart';

import '../constants/colors.dart';
import '../model/model.dart';
import '../widgets/sec_dialog.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

final SectionList = Section.sectionlist();

class _HomeState extends State<Home> {
  String _selectedSection = 'Wardrobe';

  void _navigateTo(String section) {
    setState(() {
      _selectedSection = section;
    });
    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: buildAppBar(),
      body: _getSelectedSectionWidget(),
      drawer: buildDrawer(),
    );
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

  Widget buildDrawer() {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: <Widget>[
          const DrawerHeader(
            decoration: BoxDecoration(
              color: Colors.blue,
            ),
            child: Text('Menu',
                style: TextStyle(fontSize: 24, color: Colors.white)),
          ),
          ListTile(
            leading: const Icon(Icons.person),
            title: const Text('Wardrobe'),
            onTap: () => _navigateTo('Wardrobe'), // Navigate to Wardrobe
          ),
          ListTile(
            leading: const Icon(Icons.calendar_today),
            title: const Text('Calendar'),
            onTap: () => _navigateTo('Calendar'), // Navigate to Calendar
          ),
          ListTile(
            leading: const Icon(Icons.settings),
            title: const Text('Settings'),
            onTap: () => _navigateTo('Settings'), // Navigate to Settings
          ),
        ],
      ),
    );
  }

  // Method to return the appropriate widget based on the selected section
  Widget _getSelectedSectionWidget() {
    switch (_selectedSection) {
      case 'Wardrobe':
        return WardrobeSection();
      case 'Calendar':
        return CalendarSection();
      case 'Settings':
        return SettingsSection();
      default:
        return WardrobeSection(); // Default to Wardrobe
    }
  }

  // Wardrobe section widget
  Widget WardrobeSection() {
    return Stack(
      children: [
        Container(
            color: tdbg,
            child: Column(
              children: [
                const SizedBox(height: 20),
                searchbox(),
                const SizedBox(height: 10),
                dropdownMenu(),
                const SizedBox(height: 20),
                Expanded(
                    child: ListView(
                  children: [
                    for (Section item in SectionList)
                      Sectionitem(
                        section: item,
                        on_section_edited: change_section,
                        on_section_deleted: delete_section,
                      ),
                    dividierline(),
                  ],
                ))
              ],
            ))
      ],
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
            _showSecDialog(context);
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

  void change_section() {}
  void delete_section() {}

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

  void _showSecDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return SecDialog();
      },
    ).then((result) {
      //the 'result' contains the returned values
      if (result != null) {
        String name = result['name'];
        String imagePath = result['imagePath'];

        print('Name: $name');
        print('Image Path: $imagePath');
      }
      ;
    });
  }

  Widget CalendarSection() {
    return const Center(
      child: Text('Welcome to the Calendar Section'),
    );
  }

  // Settings section widget
  Widget SettingsSection() {
    return const Center(
      child: Text('Welcome to the Settings Section'),
    );
  }
}
