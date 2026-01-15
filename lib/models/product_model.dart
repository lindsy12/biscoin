class Product {
  final int? id;
  final String name;
  final int stock;
  final double price;
  final double cost;
  final String? imagePath; // ✅ NEW (optional)

  Product({
    this.id,
    required this.name,
    required this.stock,
    required this.price,
    required this.cost,
    this.imagePath, // ✅ NEW
  });

  // For SQLite insert
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'stock': stock,
      'price': price,
      'cost': cost,
      'imagePath': imagePath,
    };
  }

  // From SQLite fetch
  factory Product.fromMap(Map<String, dynamic> map) {
    return Product(
      id: map['id'],
      name: map['name'],
      stock: map['stock'],
      price: map['price'],
      cost: map['cost'],
      imagePath: map['imagePath'],
    );
  }
}
