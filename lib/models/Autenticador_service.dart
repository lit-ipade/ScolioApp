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
        return e.message;
      }
    
  }
  Future<String> signUp({String email, String password}) async
  {
    try {
      await _firebaseAuth.createUserWithEmailAndPassword(email: email, password: password);
    } on FirebaseAuthException catch (e) {
      return e.message;
    }
  }
}