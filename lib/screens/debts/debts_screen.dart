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
  late Future<List<Debt>> _debtsFuture;

  @override
  void initState() {
    super.initState();
    _debtsFuture = _debtService.getUnpaidDebts();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Debts')),
      body: FutureBuilder<List<Debt>>(
        future: _debtsFuture,
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return const Center(child: CircularProgressIndicator());
          }

          final debts = snapshot.data!;
          if (debts.isEmpty) {
            return const Center(child: Text('No unpaid debts'));
          }

          return ListView.builder(
            itemCount: debts.length,
            itemBuilder: (_, i) {
              final d = debts[i];
              return ListTile(
                title: Text(d.customerName),
                subtitle: Text('₦${d.amount} — Due ${d.dueDate.toLocal()}'),
                trailing: IconButton(
                  icon: const Icon(Icons.check, color: Colors.green),
                  onPressed: () async {
                    await _debtService.markDebtAsPaid(d.id!);
                    setState(() {
                      _debtsFuture = _debtService.getUnpaidDebts();
                    });
                  },
                ),
              );
            },
          );
        },
      ),
    );
  }
}
