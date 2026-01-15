import 'package:flutter/material.dart';
import '../../models/product_model.dart';
import '../../models/sale_model.dart';
import '../products/add_product_screen.dart';
import '../sales/sales_screen.dart';
import '../debts/debts_screen.dart';
import '../../ui/gradient_background.dart';

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
      extendBodyBehindAppBar: true,
      backgroundColor: Colors.transparent,

      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        centerTitle: true,
        title: ShaderMask(
          shaderCallback: (bounds) => const LinearGradient(
            colors: [
              Color(0xFFB39DFF),
              Color(0xFF8E7AFE),
            ],
          ).createShader(bounds),
          child: const Text(
            'Biscoin',
            style: TextStyle(
              color: Color.fromARGB(255, 232, 97, 236),
              fontSize: 22,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
      ),

      body: GradientBackground(
        child: Center(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const Text(
                  'Welcome 👋',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 26,
                    fontWeight: FontWeight.bold,
                  ),
                ),

                const SizedBox(height: 6),

                const Text(
                  'Manage your business easily',
                  style: TextStyle(
                    color: Colors.white70,
                    fontSize: 14,
                  ),
                ),

                const SizedBox(height: 32),

                const Text(
                  'Quick Actions',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 18,
                    fontWeight: FontWeight.w600,
                  ),
                ),

                const SizedBox(height: 20),

                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    _actionCard(
                      icon: Icons.add_box_rounded,
                      label: 'Add Product',
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (_) => const AddProductScreen(),
                          ),
                        );
                      },
                    ),
                    const SizedBox(width: 16),
                    _actionCard(
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
                  ],
                ),

                const SizedBox(height: 16),

                _actionCard(
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
          ),
        ),
      ),
    );
  }

  // 🟣 GLASS CARD — SMALL & CENTERED
  Widget _actionCard({
    required IconData icon,
    required String label,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 150,
        height: 120,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(18),
          gradient: LinearGradient(
            colors: [
              Colors.white.withOpacity(0.15),
      Colors.white.withOpacity(0.05),
            ],
          ),
          border: Border.all(
            color: Colors.white.withOpacity(0.2),
          ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              icon,
              size: 36,
              color: const Color(0xFFB39DFF),
            ),
            const SizedBox(height: 12),
            Text(
              label,
              textAlign: TextAlign.center,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 14,
                fontWeight: FontWeight.w600,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
