import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'package:seguridad_20185846/models/incident.dart';

class DBHelper {
  static final DBHelper _instance = DBHelper._();
  static Database? _database;

  DBHelper._();

  factory DBHelper() {
    return _instance;
  }

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDB();
    return _database!;
  }

  Future<Database> _initDB() async {
    String path = join(await getDatabasesPath(), 'incidents.db');
    return await openDatabase(
      path,
      version: 1,
      onCreate: _onCreate,
    );
  }

  Future _onCreate(Database db, int version) async {
    await db.execute('''
      CREATE TABLE incidents (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        title TEXT,
        date TEXT,
        description TEXT,
        photoPath TEXT,
        audioPath TEXT
      )
    ''');
  }

  Future<void> insertIncident(Incident incident) async {
    final db = await database;
    await db.insert('incidents', incident.toMap(), conflictAlgorithm: ConflictAlgorithm.replace);
  }

  Future<List<Incident>> getIncidents() async {
    final db = await database;
    final List<Map<String, dynamic>> maps = await db.query('incidents');
    return List.generate(maps.length, (i) {
      return Incident(
        id: maps[i]['id'],
        title: maps[i]['title'],
        date: maps[i]['date'],
        description: maps[i]['description'],
        photoPath: maps[i]['photoPath'],
        audioPath: maps[i]['audioPath'],
      );
    });
  }

  Future<void> deleteAllIncidents() async {
    final db = await database;
    await db.delete('incidents');
  }
}
