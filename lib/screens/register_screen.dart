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
  final _formKey = GlobalKey<FormState>();
  String? _rutaSelect;
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController = TextEditingController();
  final TextEditingController _nameController = TextEditingController();
  bool _isLoading = false;
  final _authService = AuthService();

  //Funcion para el regsitro

  Future<void> _registerWithEmailAndPassword() async{
    if(!_formKey.currentState!.validate()){
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
  if(mounted){
  setState(() {
   // Cambiamos el estado para quitar el indicador de carga
    _isLoading = false;

  });
}
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
  //Limpiar los cmapos

  void dispose(){
    _emailController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    _nameController.dispose();

    super.dispose();
  }
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Registro"),
        backgroundColor: const Color.fromARGB(255, 6, 84, 148),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key : _formKey,
          child : Column(
            children: [
                TextFormField(
                  controller: _nameController,
                  decoration: const InputDecoration(
                    labelText: "Nombres completos",
                    border: OutlineInputBorder(),
                    prefixIcon: Icon(Icons.person)
                  ),
                  //Validaciones
                  validator: (value){
                    if(value == null || value.isEmpty){
                      return "Ingrese su nombre completo";
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 16),
                TextFormField(
                  controller: _emailController,
                  decoration: const InputDecoration(
                    labelText: "Correo electrónico",
                    border: OutlineInputBorder(),
                    prefixIcon: Icon(Icons.mail)
                  ),
                  validator: (value) {
                    if(value == null || value.isEmpty){
                        return "Ingrese su correo electrónico";
                    }
                    return null;
                  },
                  keyboardType: TextInputType.emailAddress,
                ),
                const SizedBox(height: 16),
                TextFormField(
                  obscureText: true,
                  controller: _passwordController,
                  decoration: const InputDecoration(
                    labelText: "Contraseña",
                    border: OutlineInputBorder(),
                    prefixIcon: Icon(Icons.lock)
                  ),
                  validator: (value) {
                    if(value == null || value.isEmpty){
                        return "Ingrese su contraseña";
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 16),
                TextFormField(
                  obscureText: true,
                  controller: _confirmPasswordController,
                  decoration: const InputDecoration(
                    labelText: "Confirmar Contraseña",
                    border: OutlineInputBorder(),
                    prefixIcon: Icon(Icons.lock)
                  ),
                  validator: (value){
                    if(value != _passwordController.text){
                      return "Las contraseñas no coinciden";
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 16),
                DropdownButtonFormField(
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    prefixIcon: Icon(Icons.bus_alert_sharp)
                  ),
                  value: _rutaSelect,
                  hint: const Text("Seleccione su ruta"),
                  items: [
                    "Ruta 1: Cárcelen",
                    "Ruta 2: Pisuli",
                    "Ruta 3: Ejido" ,
                  ].map((option)=> DropdownMenuItem(
                      value: option,
                      child: Text(option),
                    )).toList(),
                  onChanged: (value){
                    if(value != null){
                    setState(() {
                      _rutaSelect = value;
                    });
                  }
                  },
                  validator: (value) =>
                    value == null ? "Seleccione una ruta" : null,
                    
                ),

                
                const SizedBox(height: 18),
                ElevatedButton(
                  onPressed: _isLoading 
                      ? null 
                      : () {
                        if(_formKey.currentState!.validate()){
                         _registerWithEmailAndPassword();
                        }
                      } ,
                  child: _isLoading  
                    ? const CircularProgressIndicator(color: Colors.deepPurple)
                    : const Text("Registrarse"),
                    ),
              ],
        ),
        
        ),
      ),
    );
  }



}
