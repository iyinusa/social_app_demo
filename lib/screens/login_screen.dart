import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:social_app_demo/utils/utils.dart';
import '../controllers/auth_controller.dart';
import '../models/user_model.dart';
import 'search_screen.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  @override
  Widget build(BuildContext context) {
    final authController = Provider.of<AuthController>(context);

    String email = "";
    String password = "";

    goToSearch() {
      Utils().navTo(context, const SearchScreen());
    }

    loginUser() async {
      UserModel? user = await authController.loginUser(email, password);

      if (user != null) {
        // Login successful, navigate to the main app interface.
        // Implement navigation according to your app structure.
        print("Login successful: ${user.email}");
        goToSearch();
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
