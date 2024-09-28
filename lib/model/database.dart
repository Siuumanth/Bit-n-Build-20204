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

    // Create Items table
    await db.execute('''
    CREATE TABLE items (
      id INTEGER PRIMARY KEY AUTOINCREMENT,
      type_id INTEGER,
      section_id INTEGER,
      wardrobe_id INTEGER,
      title TEXT NOT NULL,
      photo TEXT,
      FOREIGN KEY (type_id) REFERENCES clothType (id),
      FOREIGN KEY (section_id) REFERENCES clothSection (id),
      FOREIGN KEY (wardrobe_id) REFERENCES wardrobe (id)
    )
  ''');

    await _insertDefaultSections(db);
    await _insertDefaultTypes(db);
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
  //
}
