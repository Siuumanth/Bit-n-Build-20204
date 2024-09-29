import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import './model.dart';

class DatabaseHelper {
  static final DatabaseHelper _instance = DatabaseHelper._internal();
  static Database? _database;

  factory DatabaseHelper() {
    return _instance;
  }

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDatabase();
    return _database!;
  }

  Future<Database> _initDatabase() async {
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, 'wardrobe.db');

    return await openDatabase(path, version: 1, onCreate: _onCreate);
  }

  DatabaseHelper._internal();
  Future _onCreate(Database db, int version) async {
    await db.execute('''
    CREATE TABLE clothType (
      id INTEGER PRIMARY KEY AUTOINCREMENT,
      type_name TEXT NOT NULL,
      type_image_path TEXT,
      section_name TEXT
    )
  ''');

    // Create ClothSection table
    await db.execute('''
    CREATE TABLE clothSection (
      id INTEGER PRIMARY KEY AUTOINCREMENT,
      section_name TEXT NOT NULL,
      image_path TEXT
    )
  ''');

    await db.execute('''
  CREATE TABLE items (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    type_name TEXT NOT NULL,
    section_name TEXT NOT NULL,
    title TEXT NOT NULL,
    desc TEXT,
    photo TEXT,
    FOREIGN KEY (type_name) REFERENCES clothType (type_name),
    FOREIGN KEY (section_name) REFERENCES clothSection (section_name)
  )
''');

    await _insertDefaultSections(db);
    await _insertDefaultTypes(db);
    await _insertDefaultItems(db);
  }

  //
  //
  //
  //
  //

  Future<List<Item>> getItems(String typeName, String sectionName) async {
    final db = await database;
    final List<Map<String, dynamic>> maps = await db.query(
      'items',
      where: 'type_name = ? AND section_name = ?',
      whereArgs: [typeName, sectionName],
    );

    return List.generate(maps.length, (i) {
      return Item(
        id: maps[i]['id'].toString(),
        typeName: maps[i]['type'],
        title: maps[i]['title'],
        desc: maps[i]['desc'],
        photoPath: maps[i]['photo'],
        sectionName: maps[i]['section_name'],
      );
    });
  }

  Future<void> _insertDefaultItems(Database db) async {
    final List<Item> defaultItems = Item.Itemlist();

    for (var item in defaultItems) {
      await db.insert('items', {
        'type_name': item.typeName,
        'section_name': item.sectionName,
        'title': item.title,
        'desc': item.desc,
        'photo': item.photoPath,
      });
      print('Item inserted');
    }
  }

  Future<void> insertItem(String type, String sectionName, String title,
      String desc, String photoPath) async {
    final db = await DatabaseHelper().database;
    await db.insert(
      'items',
      {
        'type_name': type,
        'section_name': sectionName,
        'title': title,
        'desc': desc,
        'photo': photoPath,
      },
    );
  }

  Future<void> deleteItem(String id) async {
    final db = await database;
    await db.delete(
      'items',
      where: 'id = ?',
      whereArgs: [id],
    );
  }

  Future<int> updateItem(Item item) async {
    final db = await database;

    return await db.update(
      'items',
      {
        'title': item.title,
        'desc': item.desc,
        'photoPath': item.photoPath,
      },
      where: 'id = ?',
      whereArgs: [item.id],
    );
  }

//
//
//
//
//

  Future<void> deleteSection(String id) async {
    final db = await DatabaseHelper().database;
    await db.delete(
      'clothSection',
      where: 'id = ?',
      whereArgs: [id],
    );
  }

  Future<void> _insertDefaultSections(Database db) async {
    final List<Section> defaultSections = Section.sectionlist();

    for (var section in defaultSections) {
      await db.insert('clothSection',
          {'section_name': section.name, 'image_path': section.photo});
    }
  }

  Future<List<Section>> getSections() async {
    final db = await database; // Access the database
    final List<Map<String, dynamic>> maps = await db.query('clothSection');

    return List.generate(maps.length, (i) {
      return Section(
        id: maps[i]['id'].toString(),
        name: maps[i]['section_name'],
        photo: maps[i]
            ['image_path'], // Ensure you're fetching the image path too
      );
    });
  }

  Future<void> insertSection(String sectionName, String imagePath) async {
    final db = await DatabaseHelper().database;
    await db.insert(
      'clothSection',
      {
        'section_name': sectionName,
        'image_path': imagePath,
      },
    );
  }

  //
  //
  //
  //

  Future<List<Type>> getTypes(String sectionName) async {
    final db = await database; // Access the database
    final List<Map<String, dynamic>> maps = await db.query('clothType',
        where: 'section_name = ?', whereArgs: [sectionName]);

    return List.generate(maps.length, (i) {
      return Type(
          id: maps[i]['id'].toString(),
          type_name: maps[i]['type_name'],
          type_image_path: maps[i]['type_image_path'],
          section_name: maps[i]['section_name']);
    });
  }

  Future<void> _insertDefaultTypes(Database db) async {
    final List<Type> defaultypes = Type.typeslist();

    for (var type in defaultypes) {
      await db.insert('clothType', {
        'type_name': type.type_name,
        'type_image_path': type.type_image_path,
        'section_name': type.section_name
      });
      print('values insettedd');
    }
  }

  Future<void> insertype(
      String type_name, String sectionName, String imagePath) async {
    final db = await DatabaseHelper().database;
    await db.insert(
      'clothType',
      {
        'type_name': type_name,
        'section_name': sectionName,
        'type_image_path': imagePath,
      },
    );
  }

  Future<void> deleteType(String id) async {
    final db = await database;
    await db.delete(
      'clothType',
      where: 'id = ?',
      whereArgs: [id],
    );
  }
}
