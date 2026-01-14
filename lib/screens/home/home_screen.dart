import 'package:flutter/material.dart';
import '../../models/product_model.dart';
import '../../models/sale_model.dart';
import '../products/add_product_screen.dart';
import '../sales/sales_screen.dart';
import '../debts/debts_screen.dart';

class HomeScreen extends StatelessWidget {
  final List<Product> products;
  final List<Sale> sales;

  const HomeScreen({
    super.key,
    required this.products,
    required this.sales,
  });

  @override
Widget build(BuildContext context) {
  return Scaffold(
    appBar: AppBar(
      title: const Text('Biscoin'),
    ),
    body: SingleChildScrollView(
      padding: const EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 12),

          // 👋 Welcome section
          Text(
            'Welcome 👋',
            style: Theme.of(context).textTheme.headlineMedium,
          ),

          const SizedBox(height: 6),

          Text(
            'Manage your business easily',
            style: Theme.of(context).textTheme.bodySmall,
          ),

          const SizedBox(height: 30),

          // 🔹 Quick actions title
          Text(
            'Quick Actions',
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                  fontWeight: FontWeight.w600,
                ),
          ),

          const SizedBox(height: 16),

          // 🧩 Action cards grid
          GridView.count(
            crossAxisCount: 2,
            crossAxisSpacing: 16,
            mainAxisSpacing: 16,
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            children: [
              _actionCard(
                context,
                icon: Icons.add_box_rounded,
                label: 'Add Product',
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => AddProductScreen(),
                    ),
                  );
                },
              ),
              _actionCard(
                context,
                icon: Icons.bar_chart_rounded,
                label: 'View Sales',
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => SalesScreen(),
                    ),
                  );
                },
              ),
              _actionCard(
                context,
                icon: Icons.credit_card_rounded,
                label: 'Manage Debts',
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => const DebtsScreen(),
                    ),
                  );
                },
              ),
            ],
          ),
        ],
      ),
    ),
  );
}


  // 🟣 MODERN ACTION CARD (UI ONLY)
  Widget _actionCard(
  BuildContext context, {
  required IconData icon,
  required String label,
  required VoidCallback onTap,
}) {
  return GestureDetector(
    onTap: onTap,
    child: Card(
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 24),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              icon,
              size: 42,
              color: Theme.of(context).colorScheme.primary,
            ),
            const SizedBox(height: 14),
            Text(
              label,
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    fontWeight: FontWeight.w600,
                  ),
            ),
          ],
        ),
      ),
    ),
  );
}
}