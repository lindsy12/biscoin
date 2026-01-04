class Sale {
  final int? id;
  final String productName;
  final int quantity;
  final double totalAmount;
  final double profit;
  final String paymentMethod;
  final DateTime date;

  Sale({
    this.id,
    required this.productName,
    required this.quantity,
    required this.totalAmount,
    required this.profit,
    required this.paymentMethod,
    required this.date,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'productName': productName,
      'quantity': quantity,
      'totalAmount': totalAmount,
      'profit': profit,
      'paymentMethod': paymentMethod,
      'date': date.toIso8601String(),
    };
  }

  factory Sale.fromMap(Map<String, dynamic> map) {
    return Sale(
      id: map['id'],
      productName: map['productName'],
      quantity: map['quantity'],
      totalAmount: map['totalAmount'],
      profit: map['profit'],
      paymentMethod: map['paymentMethod'],
      date: DateTime.parse(map['date']),
    );
  }
}
