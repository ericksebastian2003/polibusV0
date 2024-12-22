import 'package:flutter/material.dart';
import '../services/auth_service.dart';
import 'register_screen.dart';

class LoginScreen  extends StatefulWidget{
 const LoginScreen({Key? key}) : super(key : key);
 @override
 State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen>{
  //Para los controladores de texto
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  bool _isLoading = false;
  final _authService = AuthService();

  //Funcion para logearse con email y password
  Future<void> _loginWithEmailAndPassword() async{
    //Validacion de campos vacios
    if(_emailController.text.isEmpty || _passwordController.text.isEmpty){
      _showErrorDialog("Por favor , todos los campos deben estar llenos");
      return;
    }
    //Cambio de estado de la variable isLoaging
    setState(() {
      _isLoading = true;
    });
    
    try{
        //Instancia del metodo de login Firebase
        await _authService.signInWithEmailAndPassword(
          //Envio de los parametros 
          _emailController.text.trim(),
          _passwordController.text.trim(),
        );
        //Redirigir a Home
        Navigator.pushReplacementNamed(context, '/home');
    }
    catch(e){
      _showErrorDialog("Error al iniciar sesión ${e.toString()}");

    }
    finally{
      //Cambio de estado 
      setState(() {
        _isLoading = false;
      });
    }
  }
  //Funcion para que se muestre el dialogo de eror
  void _showErrorDialog(String message){
    //Cracion de dialogo
    showDialog(
      context: context, 
      builder: (context) => AlertDialog(
        title: const Text("Mensaje de error"),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text("Cerrar"),
          )
        ],
      ),
      );
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Inicio de sesión"),
        //Fondo con RGB
        backgroundColor: const Color.fromARGB(255, 5, 79, 139),
      ),
      body: Stack(
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                TextField(
                  controller: _emailController,
                  decoration: const InputDecoration(
                    labelText: "Correo electrónico",
                    border: OutlineInputBorder(),
                    prefixIcon: Icon(Icons.email),
                  ),
                  keyboardType: TextInputType.emailAddress,
                ),
                const SizedBox(height: 15),
                TextField(
                  controller: _passwordController,
                  obscureText: true,
                  decoration: const InputDecoration(
                    
                    labelText: "Contraseña",
                    prefixIcon: Icon(Icons.lock),
                    border: OutlineInputBorder(),
                  ),
        

                ),
                const SizedBox(height: 15),
                  //Boton para inicar sesion

                ElevatedButton(
                  onPressed: _isLoading  ? null : _loginWithEmailAndPassword,
                  child: _isLoading
                    ? const CircularProgressIndicator(color: Colors.white)
                    : const Text("Iniciar sesión"),
                  ),
              
              const SizedBox(height: 20),
              const Text('¿No tienes cuenta?'),
              ElevatedButton(
                onPressed: (){
                  //Ir al screen Registro
                  Navigator.push(context,MaterialPageRoute(
                    builder: (context) =>  RegisterScreen()),
                  );
                },
                  child: const Text("Registrate"),
              ),
              ],
            ),
            
            ),
            if(_isLoading)
              const Center(
                child: CircularProgressIndicator(color: Colors.deepPurple),
              )
        ],
      ),
    );
  }

}