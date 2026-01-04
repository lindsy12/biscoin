import 'package:flutter/material.dart';
import '../../models/product_model.dart';
import '../../services/product_service.dart';
import 'sell_product_sheet.dart';

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
      appBar: AppBar(title: const Text('Products')),
      body: products.isEmpty
          ? const Center(child: Text('No products yet'))
          : ListView.builder(
              itemCount: products.length,
              itemBuilder: (_, index) {
                final product = products[index];
                return Card(
                  child: ListTile(
                    title: Text(product.name),
                    subtitle: Text('Stock: ${product.stock}'),
                    trailing: ElevatedButton(
                      child: const Text('Sell'),
                      onPressed: () {
                        showModalBottomSheet(
                          context: context,
                          builder: (_) => SellProductSheet(product: product),
                        ).then((_) => _loadProducts());
                      },
                    ),
                  ),
                );
              },
            ),
    );
  }
}
