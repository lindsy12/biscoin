import 'package:flutter/material.dart';
import '../../models/product_model.dart';
import '../../services/product_service.dart';

class AddProductScreen extends StatefulWidget {
  const AddProductScreen({super.key});

  @override
  State<AddProductScreen> createState() => _AddProductScreenState();
}

class _AddProductScreenState extends State<AddProductScreen> {
  final _nameController = TextEditingController();
  final _stockController = TextEditingController();
  final _priceController = TextEditingController();
  final _costController = TextEditingController();

  final ProductService _dbService = ProductService();

  void _saveProduct() async {
  final product = Product(
    name: _nameController.text,
    stock: int.parse(_stockController.text),
    price: double.parse(_priceController.text),
    cost: double.parse(_costController.text),
  );

  await _dbService.insertProduct(product);

  if (!mounted) return; // ✅ FIX: protects context

  Navigator.pop(context);
}


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Add Product')),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            TextField(controller: _nameController, decoration: const InputDecoration(labelText: 'Product Name')),
            TextField(controller: _stockController, decoration: const InputDecoration(labelText: 'Quantity'), keyboardType: TextInputType.number),
            TextField(controller: _costController, decoration: const InputDecoration(labelText: 'Cost Price'), keyboardType: TextInputType.number),
            TextField(controller: _priceController, decoration: const InputDecoration(labelText: 'Selling Price'), keyboardType: TextInputType.number),
            const SizedBox(height: 24),
            ElevatedButton(
              onPressed: _saveProduct,
              child: const Text('Add Product'),
            ),
          ],
        ),
      ),
    );
  }
}
