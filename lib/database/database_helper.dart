import 'dart:io';
import 'package:places_backend/models/place.dart';
import 'package:sqlite3/sqlite3.dart';
import 'package:path/path.dart' as path;

class DatabaseHelper {
  static Database? _database;
  static const String _databaseName = 'places.db';
  static const String _tablePlaces = 'places';
  static const String _tableTypes = 'types';
  // Получение экземпляра базы данных
  static Database get database {
    if (_database != null) return _database!;
    _database = _initDatabase();
    return _database!;
  }

  // Инициализация базы данных
  static Database _initDatabase() {
    final dbPath = path.join(Directory.current.path, 'database', _databaseName);

    final db = sqlite3.open(dbPath);
    // Выполняем init.sql для создания таблиц и наполнения данными
    return db;
  }

  // Получение всех мест
  static List<Place> getAllPlaces() {
    final db = database;
    final result = db.select(
        'SELECT p.id, p.name, p.description, t.name as type, p.urls, p.lat, p.lng' +
            ' FROM $_tablePlaces AS p ' +
            ' JOIN $_tableTypes AS t ON p.type_id = t.id;');

    return result.map((row) => Place.fromMap(row)).toList();
  }

  // Закрытие соединения с базой данных
  static void close() {
    _database?.dispose();
    _database = null;
  }
}
