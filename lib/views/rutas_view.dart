import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class RutasView extends StatelessWidget {
  const RutasView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Rutas"),
        backgroundColor: Colors.blue,
      ),
      body: const RutasList(),
    );
  }
}

class RutasList extends StatefulWidget {
  const RutasList({Key? key}) : super(key: key);

  @override
  _RutasListState createState() => _RutasListState();
}

class _RutasListState extends State<RutasList> {
  // Método para manejar el consumo de la API
  Future<List<dynamic>> getData() async {
    final url = Uri.parse('https://jsonplaceholder.typicode.com/todos/');
    try {
      final response = await http.get(url);
      if (response.statusCode == 200) {
        // Decodificar la respuesta como lista
        return jsonDecode(response.body);
      } else {
        print('Error, código de estado: ${response.statusCode}');
        return []; // Retornar una lista vacía si la respuesta es incorrecta
      }
    } catch (e) {
      print('Error: $e');
      return []; // Retornar una lista vacía si ocurre un error
    }
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<dynamic>>(
      future: getData(), // Llamar a la API para obtener los datos
      builder: (context, snapshot) {
        // Manejo del estado de la conexión
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(
            child: CircularProgressIndicator(color: Colors.blue.shade50),
          );
        } else if (snapshot.hasError) {
          return Center(
            child: Text('Error: ${snapshot.error}'),
          );
        } else if (snapshot.hasData) {
          final rutas = snapshot.data!;
          // Verificamos que los datos estén presentes antes de usarlos
          if (rutas.isNotEmpty) {
            return ListView.builder(
              itemCount: rutas.length,
              itemBuilder: (context, index) {
                final ruta = rutas[index];
                return Card(
                  margin: const EdgeInsets.all(10),
                  elevation: 5,
                  child: ListTile(
                    title: Text('ID: ${ruta['id']}'),
                    subtitle: Text('Título: ${ruta['title']}'),
                    trailing: Icon(
                      ruta['completed'] ? Icons.check_circle : Icons.cancel,
                      color: ruta['completed'] ? Colors.green : Colors.red,
                    ),
                  ),
                );
              },
            );
          } else {
            return const Center(
              child: Text('No hay datos disponibles'),
            );
          }
        } else {
          return const Center(
            child: Text('No se encontró información.'),
          );
        }
      },
    );
  }
}
