import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import '../models/incidencia.dart';

class DatabaseService {
  static final DatabaseService _instance = DatabaseService._internal();
  static Database? _database;

  factory DatabaseService() {
    return _instance;
  }

  DatabaseService._internal();

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDatabase();
    return _database!;
  }

  Future<Database> _initDatabase() async {
    String path = join(await getDatabasesPath(), 'incidencias.db');
    return await openDatabase(
      path,
      version: 1,
      onCreate: (db, version) {
        return db.execute(
          'CREATE TABLE incidencias(id INTEGER PRIMARY KEY AUTOINCREMENT, title TEXT, description TEXT, date TEXT, photoPath TEXT, audioPath TEXT)',
        );
      },
    );
  }

  Future<void> insertIncidencia(Incidencia incidencia) async {
    final db = await database;
    await db.insert('incidencias', incidencia.toMap(), conflictAlgorithm: ConflictAlgorithm.replace);
  }

  Future<List<Incidencia>> getIncidencias() async {
    final db = await database;
    final List<Map<String, dynamic>> maps = await db.query('incidencias');
    return List.generate(maps.length, (i) {
      return Incidencia.fromMap(maps[i]);
    });
  }

  Future<void> deleteAllIncidencias() async {
    final db = await database;
    await db.delete('incidencias');
  }
}
