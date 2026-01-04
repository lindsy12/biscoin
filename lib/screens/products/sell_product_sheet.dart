import 'package:flutter/material.dart';
import '../../models/product_model.dart';
import '../../models/debt_model.dart';
import '../../services/product_service.dart';
import '../../services/debt_service.dart';

class SellProductSheet extends StatefulWidget {
  final Product product;

  const SellProductSheet({super.key, required this.product});

  @override
  State<SellProductSheet> createState() => _SellProductSheetState();
}

class _SellProductSheetState extends State<SellProductSheet> {
  final _qtyController = TextEditingController();
  String _paymentMethod = 'Cash';

  final ProductService _productService = ProductService();
  final DebtService _debtService = DebtService();

  Future<void> _recordSale() async {
    final qty = int.tryParse(_qtyController.text);
    if (qty == null || qty <= 0) return;
    if (qty > widget.product.stock) return;

    final newStock = widget.product.stock - qty;
    await _productService.updateProductStock(
      productId: widget.product.id!,
      newStock: newStock,
    );

    if (_paymentMethod == 'Credit') {
      await _debtService.insertDebt(
        Debt(
          customerName: 'Unknown Customer',
          phone: '000000000',
          amount: qty * widget.product.price,
          dueDate: DateTime.now().add(const Duration(days: 7)),
        ),
      );
    }

    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
        left: 16,
        right: 16,
        bottom: MediaQuery.of(context).viewInsets.bottom + 16,
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text('Sell ${widget.product.name}'),
          TextField(
            controller: _qtyController,
            keyboardType: TextInputType.number,
            decoration: const InputDecoration(labelText: 'Quantity'),
          ),
          const SizedBox(height: 12),
          DropdownButtonFormField<String>(
            value: _paymentMethod,
            items: const [
              DropdownMenuItem(value: 'Cash', child: Text('Cash')),
              DropdownMenuItem(value: 'Credit', child: Text('Credit')),
            ],
            onChanged: (v) => setState(() => _paymentMethod = v!),
          ),
          const SizedBox(height: 16),
          ElevatedButton(
            onPressed: _recordSale,
            child: const Text('Confirm Sale'),
          ),
        ],
      ),
    );
  }
}
