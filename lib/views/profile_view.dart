import 'package:flutter/material.dart';


class ProfileView extends StatefulWidget{
  const ProfileView({Key? key}) : super(key: key);

  @override
  State<ProfileView> createState() => _ProfileViewState();
}
class _ProfileViewState extends State<ProfileView>{
  @override
  Widget build(BuildContext context){
    return Scaffold(
      appBar: AppBar(
        title: const Text("Mi perfil"),
        backgroundColor: Colors.yellow,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
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
            const Text(
              "Erick Caiza",
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