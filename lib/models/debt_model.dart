class Debt {
  final int? id;
  final String customerName;
  final String phone;
  final double amount;
  final DateTime dueDate;
  final bool isPaid;

  Debt({
    this.id,
    required this.customerName,
    required this.phone,
    required this.amount,
    required this.dueDate,
    this.isPaid = false,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'customerName': customerName,
      'phone': phone,
      'amount': amount,
      'dueDate': dueDate.toIso8601String(),
      'isPaid': isPaid ? 1 : 0,
    };
  }

  factory Debt.fromMap(Map<String, dynamic> map) {
    return Debt(
      id: map['id'],
      customerName: map['customerName'],
      phone: map['phone'],
      amount: map['amount'],
      dueDate: DateTime.parse(map['dueDate']),
      isPaid: map['isPaid'] == 1,
    );
  }
}
