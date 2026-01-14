import 'package:flutter/material.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
Widget build(BuildContext context) {
  return Scaffold(
    body: SafeArea(
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const SizedBox(height: 40),

            // App name
            Text(
              'Biscoin',
              style: Theme.of(context).textTheme.headlineMedium,
            ),

            const SizedBox(height: 8),

            // Intro text
            Text(
              'Manage your business smartly',
              style: Theme.of(context).textTheme.bodySmall,
            ),

            const SizedBox(height: 40),

            // Email
            TextField(
              decoration: const InputDecoration(
                hintText: 'Email',
              ),
            ),

            const SizedBox(height: 16),

            // Password
            TextField(
              obscureText: true,
              decoration: const InputDecoration(
                hintText: 'Password',
              ),
            ),

            const SizedBox(height: 28),

            // Login button
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () {
                  // KEEP YOUR EXISTING LOGIN LOGIC HERE
                },
                child: const Text('Login'),
              ),
            ),

            const SizedBox(height: 16),

            // Register link
            TextButton(
              onPressed: () {
                // Navigator to Register screen
              },
              child: const Text('Create an account'),
            ),
          ],
        ),
      ),
    ),
  );
}


  // 🔹 SMALL ROUNDED TEXT FIELD
  Widget _inputField({
    required String label,
    required IconData icon,
    bool obscureText = false,
  }) {
    return TextField(
      obscureText: obscureText,
      decoration: InputDecoration(
        labelText: label,
        prefixIcon: Icon(icon),
        isDense: true,
        contentPadding:
            const EdgeInsets.symmetric(vertical: 14, horizontal: 16),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(20),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(20),
          borderSide: BorderSide(color: Colors.grey.shade400),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(20),
          borderSide: const BorderSide(color: Colors.purple),
        ),
      ),
    );
  }

  // 🟣 PRIMARY BUTTON (PURPLE)
  Widget _primaryButton({
    required String label,
    required VoidCallback onTap,
  }) {
    return SizedBox(
      height: 42,
      child: ElevatedButton(
        onPressed: onTap,
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.purple,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
        ),
        child: Text(label),
      ),
    );
  }

  // ⚪ SECONDARY BUTTON (OUTLINED)
  Widget _secondaryButton({
    required String label,
    required VoidCallback onTap,
  }) {
    return SizedBox(
      height: 42,
      child: OutlinedButton(
        onPressed: onTap,
        style: OutlinedButton.styleFrom(
          foregroundColor: Colors.purple,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
          side: const BorderSide(color: Colors.purple),
        ),
        child: Text(label),
      ),
    );
  }
}
