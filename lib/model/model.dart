class Item {
  final String id;
  String? type;
  String? wardrobe;
  String? title;
  String? desc;
  String? photoPath; // File path as String

  Item({
    required this.id,
    required this.type,
    required this.wardrobe,
    required this.title,
    required this.desc,
    required this.photoPath,
  });

  //static List<Item> todolist() {
  //   return [];
  // }
}

class Section {
  final String id;
  String name;
  String? photo;

  Section({
    required this.id,
    required this.name,
    required this.photo,
  });

  static List<Section> sectionlist() {
    return [
      Section(
          id: 'w1_sec1',
          name: 'Office',
          photo: 'assets/images/office_section.jpeg'),
      Section(
          id: 'w1_sec2',
          name: 'Casual',
          photo: 'assets/images/casual_section.jpeg'),
    ];
  }
}

class Wardrobe {
  final String id;
  String wardrobeName;

  Wardrobe({
    required this.id,
    required this.wardrobeName,
  });
}
