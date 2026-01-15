import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

// Conditional imports for platform detection
import 'package:sqflite_common_ffi_web/sqflite_ffi_web.dart';

class DatabaseService {
  DatabaseService._internal();

  static final DatabaseService instance = DatabaseService._internal();

  static Database? _database;

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDatabase();
    return _database!;
  }

  Future<Database> _initDatabase() async {
    // Initialize sqflite for web
    databaseFactory = databaseFactoryFfiWeb;

    final dbPath = await getDatabasesPath();
    final path = join(dbPath, 'biscoin.db');

    return await openDatabase(
      path,
      version: 1,
      onCreate: _onCreate,
    );
  }

  Future<void> _onCreate(Database db, int version) async {
    await db.execute('''
      CREATE TABLE users (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        phone TEXT UNIQUE,
        pin TEXT
      )
    ''');

    await db.execute('''
      CREATE TABLE products (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        name TEXT,
        stock INTEGER,
        cost REAL,
        price REAL
      )
    ''');
    
    await db.execute('''
      CREATE TABLE sales (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        productName TEXT,
        quantity INTEGER,
        totalAmount REAL,
        profit REAL,
        paymentMethod TEXT,
        date TEXT
      )
    ''');

    await db.execute('''
      CREATE TABLE debts (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        customerName TEXT,
        phone TEXT,
        amount REAL,
        dueDate TEXT,
        isPaid INTEGER
      )
    ''');
  }
}