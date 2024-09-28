class Item {
  final String id;
  String? type;

  String? title;
  String? desc;
  String? photoPath; // File path as String

  Item({
    required this.id,
    required this.type,
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
          id: '1', name: 'Office', photo: 'assets/images/office_section.jpeg'),
      Section(
          id: '2', name: 'Casual', photo: 'assets/images/casual_section.jpeg'),
    ];
  }
}

class Type {
  final String id;
  String type_name;
  String type_image_path;
  String section_name;

  Type(
      {required this.id,
      required this.type_name,
      required this.type_image_path,
      required this.section_name});

  static List<Type> typeslist() {
    return [
      Type(
          id: '1',
          type_name: 'Shirts',
          type_image_path: 'assets/images/shirt2_type.png',
          section_name: 'Office'),
      Type(
          id: '2',
          type_name: 'Pants',
          type_image_path: 'assets/images/pant_type.png',
          section_name: 'Office'),
      Type(
          id: '3',
          type_name: 'Pants',
          type_image_path: 'assetsimagescasual_pants.png',
          section_name: 'Casual'),
    ];
  }
}
