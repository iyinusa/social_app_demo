import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:social_app_demo/screens/login_screen.dart';
import '../controllers/auth_controller.dart';
import '../models/user_model.dart';
import '../utils/utils.dart';

class RegistrationScreen extends StatelessWidget {
  const RegistrationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final authController = Provider.of<AuthController>(context);

    String email = "";
    String password = "";
    String username = "";

    return Scaffold(
      appBar: AppBar(
        title: const Text("User Registration"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextField(
              onChanged: (value) => username = value,
              decoration: const InputDecoration(labelText: 'Username'),
            ),
            TextField(
              onChanged: (value) => email = value,
              decoration: const InputDecoration(labelText: 'Email'),
            ),
            TextField(
              onChanged: (value) => password = value,
              obscureText: true,
              decoration: const InputDecoration(labelText: 'Password'),
            ),
            const SizedBox(height: 20),
            Row(
              children: [
                GestureDetector(
                  onTap: () => Utils().navTo(
                    context,
                    const LoginScreen(),
                  ),
                  child: const Text('Login'),
                ),
                const Spacer(),
                ElevatedButton(
                  onPressed: () async {
                    UserModel? newUser = await authController.registerUser(
                        email, password, username);

                    if (newUser != null) {
                      // Registration successful, navigate to the main app interface.
                      // Implement navigation according to your app structure.
                      print("Registration successful: ${newUser.username}");
                    } else {
                      // Handle registration failure.
                      print("Registration failed");
                    }
                  },
                  child: const Text("Register"),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
