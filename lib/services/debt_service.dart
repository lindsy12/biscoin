import 'package:sqflite/sqflite.dart';
import '../models/debt_model.dart';
import 'database_service.dart';

class DebtService {
  static const String tableName = 'debts';

  /// Create table (called from DatabaseService)
  static Future<void> createTable(Database db) async {
    await db.execute('''
      CREATE TABLE IF NOT EXISTS $tableName (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        customerName TEXT NOT NULL,
        phone TEXT NOT NULL,
        amount REAL NOT NULL,
        dueDate TEXT NOT NULL,
        isPaid INTEGER NOT NULL
      )
    ''');
  }

  /// Insert a new debt
  Future<int> insertDebt(Debt debt) async {
    final db = await DatabaseService.instance.database;
    return await db.insert(
      tableName,
      debt.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  /// Get all unpaid debts
  Future<List<Debt>> getUnpaidDebts() async {
    final db = await DatabaseService.instance.database;

    final List<Map<String, dynamic>> maps = await db.query(
      tableName,
      where: 'isPaid = ?',
      whereArgs: [0],
      orderBy: 'dueDate ASC',
    );

    return maps.map((e) => Debt.fromMap(e)).toList();
  }

  /// Get debts due today
  Future<List<Debt>> getDebtsDueToday() async {
    final db = await DatabaseService.instance.database;

    final today = DateTime.now();
    final todayString =
        DateTime(today.year, today.month, today.day).toIso8601String();

    final List<Map<String, dynamic>> maps = await db.query(
      tableName,
      where: 'dueDate <= ? AND isPaid = ?',
      whereArgs: [todayString, 0],
    );

    return maps.map((e) => Debt.fromMap(e)).toList();
  }

  /// Mark debt as paid
  Future<void> markDebtAsPaid(int id) async {
  final db = await DatabaseService.instance.database;

  await db.update(
    tableName,
    {'isPaid': 1},
    where: 'id = ?',
    whereArgs: [id],
  );
}


  /// Delete a debt (optional)
  Future<void> deleteDebt(int id) async {
    final db = await DatabaseService.instance.database;
    await db.delete(
      tableName,
      where: 'id = ?',
      whereArgs: [id],
    );
  }
}
