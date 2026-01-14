import 'package:flutter/material.dart';
import '../../models/product_model.dart';
import '../../services/product_service.dart';
import 'sell_product_sheet.dart';
import 'add_product_screen.dart';


class ProductsScreen extends StatefulWidget {
  const ProductsScreen({super.key});

  @override
  State<ProductsScreen> createState() => _ProductsScreenState();
}

class _ProductsScreenState extends State<ProductsScreen> {
  final ProductService _dbService = ProductService();
  List<Product> products = [];

  @override
  void initState() {
    super.initState();
    _loadProducts();
  }

  void _loadProducts() async {
    final data = await _dbService.getProducts();
    setState(() {
      products = data;
    });
  }

  @override
Widget build(BuildContext context) {
  return Scaffold(
    appBar: AppBar(
      title: const Text('Products'),
      actions: [
        IconButton(
          icon: const Icon(Icons.add),
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (_) => const AddProductScreen(),
              ),
            );
          },
        ),
      ],
    ),
    body: products.isEmpty
        ? _emptyState(context)
        : ListView.builder(
            padding: const EdgeInsets.all(16),
            itemCount: products.length,
            itemBuilder: (context, index) {
              return _productCard(context, products[index]);
            },
          ),
  );
}
Widget _emptyState(BuildContext context) {
  return Center(
    child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Icon(
          Icons.inventory_2_outlined,
          size: 80,
          color: Colors.grey.shade400,
        ),
        const SizedBox(height: 16),
        const Text(
          'No products yet',
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.w600,
          ),
        ),
        const SizedBox(height: 6),
        const Text(
          'Tap + to add your first product',
          style: TextStyle(color: Colors.grey),
        ),
      ],
    ),
  );
}
Widget _productCard(BuildContext context, Product product) {
  final bool lowStock = product.stock <= 5;

  return Card(
  margin: const EdgeInsets.only(bottom: 16),
  shape: RoundedRectangleBorder(
    borderRadius: BorderRadius.circular(16),
    side: BorderSide(
      color: lowStock ? Colors.redAccent : Colors.transparent,
      width: 1.4,
    ),
  ),
  child: Padding(
    padding: const EdgeInsets.all(16),

      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // 🔹 Top row: name + sell
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: Text(
                  product.name,
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
              ElevatedButton(
  style: ElevatedButton.styleFrom(
    padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(12),
    ),
  ),
  onPressed: () {
    _showSellBottomSheet(context, product);
  },
  child: const Text('Sell'),
),

            ],
          ),

          const SizedBox(height: 12),

          // 🔹 Stock
          Row(
            children: [
              Icon(
                Icons.storage,
                size: 18,
                color: lowStock ? Colors.red : Colors.grey,
              ),
              const SizedBox(width: 6),
              Text(
                'Stock: ${product.stock}',
                style: TextStyle(
                  color: lowStock ? Colors.red : Colors.grey.shade700,
                  fontWeight: FontWeight.w500,
                ),
              ),
              if (lowStock) ...[
                const SizedBox(width: 6),
                const Text('⚠️ Low', style: TextStyle(color: Colors.red)),
              ],
            ],
          ),

          const SizedBox(height: 10),

          // 🔹 Prices
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              _priceColumn('Cost', product.cost),
              _priceColumn('Price', product.price),
              _priceColumn(
                'Profit',
                product.price - product.cost,
                highlight: true,
              ),
            ],
          ),
        ],
      ),
    ),
  );
}
Widget _priceColumn(String label, double value, {bool highlight = false}) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Text(
        label,
        style: const TextStyle(fontSize: 12, color: Colors.grey),
      ),
      const SizedBox(height: 4),
      Text(
        '₦${value.toStringAsFixed(0)}',
        style: TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.w600,
          color: highlight ? Colors.green : Colors.black,
        ),
      ),
    ],
  );
}

void _showSellBottomSheet(BuildContext context, Product product) {
  showModalBottomSheet(
    context: context,
    isScrollControlled: true,
    builder: (_) {
      return SellProductSheet(product: product);
    },
  );
}


}
