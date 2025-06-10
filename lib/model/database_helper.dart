// lib/database_helper.dart
import 'package:sqflite/sqflite.dart';
import 'package:path_provider/path_provider.dart'; // Required for getApplicationDocumentsDirectory
import 'package:path/path.dart';
import 'dart:io';

class DatabaseHelper {
  static final DatabaseHelper _instance = DatabaseHelper._internal();
  static Database? _database;

  factory DatabaseHelper() {
    return _instance;
  }

  DatabaseHelper._internal();

  Future<Database> get database async {
    if (_database != null) {
      return _database!;
    }
    _database = await _initDatabase();
    return _database!;
  }

  Future<Database> _initDatabase() async {
    // Get the application documents directory
    Directory documentsDirectory = await getApplicationDocumentsDirectory();
    String path = join(documentsDirectory.path, 'user_database.db');

    // Open the database (or create it if it doesn't exist)
    return await openDatabase(
      path,
      version: 2,
      onCreate: _onCreate,
      onUpgrade: _onUpgrade, // Handle database upgrades if schema changes
    );
  }

  // Create the 'users' table
  Future<void> _onCreate(Database db, int version) async {
    await db.execute('''
      CREATE TABLE users(
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        username TEXT UNIQUE NOT NULL,
        password TEXT NOT NULL
      )
    ''');

    await db.execute('''
      CREATE TABLE prices(
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        kameezShalwaar REAL NOT NULL,
        shirt REAL NOT NULL
     )
  ''');

    await db.execute('''
      CREATE TABLE shopDetails(
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        shopName TEXT NOT NULL,
        mail TEXT NOT NULL,
        phoneNumber TEXT NOT NULL,
        address TEXT NOT NULL
      )
    ''');
  }

  // Handle database upgrades (e.g., adding new columns)
  Future<void> _onUpgrade(Database db, int oldVersion, int newVersion) async {
    if (oldVersion < 2) {
      await db.execute('''
      CREATE TABLE IF NOT EXISTS prices(
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        kameezShalwaar REAL NOT NULL,
        shirt REAL NOT NULL
      )
  ''');

      await db.execute('''
      CREATE TABLE IF NOT EXISTS shopDetails(
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        shopName TEXT NOT NULL,
        mail TEXT NOT NULL,
        phoneNumber TEXT NOT NULL,
        address TEXT NOT NULL
        )
      ''');
    }

  }

  // Close the database (optional, often not strictly necessary for app lifecycle)
  Future<void> close() async {
    if (_database != null && _database!.isOpen) {
      await _database!.close();
      _database = null; // Clear the instance
    }
  }
}