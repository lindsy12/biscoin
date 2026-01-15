import 'dart:io';
import 'package:flutter/material.dart';
import '../../models/product_model.dart';
import '../../services/product_service.dart';
import 'package:image_picker/image_picker.dart';

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
  File? _imageFile;
final ImagePicker _picker = ImagePicker();


Future<void> _openCamera() async {
  final XFile? photo = await _picker.pickImage(
    source: ImageSource.camera,
    imageQuality: 80,
  );

  if (photo != null) {
    setState(() {
      _imageFile = File(photo.path);
    });
  }
}


void _saveProduct() async {
  debugPrint('Save product tapped');
  
  try {
    // Validate fields
    if (_nameController.text.isEmpty ||
        _stockController.text.isEmpty ||
        _priceController.text.isEmpty ||
        _costController.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please fill all fields')),
      );
      return;
    }

    debugPrint('Name: ${_nameController.text}');
    debugPrint('Stock: ${_stockController.text}');
    debugPrint('Cost: ${_costController.text}');
    debugPrint('Price: ${_priceController.text}');

    // Create product
    final product = Product(
      name: _nameController.text,
      stock: int.parse(_stockController.text),
      price: double.parse(_priceController.text),
      cost: double.parse(_costController.text),
      imagePath: _imageFile?.path, // ✅ ADDED
    );

    debugPrint('Product object created: ${product.toMap()}');

    // Insert into database
    final id = await _dbService.insertProduct(product);
    debugPrint('Product inserted with ID: $id');

    // Show success message
    if (mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Product added successfully!'),
          backgroundColor: Colors.green,
        ),
      );

      // Navigate back to products screen
      Navigator.pop(context, true); // Pass true to indicate success
    }
  } catch (e) {
    debugPrint('ERROR saving product: $e');
    if (mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Error: $e'),
          backgroundColor: Colors.red,
        ),
      );
    }
  }
}


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Add Product')),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          
          children: [
            GestureDetector(
  onTap: _openCamera,
  child: Container(
    height: 160,
    width: double.infinity,
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(16),
      color: Colors.grey.shade200,
      image: _imageFile != null
          ? DecorationImage(
              image: FileImage(_imageFile!),
              fit: BoxFit.cover,
            )
          : null,
    ),
    child: _imageFile == null
        ? Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: const [
              Icon(Icons.camera_alt, size: 40),
              SizedBox(height: 8),
              Text('Tap to take product photo'),
            ],
          )
        : null,
  ),
),
const SizedBox(height: 16),

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