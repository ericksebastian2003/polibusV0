import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'screens/main_screen.dart';
import 'screens/login_screen.dart';
import 'screens/register_screen.dart';
import 'firebase_options.dart';
import 'package:firebase_auth/firebase_auth.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  try {
    await Firebase.initializeApp(
      options: DefaultFirebaseOptions.currentPlatform,
    );
  } catch (e) {
    debugPrint("Error initializing Firebase: $e");
  }
  runApp(const MyApp());
}

// Clase principal
class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Poli Bus', // Título de la aplicación
      theme: ThemeData.dark(), // Tema oscuro
      initialRoute: '/', // Ruta inicial
      routes: {
        '/': (context) => const AuthStreamBuilder(), // Manejo de autenticación
        '/register': (context) => const RegisterScreen(), // Pantalla de registro
        '/home': (context) => const MainScreen(), // Pantalla principal
      },
    );
  }
}

// Clase AuthStreamBuilder para gestionar el estado de autenticación
class AuthStreamBuilder extends StatelessWidget {
  const AuthStreamBuilder({super.key});

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<User?>(
      stream: FirebaseAuth.instance.authStateChanges(), // Cambios en autenticación
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }

        if (snapshot.hasError) {
          return const Center(
            child: Text('Error al cargar la aplicación'),
          );
        }

        if (snapshot.hasData) {
          // Usuario autenticado, redirigir a la pantalla principal
          return const MainScreen();
        } else {
          // No autenticado, redirigir al login
          return const LoginScreen();
        }
      },
    );
  }
}
