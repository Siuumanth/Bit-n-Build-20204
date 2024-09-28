import 'package:flutter/material.dart';
import 'package:style_sorter/widgets/section.dart';
import '../model/database.dart';
import '../constants/colors.dart';
import '../model/model.dart';
import '../widgets/sec_dialog.dart';
import '../model/dbmethods.dart';
import 'types_page.dart';

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
  void initState() {
    super.initState();
    loadSectionsFromDatabase().then((_) {
      print("Sections loaded: ${sectionList.length}");
    });
  }

  List<Section> sectionList = [];

  Future<void> loadSectionsFromDatabase() async {
    final sections = await DatabaseHelper().getSections();
    setState(() {
      sectionList = sections; // Assigning sections from the database
    });
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
            onTap: () => _navigateTo('Wardrobe'),
          ),
          ListTile(
            leading: const Icon(Icons.calendar_today),
            title: const Text('Calendar'),
            onTap: () => _navigateTo('Calendar'),
          ),
          ListTile(
            leading: const Icon(Icons.settings),
            title: const Text('Settings'),
            onTap: () => _navigateTo('Settings'),
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
        return WardrobeSection();
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
                const SizedBox(height: 20),
                Expanded(
                    child: ListView(
                  children: [
                    for (Section item in sectionList)
                      GestureDetector(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) =>
                                  TypeSection(sectionName: item.name),
                            ),
                          );
                        },
                        child: Sectionitem(
                          section: item,
                          on_section_edited: change_section,
                          on_section_deleted: delete_section,
                          imageornot:
                              (item.id == '1' || item.id == '2') ? false : true,
                        ),
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
        setState(() async {
          DatabaseHelper().insertSection(name, imagePath);
          await loadSectionsFromDatabase();
        });

        print('Name: $name');
        print('Image Path: $imagePath');
      }
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
