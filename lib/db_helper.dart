// lib/db_helper.dart
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'note.dart';

class DBHelper {
  static final DBHelper _instance = DBHelper._internal();
  factory DBHelper() => _instance;

  static Database? _database;

  DBHelper._internal();

  Future<Database?> get database async {
    if (_database != null) return _database;

    _database = await _initDB();
    return _database;
  }

  Future<Database> _initDB() async {
    String path = join(await getDatabasesPath(), 'notes.db');
    return openDatabase(
      path,
      onCreate: (db, version) {
        return db.execute(
          'CREATE TABLE notes(id INTEGER PRIMARY KEY, title TEXT, content TEXT)',
        );
      },
      version: 1,
    );
  }

  Future<void> insertNote(Note note) async {
    final db = await database;
    await db?.insert('notes', note.toMap(), conflictAlgorithm: ConflictAlgorithm.replace);
  }

  Future<List<Note>> notes() async {
    final db = await database;
    final List<Map<String, dynamic>> maps = await db?.query('notes') ?? [];

    return List.generate(maps.length, (i) {
      return Note(
        id: maps[i]['id'],
        title: maps[i]['title'],
        content: maps[i]['content'],
      );
    });
  }

  Future<void> updateNote(Note note) async {
    final db = await database;
    await db?.update(
      'notes',
      note.toMap(),
      where: 'id = ?',
      whereArgs: [note.id],
    );
  }

  Future<void> deleteNote(int id) async {
    final db = await database;
    await db?.delete(
      'notes',
      where: 'id = ?',
      whereArgs: [id],
    );
  }
}
