import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:provider/provider.dart';
import 'package:google_sign_in_dartio/google_sign_in_dartio.dart';
import 'controllers/auth_controller.dart';
import 'controllers/search_controller.dart';
import 'screens/registration_screen.dart';
import 'screens/login_screen.dart';

import 'firebase_options.dart';
import 'screens/search_screen.dart';

/// Requires that a Firebase local emulator is running locally.
bool shouldUseFirebaseEmulator = false;

late final FirebaseApp app;
late final FirebaseAuth auth;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  // Store the app and auth to make testing with a named instance easier.
  app = await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  auth = FirebaseAuth.instanceFor(app: app);

  if (shouldUseFirebaseEmulator) {
    await auth.useAuthEmulator('localhost', 9099);
  }

  if (!kIsWeb && Platform.isWindows) {
    await GoogleSignInDart.register(
      clientId:
          '406099696497-g5o9l0blii9970bgmfcfv14pioj90djd.apps.googleusercontent.com',
    );
  }
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<AuthController>(create: (_) => AuthController()),
        ChangeNotifierProvider<SearchesController>(
            create: (_) => SearchesController()),
        // Add other providers as needed.
      ],
      child: MaterialApp(
        title: 'Social App Prototype',
        theme: ThemeData(
          primarySwatch: Colors.green,
        ),
        home: const SearchScreen(),
        routes: {
          '/login': (context) => const LoginScreen(),
          '/register': (context) => const RegistrationScreen(),
          '/search': (context) => const SearchScreen(),
          // Add more routes for other screens as needed.
        },
      ),
    );
  }
}
