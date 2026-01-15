import 'package:flutter/material.dart';
import '../../models/sale_model.dart';
import '../../services/sale_service.dart';
import '../../ui/gradient_background.dart';

class SalesScreen extends StatelessWidget {
  SalesScreen({super.key});

  final SaleService _saleService = SaleService();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      appBar: AppBar(
  backgroundColor: Colors.transparent,
  elevation: 0,
  surfaceTintColor: Colors.transparent, // ⭐ IMPORTANT
  shadowColor: Colors.transparent,      // ⭐ IMPORTANT
  title: ShaderMask(
    shaderCallback: (bounds) {
      return const LinearGradient(
        colors: [
          Color(0xFF8E7AFE), // soft purple
          Color(0xFFC7BFFF), // lighter lilac
        ],
      ).createShader(bounds);
    },
    child: const Text(
      'Sales',
      style: TextStyle(
        color: Colors.white, // required for ShaderMask
        fontWeight: FontWeight.w600,
      ),
    ),
  ),
  centerTitle: true,
),

      body: GradientBackground(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: FutureBuilder<List<Sale>>(
            future: _saleService.getAllSales(),
            builder: (context, snapshot) {
              if (!snapshot.hasData) {
                return const Center(
                  child: CircularProgressIndicator(color: Colors.white),
                );
              }

              final sales = snapshot.data!;
              final totalSales = sales.fold<double>(
                0,
                (sum, s) => sum + s.totalAmount,
              );
              final totalProfit = sales.fold<double>(
                0,
                (sum, s) => sum + s.profit,
              );

              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // 🔹 SUMMARY CARDS
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

                  // 🔹 SALES LIST
                  Expanded(
                    child: sales.isEmpty
                        ? _emptyState()
                        : ListView.builder(
                            itemCount: sales.length,
                            itemBuilder: (context, index) {
                              return _saleTile(sales[index]);
                            },
                          ),
                  ),
                ],
              );
            },
          ),
        ),
      ),
    );
  }

  // 🟣 Summary Card
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
                  style: const TextStyle(fontSize: 13, color: Colors.grey),
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

  // 🧾 Sale Tile
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

  Widget _emptyState() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.bar_chart_outlined,
            size: 80,
            color: Colors.white.withValues(alpha: 0.5),
          ),
          const SizedBox(height: 16),
          const Text(
            'No sales yet',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w600,
              color: Colors.white,
            ),
          ),
        ],
      ),
    );
  }
}
