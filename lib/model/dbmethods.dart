import './database.dart';
import '../model/model.dart';

Future<List<Section>> getSections() async {
  final db = await DatabaseHelper().database;
  final List<Map<String, dynamic>> maps = await db.query('clothSection');

  return maps.map((map) {
    return Section(
      id: map['id'].toString(),
      name: map['section_name'],
      photo: map['image_path'],
    );
  }).toList();
}
