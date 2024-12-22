import 'package:flutter/material.dart';

class NotificationsView extends StatefulWidget {

  const NotificationsView({Key? key}) : super(key: key);
  @override
  _NotificationsViewState createState() => _NotificationsViewState();
}

class _NotificationsViewState extends State<NotificationsView>{

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Notificaciones"),
        backgroundColor: const Color.fromARGB(255, 80, 13, 9),
        foregroundColor: Colors.white,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            //Todos los elementos

            Card(
              elevation: 0,
              child: const Text("Hola"),
            )

          ],
        ),
    )
    );
  }
}