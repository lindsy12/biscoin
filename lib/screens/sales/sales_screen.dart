import 'package:flutter/material.dart';
import '../../models/sale_model.dart';
import '../../services/sale_service.dart';

class SalesScreen extends StatelessWidget {
  SalesScreen({super.key});

  final SaleService _saleService = SaleService();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Sales')),
      body: FutureBuilder<List<Sale>>(
        future: _saleService.getSales(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }

          if (snapshot.hasError) {
            return const Center(child: Text('Error loading sales'));
          }

          final sales = snapshot.data ?? [];

          if (sales.isEmpty) {
            return const Center(child: Text('No sales recorded yet'));
          }

          return Column(
            children: [
              _buildTotals(),
              const Divider(),
              Expanded(
                child: ListView.builder(
                  itemCount: sales.length,
                  itemBuilder: (context, index) {
                    final sale = sales[index];
                    return ListTile(
                      title: Text(sale.productName),
                      subtitle: Text(
                        '${sale.quantity} pcs • ${sale.paymentMethod}',
                      ),
                      trailing: Text(
                        '₦${sale.totalAmount.toStringAsFixed(0)}',
                        style: const TextStyle(fontWeight: FontWeight.bold),
                      ),
                    );
                  },
                ),
              ),
            ],
          );
        },
      ),
    );
  }

  Widget _buildTotals() {
    return FutureBuilder(
      future: Future.wait([
        _saleService.getTotalSales(),
        _saleService.getTotalProfit(),
      ]),
      builder: (context, snapshot) {
        if (!snapshot.hasData) {
          return const Padding(
            padding: EdgeInsets.all(16),
            child: CircularProgressIndicator(),
          );
        }

        final totalSales = snapshot.data![0];
        final totalProfit = snapshot.data![1];

        return Padding(
          padding: const EdgeInsets.all(16),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              _totalCard('Total Sales', totalSales),
              _totalCard('Profit', totalProfit),
            ],
          ),
        );
      },
    );
  }

  Widget _totalCard(String label, double amount) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label, style: const TextStyle(fontWeight: FontWeight.w600)),
        const SizedBox(height: 4),
        Text(
          '₦${amount.toStringAsFixed(0)}',
          style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
      ],
    );
  }
}
