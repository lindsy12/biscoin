import 'package:flutter/material.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xFFD8B4E2), // Lilac
        title: const Text(
          'Biscoin',
          style: TextStyle(
            color: Colors.grey,
            fontWeight: FontWeight.w600,
          ),
        ),
        centerTitle: true,
        elevation: 0,
      ),
      body: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const SizedBox(height: 40),

            const Text(
              'Login',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
              ),
            ),

            const SizedBox(height: 32),

            _inputField(
              label: 'Phone Number',
              icon: Icons.phone,
            ),

            const SizedBox(height: 16),

            _inputField(
              label: 'Password',
              icon: Icons.lock,
              obscureText: true,
            ),

            const SizedBox(height: 32),

            _primaryButton(
              label: 'Login',
              onTap: () {
                // Navigation will be wired later
              },
            ),

            const SizedBox(height: 12),

            _secondaryButton(
              label: 'Sign Up',
              onTap: () {
                // Navigate to Register screen later
              },
            ),
          ],
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
