import 'package:flutter/material.dart';
import '../views/home_view.dart';
import '../views/profile_view.dart';
import '../views/rutas_view.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int selectIndex = 0; // Variable que cambia dinámicamente

  final screens = [
    HomeScreen(),   // Vista de inicio
    RutasScreen(),  // Vista de rutas
    ProfileScreen() // Vista de perfil
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: IndexedStack(
        index: selectIndex,
        children: screens,
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: selectIndex,
        onTap: (index) {
          setState(() {
            selectIndex = index; // Actualizar el índice
          });
        },
        elevation: 0,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home_outlined),
            activeIcon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.route_outlined),
            activeIcon: Icon(Icons.route),
            label: 'Mis Rutas',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person_2_outlined),
            activeIcon: Icon(Icons.person_2),
            label: 'Perfil',
          ),
        ],
      ),
    );
  }
}
