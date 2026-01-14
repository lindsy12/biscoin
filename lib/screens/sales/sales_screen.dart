import 'package:flutter/material.dart';
import '../../models/sale_model.dart';
import '../../services/sale_service.dart';

class SalesScreen extends StatelessWidget {
  SalesScreen({super.key});

  final SaleService _saleService = SaleService();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Sales'),
      ),
      body: FutureBuilder<List<Sale>>(
        future: _saleService.getAllSales(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }

          if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return _emptyState();
          }

          final sales = snapshot.data!;

          final double totalSales = sales.fold(
            0,
            (sum, s) => sum + s.totalAmount,
          );

          final double totalProfit = sales.fold(
            0,
            (sum, s) => sum + s.profit,
          );

          return Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // 🔹 Summary cards
                Row(
                  children: [
                    Expanded(
                      child: _summaryCard(
                        title: 'Total Sales',
                        value: '₦${totalSales.toStringAsFixed(0)}',
                        icon: Icons.payments,
                      ),
                    ),
                    const SizedBox(width: 16),
                    Expanded(
                      child: _summaryCard(
                        title: 'Total Profit',
                        value: '₦${totalProfit.toStringAsFixed(0)}',
                        icon: Icons.trending_up,
                        highlight: true,
                      ),
                    ),
                  ],
                ),

                const SizedBox(height: 24),

                const Text(
                  'Sales History',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w600,
                  ),
                ),

                const SizedBox(height: 12),

                Expanded(
                  child: ListView.builder(
                    itemCount: sales.length,
                    itemBuilder: (context, index) {
                      return _saleTile(sales[index]);
                    },
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  // 🔹 Summary card
  Widget _summaryCard({
    required String title,
    required String value,
    required IconData icon,
    bool highlight = false,
  }) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Row(
          children: [
            CircleAvatar(
              backgroundColor:
                  highlight ? Colors.green.shade100 : Colors.purple.shade100,
              child: Icon(
                icon,
                color: highlight ? Colors.green : Colors.purple,
              ),
            ),
            const SizedBox(width: 12),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                    fontSize: 13,
                    color: Colors.grey,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  value,
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  // 🔹 Sale item tile
  Widget _saleTile(Sale sale) {
    return Card(
      margin: const EdgeInsets.only(bottom: 12),
      child: ListTile(
        leading: const Icon(Icons.shopping_cart),
        title: Text(sale.productName),
        subtitle: Text(
          '${sale.quantity} item(s) • ${sale.paymentMethod}',
        ),
        trailing: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Text(
              '₦${sale.totalAmount.toStringAsFixed(0)}',
              style: const TextStyle(fontWeight: FontWeight.w600),
            ),
            Text(
              '+₦${sale.profit.toStringAsFixed(0)}',
              style: const TextStyle(color: Colors.green),
            ),
          ],
        ),
      ),
    );
  }

  // 🔹 Empty state
  Widget _emptyState() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.bar_chart_outlined,
            size: 80,
            color: Colors.grey.shade400,
          ),
          const SizedBox(height: 16),
          const Text(
            'No sales yet',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w600,
            ),
          ),
          const SizedBox(height: 6),
          const Text(
            'Record sales to see reports here',
            style: TextStyle(color: Colors.grey),
          ),
        ],
      ),
    );
  }
}
