import 'package:flutter/material.dart';
import 'package:frontend/services/api_service.dart'; // غيّر حسب اسم مشروعك

class SignUpPage extends StatefulWidget {
  const SignUpPage({super.key});

  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  final nameController = TextEditingController();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final dobController = TextEditingController();

  bool isLoading = false;
  String errorMessage = '';

  Future<void> handleSignup() async {
    setState(() {
      isLoading = true;
      errorMessage = '';
    });

    try {
      final response = await signup(
        nameController.text.trim(),
        emailController.text.trim(),
        passwordController.text.trim(),
        dobController.text.trim(),
      );

      if (response.containsKey('user')) {
        Navigator.pushReplacementNamed(context, '/login');
      } else {
        setState(() => errorMessage = response['message'] ?? 'Signup failed');
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
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 40),
              Text('Create Account', style: Theme.of(context).textTheme.headlineLarge),
              const SizedBox(height: 8),
              Row(
                children: [
                  const Text('Already have an account?'),
                  TextButton(
                    onPressed: () => Navigator.pushReplacementNamed(context, '/login'),
                    child: const Text('Log in'),
                  ),
                ],
              ),
              const SizedBox(height: 25),
              TextField(
                controller: nameController,
                decoration: const InputDecoration(labelText: 'Name'),
              ),
              const SizedBox(height: 15),
              TextField(
                controller: emailController,
                decoration: const InputDecoration(labelText: 'Email'),
              ),
              const SizedBox(height: 15),
              TextField(
                controller: passwordController,
                obscureText: true,
                decoration: const InputDecoration(labelText: 'Password'),
              ),
              const SizedBox(height: 15),
              TextField(
                controller: dobController,
                decoration: const InputDecoration(labelText: 'Date of Birth'),
              ),
              const SizedBox(height: 20),
              if (errorMessage.isNotEmpty)
                Text(errorMessage, style: const TextStyle(color: Colors.red)),
              const SizedBox(height: 10),
              ElevatedButton(
                onPressed: isLoading ? null : handleSignup,
                style: ElevatedButton.styleFrom(minimumSize: const Size.fromHeight(50)),
                child: isLoading
                    ? const CircularProgressIndicator(color: Colors.white)
                    : const Text('Sign up', style: TextStyle(fontSize: 16)),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
