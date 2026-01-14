import 'package:sqflite/sqflite.dart';
import '../models/sale_model.dart';
import 'database_service.dart';

class SaleService {
  // ✅ DEFINE THE DATABASE SERVICE
  final DatabaseService _dbService = DatabaseService.instance;
  Future<int> insertSale(Sale sale) async {
    final db = await DatabaseService.instance.database;
    return await db.insert('sales', sale.toMap());
  }
  // 🔹 Get ALL sales (THIS FIXES YOUR ERROR)
  Future<List<Sale>> getAllSales() async {
    final db = await _dbService.database;
    final List<Map<String, dynamic>> result =
        await db.query('sales', orderBy: 'date DESC');

    return result.map((e) => Sale.fromMap(e)).toList();
  }
  Future<List<Sale>> getSales() async {
    final db = await DatabaseService.instance.database;
    final maps = await db.query(
      'sales',
      orderBy: 'date DESC',
    );

    return maps.map((map) => Sale.fromMap(map)).toList();
  }

  Future<double> getTotalSales() async {
    final db = await DatabaseService.instance.database;
    final result = await db.rawQuery(
      'SELECT SUM(totalAmount) as total FROM sales',
    );

    return result.first['total'] == null
        ? 0.0
        : (result.first['total'] as num).toDouble();
  }

  Future<double> getTotalProfit() async {
    final db = await DatabaseService.instance.database;
    final result = await db.rawQuery(
      'SELECT SUM(profit) as total FROM sales',
    );

    return result.first['total'] == null
        ? 0.0
        : (result.first['total'] as num).toDouble();
  }
}
