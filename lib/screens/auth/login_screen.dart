import 'package:flutter/material.dart';
import '../../ui/gradient_background.dart';
import '../home/main_navigation_screen.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: GradientBackground(
        child: Center(
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 28),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  // 🟣 App Name
                  const Text(
                    'Biscoin',
                    style: TextStyle(
                      fontSize: 40,
                      fontWeight: FontWeight.bold,
                      letterSpacing: 1.2,
                      color: Color.fromARGB(255, 88, 40, 150),
                      fontFamily: 'Poppins',
                    ),
                  ),

                  const SizedBox(height: 14),

                  // ✨ Tagline (BIGGER & ENERGETIC)
                  const Text(
                    'Your business, simplified',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 20, // ⬆ increased
                      fontWeight: FontWeight.w500,
                      color: Colors.white70,
                      fontFamily: 'Poppins',
                    ),
                  ),

                  const SizedBox(height: 48),

                  // 📧 Email
                  TextField(
                    decoration: InputDecoration(
                      hintText: 'Email',
                      prefixIcon: const Icon(Icons.email_outlined),
                    ),
                  ),

                  const SizedBox(height: 16),

                  // 🔒 Password
                  TextField(
                    obscureText: true,
                    decoration: InputDecoration(
                      hintText: 'Password',
                      prefixIcon: const Icon(Icons.lock_outline),
                    ),
                  ),

                  const SizedBox(height: 28),

                  // 🔘 Login Button
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: () {
                        Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                            builder: (_) => const MainNavigationScreen(),
                          ),
                        );
                      },
                      child: const Text('Login'),
                    ),
                  ),

                  const SizedBox(height: 18),

                  // ➕ Register link
                  TextButton(
                    onPressed: () {
                      // navigate to register later
                    },
                    child: const Text(
                      'Create an account',
                      style: TextStyle(
                        color: Color.fromARGB(255, 238, 64, 223),
                        fontFamily: 'Poppins',
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
