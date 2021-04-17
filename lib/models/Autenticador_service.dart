import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_login/flutter_login.dart';

class AuthenticationService
{
  final FirebaseAuth _firebaseAuth;
    
  AuthenticationService(this._firebaseAuth);
  
  Stream<User> get authStateChanges => _firebaseAuth.authStateChanges();
  
  Future<void> signOut() async
  {
    await _firebaseAuth.signOut();
  }
  Future<String> signIn(LoginData data)
  async{
    try
    {
      await _firebaseAuth.signInWithEmailAndPassword(email: data.name, password: data.password);
      return null;
    } on FirebaseAuthException catch (e)
      {
        switch(e.code){
          case "wrong-password" :
          return "Senha inválida";
          case "too-many-requests" :
          return "Muitas tentativas detectadas desse dispositivo, por favor tente em alguns momentos.";
        }
        return e.message;

      }
    
  }
  Future<String> signUp(LoginData data) async
  {
    try {
      await _firebaseAuth.createUserWithEmailAndPassword(email: data.name, password: data.password);
    } on FirebaseAuthException catch (e) {
      return e.message;
    }
  }
  Future<String> recuperarSenha(String email) async
  {
    try {
      await _firebaseAuth.sendPasswordResetEmail(email: email);
    } on FirebaseAuthException catch (e) {
      return e.message;
    }
  }

}