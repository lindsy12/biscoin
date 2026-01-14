import 'package:flutter/material.dart';
import '../../models/debt_model.dart';
import '../../services/debt_service.dart';

class DebtsScreen extends StatefulWidget {
  const DebtsScreen({super.key});

  @override
  State<DebtsScreen> createState() => _DebtsScreenState();
}

class _DebtsScreenState extends State<DebtsScreen> {
  final DebtService _debtService = DebtService();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Debts'),
      ),
      body: FutureBuilder<List<Debt>>(
        future: _debtService.getUnpaidDebts(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }

          if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return _emptyState();
          }

          final debts = snapshot.data!;

          return ListView.builder(
            padding: const EdgeInsets.all(16),
            itemCount: debts.length,
            itemBuilder: (context, index) {
              return _debtCard(debts[index]);
            },
          );
        },
      ),
    );
  }

  // 🔹 Debt card
  Widget _debtCard(Debt debt) {
    return Card(
      margin: const EdgeInsets.only(bottom: 12),
      child: ListTile(
        leading: CircleAvatar(
          backgroundColor: debt.isPaid
              ? Colors.green.shade100
              : Colors.red.shade100,
          child: Icon(
            debt.isPaid ? Icons.check : Icons.warning,
            color: debt.isPaid ? Colors.green : Colors.red,
          ),
        ),
        title: Text(
          debt.customerName,
          style: const TextStyle(fontWeight: FontWeight.w600),
        ),
        subtitle: Text(
          '₦${debt.amount.toStringAsFixed(0)} • ${debt.dueDate}',
        ),
        trailing: debt.isPaid
            ? const Text(
                'PAID',
                style: TextStyle(
                  color: Colors.green,
                  fontWeight: FontWeight.bold,
                ),
              )
            : ElevatedButton(
                onPressed: () async {
                  await _debtService.markDebtAsPaid(debt.id!);
                  setState(() {});
                },
                child: const Text('Mark Paid'),
              ),
      ),
    );
  }

  // 🔹 Empty state
  Widget _emptyState() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.credit_card_off,
            size: 80,
            color: Colors.grey.shade400,
          ),
          const SizedBox(height: 16),
          const Text(
            'No debts recorded',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w600,
            ),
          ),
          const SizedBox(height: 6),
          const Text(
            'Customer debts will appear here',
            style: TextStyle(color: Colors.grey),
          ),
        ],
      ),
    );
  }
}
