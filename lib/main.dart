import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';

import 'services/auth_service.dart';
import 'screens/login_screen.dart';
import 'screens/register_screen.dart';
import 'screens/home_screen.dart';

import 'firebase_options.dart';
import 'package:firebase_auth/firebase_auth.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}
// Clase principal
class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Poli Bus',  // Título de la aplicación
      theme: ThemeData.dark(),  // Establece el tema de la aplicación (oscuro)
      initialRoute: '/',  // Establece la ruta inicial
      routes: {
        '/': (context) => AuthStreamBuilder(),  // AuthStreamBuilder manejará la lógica de login y home
        '/login': (context) => LoginScreen(),  // Ruta para la pantalla de login
        '/register': (context) => RegisterScreen(),  // Ruta para la pantalla de registro
        '/home': (context) => HomeScreen(),  // Ruta para la pantalla principal (Home)
      },
    );
  }
}

// Clase AuthStreamBuilder para gestionar el estado de autenticación
class AuthStreamBuilder extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder<User?>(
      stream: FirebaseAuth.instance.authStateChanges(),  // Observa los cambios en el estado de autenticación
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(  // Muestra un indicador de carga mientras espera la respuesta
            child: CircularProgressIndicator(),
          );
        }

        if (snapshot.hasError) {
          return const Center(  // Muestra un mensaje de error si ocurre un problema
            child: Text('Algo salió mal'),
          );
        }

        if (snapshot.hasData) {
          // Si el usuario está autenticado, redirigimos a la pantalla principal (Home)
          return  HomeScreen();
        } else {
          // Si no hay usuario autenticado, redirigimos a la pantalla de login
          return  LoginScreen();
        }
      },
    );
  }
}
