import 'package:flutter/material.dart';
import '../../models/debt_model.dart';
import '../../services/debt_service.dart';

class NotificationsScreen extends StatelessWidget {
  const NotificationsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Notifications')),
      body: FutureBuilder<List<Debt>>(
        future: DebtService().getDebtsDueToday(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return const Center(child: CircularProgressIndicator());
          }

          final debts = snapshot.data!;
          if (debts.isEmpty) {
            return const Center(child: Text('No notifications'));
          }

          return ListView(
            children: debts.map((d) {
              return ListTile(
                leading: const Icon(Icons.warning, color: Colors.red),
                title: Text('${d.customerName} owes ₦${d.amount}'),
                subtitle: const Text('Due today'),
              );
            }).toList(),
          );
        },
      ),
    );
  }
}
