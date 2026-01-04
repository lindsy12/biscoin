import 'package:sqflite/sqflite.dart';
import '../models/product_model.dart';
import 'database_service.dart';

class ProductService {
  Future<int> insertProduct(Product product) async {
    final Database db = await DatabaseService.instance.database;
    return await db.insert('products', product.toMap());
  }

  Future<List<Product>> getProducts() async {
    final Database db = await DatabaseService.instance.database;
    final List<Map<String, dynamic>> maps =
        await db.query('products', orderBy: 'id DESC');

    return maps.map((map) => Product.fromMap(map)).toList();
  }

  Future<void> deleteProduct(int id) async {
    final Database db = await DatabaseService.instance.database;
    await db.delete(
      'products',
      where: 'id = ?',
      whereArgs: [id],
    );
  }

  Future<void> updateProductStock({
  required int productId,
  required int newStock,
}) async {
  final db = await DatabaseService.instance.database;

  await db.update(
    'products',
    {'stock': newStock},
    where: 'id = ?',
    whereArgs: [productId],
  );
}

}
