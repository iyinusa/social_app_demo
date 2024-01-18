import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../controllers/auth_controller.dart';
import '../models/user_model.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final authController = Provider.of<AuthController>(context);

    String email = "";
    String password = "";

    loginUser() async {
      UserModel? user = await authController.loginUser(email, password);

      if (user != null) {
        // Login successful, navigate to the main app interface.
        // Implement navigation according to your app structure.
        print("Login successful: ${user.email}");
      } else {
        // Handle login failure.
        print("Login failed");
      }
    }

    return Scaffold(
      appBar: AppBar(
        title: Text("User Login"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextField(
              onChanged: (value) => email = value,
              decoration: InputDecoration(labelText: 'Email'),
            ),
            TextField(
              onChanged: (value) => password = value,
              obscureText: true,
              decoration: InputDecoration(labelText: 'Password'),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () async {
                loginUser();
              },
              child: Text("Login"),
            ),
          ],
        ),
      ),
    );
  }
}
