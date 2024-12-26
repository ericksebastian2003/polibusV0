import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class ProfileView extends StatefulWidget{
  const ProfileView({Key? key}) : super(key: key);

  @override
  State<ProfileView> createState() => _ProfileViewState();
}
class _ProfileViewState extends State<ProfileView>{
  //Declarar la variable para recuperar el nombre de usuario
  String? nombre;
  //Para manejar el estado de carga
  bool isLoading = false;
  @override
  void initState(){
    super.initState();
    fetchUserName();
  }
  Future<void> fetchUserName() async{
    try{
    //Instanciar Firebase
    final user = FirebaseAuth.instance.currentUser;
    if(user != null){
      final doc = await FirebaseFirestore.instance.collection('users').doc(user.uid).get();
      setState(() {
        nombre = doc['name'] ?? 'Usuario';
        isLoading = false;
      });
    }
  }
  catch(e){
    setState(() {
      nombre = 'Error al cargar el nombre';
      isLoading = false;
    });
    print('Error al obtener la variable ${e}');

  }
  }
  @override
  Widget build(BuildContext context){
    return Scaffold(
      appBar: AppBar(
        title: const Text("Mi perfil"),
        backgroundColor: const Color.fromARGB(255, 41, 9, 129),
        foregroundColor: Colors.white,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: isLoading
          ? const Center(
            child: CircularProgressIndicator(),

          )
          : Column(
          //Define cómo los elementos hijos se distribuyen a lo largo del eje principal del contenedor.
          mainAxisAlignment: MainAxisAlignment.center,
          //Alinea los elementos en el centro del eje transversal.
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const CircleAvatar(
              radius: 50,
              backgroundImage: AssetImage("assets/avatar.png"),

            ),
            const SizedBox(height: 20),
            //Nota: Este nombre se debe extraer de la base de datos
            Text(
              'Bienvenido , $nombre',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold
              ),

            ),
            const SizedBox(height: 20),

          ],

        ),
        
      ),
    );
  }
  //Declaracion de las variables



}