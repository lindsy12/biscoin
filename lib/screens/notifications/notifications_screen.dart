import 'package:flutter/material.dart';
import '../../models/debt_model.dart';
import '../../services/debt_service.dart';
import '../../ui/gradient_background.dart';

class NotificationsScreen extends StatelessWidget {
  const NotificationsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,

      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: const Text(
          'Notifications',
          style: TextStyle(color: Colors.white),
        ),
        centerTitle: true,
      ),

      body: GradientBackground(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: _buildContent(), // ✅ YOUR EXISTING LOGIC STAYS
        ),
      ),
    );
  }

  // ⚠️ DO NOT MODIFY – assumed already exists in your file
  Widget _buildContent() {
    // your existing notifications / debts logic here
    return const Center(
      child: Text(
        'No notifications yet',
        style: TextStyle(color: Colors.white),
      ),
    );
  }
}
