import 'package:flutter/material.dart';
import 'package:frontend/services/api_service.dart'; // غيّر اسم الباكيج حسب مشروعك
import 'package:shared_preferences/shared_preferences.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  bool isLoading = false;
  String errorMessage = '';

  Future<void> handleLogin() async {
    setState(() {
      isLoading = true;
      errorMessage = '';
    });

    try {
      final response = await login(
        emailController.text.trim(),
        passwordController.text.trim(),
      );

      if (response.containsKey('token')) {
        await saveToken(response['token']);
        Navigator.pushReplacementNamed(context, '/profile');
      } else {
        setState(() => errorMessage = response['message'] ?? 'Login failed');
      }
    } catch (e) {
      setState(() => errorMessage = 'Error: $e');
    }

    setState(() => isLoading = false);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(30),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 20),
            Text('Welcome Back!', style: Theme.of(context).textTheme.headlineLarge),
            const SizedBox(height: 12),
            const Text('Sign in to continue.'),
            const SizedBox(height: 40),
            TextField(
              controller: emailController,
              decoration: const InputDecoration(labelText: 'Email'),
            ),
            const SizedBox(height: 10),
            TextField(
              controller: passwordController,
              obscureText: true,
              decoration: const InputDecoration(labelText: 'Password'),
            ),
            const SizedBox(height: 20),
            if (errorMessage.isNotEmpty)
              Text(errorMessage, style: const TextStyle(color: Colors.red)),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: isLoading ? null : handleLogin,
              style: ElevatedButton.styleFrom(minimumSize: const Size.fromHeight(50)),
              child: isLoading
                  ? const CircularProgressIndicator(color: Colors.white)
                  : const Text('Log in', style: TextStyle(fontSize: 16)),
            ),
            const SizedBox(height: 24),
            Row(
              children: [
                const Text("Don't have an account?"),
                TextButton(
                  onPressed: () => Navigator.pushNamed(context, '/signup'),
                  child: const Text('Signup'),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
