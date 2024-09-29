class Item {
  final String id;
  String? typeName;
  String? sectionName;
  String? title;
  String? desc;
  String? photoPath;

  Item(
      {required this.id,
      required this.typeName,
      required this.title,
      required this.desc,
      required this.photoPath,
      required this.sectionName});

  static List<Item> Itemlist() {
    return [
      Item(
          id: '1',
          title: 'Blue Formal Shirt',
          photoPath: 'assets/images/blue_formal_shirt.png',
          desc: '',
          sectionName: 'Office',
          typeName: 'Shirts'),
      Item(
          id: '2',
          title: 'Black Formal Pant',
          photoPath: 'assets/images/black_formal_pant.png',
          desc: '',
          sectionName: 'Office',
          typeName: 'Pants'),
      Item(
          id: '3',
          title: 'Red Formal Shirt',
          photoPath: 'assets/images/red_formal_shirt.png',
          desc: '',
          sectionName: 'Office',
          typeName: 'Shirts'),
      Item(
          id: '4',
          title: 'Green Formal',
          photoPath: 'assets/images/light_g_shirt.png',
          desc: '',
          sectionName: 'Office',
          typeName: 'Shirts'),
    ];
  }
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
      Section(id: '3', name: 'Party', photo: 'assets/images/party_wear.png')
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
          type_name: 'Shoes',
          type_image_path: 'assets/images/office_shoes.png',
          section_name: 'Office'),
    ];
  }
}
