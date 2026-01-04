import 'package:flutter/material.dart';
import 'services/database_service.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  final db = await DatabaseService.instance.database;
 

  debugPrint('DATABASE PATH: ${db.path}');

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        body: Center(
          child: Text('Database Test'),
        ),
      ),
    );
  }
}
