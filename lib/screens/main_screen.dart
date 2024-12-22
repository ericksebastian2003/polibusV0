import 'package:flutter/material.dart';
import '../views/home_view.dart';
import '../views/profile_view.dart';
import '../views/rutas_view.dart';
import '../views/carnet_view.dart';
import '../views/notifications_view.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int selectIndex = 0; // Índice seleccionado

  final List<Widget> screens = [
     HomeView(),   // Vista de inicio
     RutasView(),  // Vista de rutas
     CarnetView(), // Vista de carnet
     NotificationsView(),
     ProfileView(), // Vista de perfil
  ];

  @override
  Widget build(BuildContext context) {
    //Esqueleto
    return Scaffold(
      body: IndexedStack(
        index: selectIndex,
        children: screens,
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: selectIndex,
        onTap: (index) {
          setState(() {
            selectIndex = index;
          });
        },
        elevation: 0,
        type: BottomNavigationBarType.fixed, // Fijo para mantener íconos alineados
        selectedItemColor: Colors.blueAccent,
        unselectedItemColor: Colors.grey,
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
            icon: Icon(Icons.qr_code_2_outlined),
            activeIcon: Icon(Icons.qr_code_2),
            label: 'Mi carnet',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.notifications_active_outlined),
            activeIcon: Icon(Icons.notifications_active),
            label: 'Notificaciones',
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
