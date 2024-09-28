import 'package:flutter/material.dart';

import '../constants/colors.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

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
      body:
          _getSelectedSectionWidget(), // Display the selected section's content
      drawer: buildDrawer(), // Add the drawer for navigation
    );
  }

  // Method to build the app bar
  AppBar buildAppBar() {
    return AppBar(
      title: Row(
        children: [
          Spacer(), // This will push the avatar to the right
          Container(
            height: 40,
            width: 40,
            decoration: BoxDecoration(borderRadius: BorderRadius.circular(20)),
            child: ClipOval(
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

  // Method to build the drawer
  Widget buildDrawer() {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: <Widget>[
          DrawerHeader(
            child: Text('Menu',
                style: TextStyle(fontSize: 24, color: Colors.white)),
            decoration: BoxDecoration(
              color: Colors.blue,
            ),
          ),
          ListTile(
            leading: Icon(Icons.person),
            title: Text('Wardrobe'),
            onTap: () => _navigateTo('Wardrobe'), // Navigate to Wardrobe
          ),
          ListTile(
            leading: Icon(Icons.calendar_today),
            title: Text('Calendar'),
            onTap: () => _navigateTo('Calendar'), // Navigate to Calendar
          ),
          ListTile(
            leading: Icon(Icons.settings),
            title: Text('Settings'),
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
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
      color: tdbg,
      child: Column(
        children: [
          searchbox(),
        ],
      ),
    );
  }

  // Calendar section widget
  Widget CalendarSection() {
    return Center(
      child: Text('Welcome to the Calendar Section'),
    );
  }

  // Settings section widget
  Widget SettingsSection() {
    return Center(
      child: Text('Welcome to the Settings Section'),
    );
  }

  // Search box widget
  Widget searchbox() {
    return Container(
      padding: const EdgeInsets.only(left: 15, right: 15),
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
              hintText: 'Search',
              hintStyle: TextStyle(color: tdblack))),
    );
  }
}
