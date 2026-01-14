import 'package:flutter/material.dart';

class RegisterScreen extends StatelessWidget {
  const RegisterScreen({super.key});

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
              'Create your business account',
              style: Theme.of(context).textTheme.bodySmall,
            ),

            const SizedBox(height: 40),

            // Business / Username
            TextField(
              decoration: const InputDecoration(
                hintText: 'Business name',
              ),
            ),

            const SizedBox(height: 16),

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

            const SizedBox(height: 16),

            // Confirm Password
            TextField(
              obscureText: true,
              decoration: const InputDecoration(
                hintText: 'Confirm password',
              ),
            ),

            const SizedBox(height: 28),

            // Register button
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () {
                  // KEEP YOUR EXISTING REGISTER LOGIC HERE
                },
                child: const Text('Create Account'),
              ),
            ),

            const SizedBox(height: 16),

            // Back to login
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: const Text('Already have an account? Login'),
            ),
          ],
        ),
      ),
    ),
  );
}

}
