
import 'package:flutter/material.dart';
import '../widgets/qr_code_widget.dart';

class ProfileScreen extends StatefulWidget{
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}
class _ProfileScreenState extends State<ProfileScreen>{
  @override
  Widget build(BuildContext context){
    final  String qrData = "Erick Caiza - 2003 ";
    return Scaffold(
      appBar: AppBar(
        title: const Text("Perfil de usuario"),
        backgroundColor: Colors.blue,
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
            QrCodeWidget(
              data: qrData,
              size: 150.0,
              backgroundColor: Colors.white,
              foregroundColor: Colors.black,
              
              ),
            const SizedBox(height: 20),

          ],

        ),
        
      ),
    );
  }
  //Declaracion de las variables



}