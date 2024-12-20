import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:polibus/services/auth_service.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen ({Key? key}) : super(key : key);
  @override
  State<RegisterScreen> createState() => _RegisterScreenState();

}
class _RegisterScreenState extends State<RegisterScreen>{
  //Para manejar los cammpos del formulario
  
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController = TextEditingController();
  final TextEditingController _nameController = TextEditingController();
  bool _isLoading = false;
  final _authService = AuthService();

  //Funcion para el regsitro

  Future<void> _registerWithEmailAndPassword() async{
if(_emailController.text.isEmpty || _nameController.text.isEmpty || _passwordController.text.isEmpty || _confirmPasswordController.text.isEmpty){
  _showErrorDialog("Por favor , todos los cmapos son obligatorios");
  return;
}
if(_passwordController.text != _confirmPasswordController.text){
  _showErrorDialog("Las contraseñas no coinciden");
  return;
}
//Cambio de estado 
setState(() {
  _isLoading = true;  
});

try{
  await _authService.registerWithEmailAndPassword(
    _emailController.text.trim(), //Elimina los espacios acios 
    _passwordController.text.trim(),
    );
    Navigator.pushReplacementNamed(context,'/login');
}
catch(e){
  _showErrorDialog("Error al registrarse ${e.toString()}");

}
finally{
  setState(() {
   // Cambiamos el estado para quitar el indicador de carga
    _isLoading = false;

  });
}
}
void _showErrorDialog(String message){
  showDialog(
    context: context,
    builder: (context)=> AlertDialog(
      title: const Text("Mensaje de error"),
      content: Text(message),
      actions: [
        TextButton(
          onPressed: (){
            //Cerrar el cuadro de dialogo con CERRAR
            Navigator.of(context).pop();
          },
          child: const Text("Cerrar"),
          ),

      ],
    ),
  );
}
  

  //Interfaz de usuario
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Registro"),
        backgroundColor: const Color.fromARGB(255, 6, 84, 148),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextField(
              controller: _nameController,
              decoration: const InputDecoration(
                labelText: "Nombres completos",
                border: OutlineInputBorder(),
                prefixIcon: Icon(Icons.person)
              ),
            ),
            const SizedBox(height: 16),
            TextField(
              controller: _emailController,
              decoration: const InputDecoration(
                labelText: "Correo electrónico",
                border: OutlineInputBorder(),
                prefixIcon: Icon(Icons.mail)
              ),
              keyboardType: TextInputType.emailAddress,
            ),
            const SizedBox(height: 16),
            TextField(
              obscureText: true,
              controller: _passwordController,
              decoration: const InputDecoration(
                labelText: "Contraseña",
                border: OutlineInputBorder(),
                prefixIcon: Icon(Icons.lock)
              ),
            ),
            const SizedBox(height: 16),
            TextField(
              obscureText: true,
              controller: _confirmPasswordController,
              decoration: const InputDecoration(
                labelText: "Confirmar Contraseña",
                border: OutlineInputBorder(),
                prefixIcon: Icon(Icons.lock)
              ),
            ),
            const SizedBox(height: 18),
            ElevatedButton(
              onPressed: _isLoading ? null : _registerWithEmailAndPassword, 
              child: _isLoading  
                ? const CircularProgressIndicator(color: Colors.deepPurple)
                : const Text("Registrarse"),
                ),
          ],
        ),
        
        ),

    );
  }



}
