import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class AuthService{
  //Instanciar Firebase
  final FirebaseAuth _auth = FirebaseAuth.instance;

  //Funcion para el resgirtro de usuarios
  Future<User?> registerWithEmailAndPassword(String email , String password) async{
    try{
      UserCredential userCredential = await _auth.createUserWithEmailAndPassword(
        email:email,
        password:password,
      );
      return userCredential.user;
    }
    catch(e){
      throw Exception('Error al registrarse $e');

    }
  }
  signInWithEmailAndPassword(String text , String text2){

  }

}