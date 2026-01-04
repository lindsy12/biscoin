class Product {
  final int? id;
  final String name;
  final int stock;
  final double cost;
  final double price;

  Product({
    this.id,
    required this.name,
    required this.stock,
    required this.cost,
    required this.price,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'stock': stock,
      'cost': cost,
      'price': price,
    };
  }

  factory Product.fromMap(Map<String, dynamic> map) {
    return Product(
      id: map['id'],
      name: map['name'],
      stock: map['stock'],
      cost: map['cost'],
      price: map['price'],
    );
  }
}
