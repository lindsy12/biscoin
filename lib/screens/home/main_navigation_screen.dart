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
    setState(() {
      _currentIndex = index;
    });
  },
  type: BottomNavigationBarType.fixed,
  selectedItemColor: const Color(0xFF8E7AFE), // lilac
  unselectedItemColor: Colors.grey,
  selectedLabelStyle: const TextStyle(
    fontWeight: FontWeight.w600,
  ),
  unselectedLabelStyle: const TextStyle(
    fontWeight: FontWeight.w500,
  ),
  items: const [
    BottomNavigationBarItem(
      icon: Icon(Icons.notifications_outlined),
      activeIcon: Icon(Icons.notifications),
      label: 'Alerts',
    ),
    BottomNavigationBarItem(
      icon: Icon(Icons.inventory_2_outlined),
      activeIcon: Icon(Icons.inventory_2),
      label: 'Products',
    ),
    BottomNavigationBarItem(
      icon: Icon(Icons.home_outlined),
      activeIcon: Icon(Icons.home),
      label: 'Home',
    ),
  ],
),

    );
  }
}
