import 'package:flutter/material.dart';

class GradientBackground extends StatelessWidget {
  final Widget child;

  const GradientBackground({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            Color.fromARGB(255, 18, 15, 48),
            Color.fromARGB(255, 42, 38, 83),
            Color.fromARGB(255, 71, 46, 92),
          ],
        ),
      ),
      child: child,
    );
  }
}
