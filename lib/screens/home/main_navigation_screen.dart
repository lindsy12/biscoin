import 'package:flutter/material.dart';
import '../../models/product_model.dart';
import '../../models/sale_model.dart';
import 'home_screen.dart';
import '../products/products_screen.dart';
import '../notifications/notifications_screen.dart';

class MainNavigationScreen extends StatefulWidget {
  const MainNavigationScreen({super.key});

  @override
  State<MainNavigationScreen> createState() => _MainNavigationScreenState();
}

class _MainNavigationScreenState extends State<MainNavigationScreen> {
  int _currentIndex = 2;

  final List<Product> products = [];
  final List<Sale> sales = [];

  @override
  Widget build(BuildContext context) {
    final screens = [
      const NotificationsScreen(),
      ProductsScreen(
        
      ),
      HomeScreen(
        products: products,
        sales: sales,
      ),
    ];

    return Scaffold(
      body: screens[_currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        onTap: (index) {
          setState(() => _currentIndex = index);
        },
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.notifications),
            label: 'Notifications',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.inventory),
            label: 'Products',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
        ],
      ),
    );
  }
}
