import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_login/flutter_login.dart';
import 'package:provider/provider.dart';
import 'package:scolioapp/models/Autenticador_service.dart';

import '../main.dart';


const users = const
{
 'adminscolioapp@gmail.com' : '12345'
};

class TelaLogin extends StatelessWidget 
{
  
  Duration get loginTime => Duration(milliseconds: 2240);
  
  

  Future<String> _recoverPassword(String name) 
  {
    print('Name: $name');
    return Future.delayed(loginTime).then((_) {
      if (!users.containsKey(name)) {
        return 'Username not exists';
      }
      return null;
    });
  }

  @override
  Widget build(BuildContext context) {
    final firebaseUser = context.watch<User>();
    Future<String> _authUser(LoginData data){
    print('Name: ${data.name}, Password: ${data.password}');
    
    return Future.delayed(loginTime).then((_) {
      final result = context.read<AuthenticationService>().signIn(data);

      return result;
     /* if (!users.containsKey(data.name)) {
        return 'Username not exists';
      }
      if (users[data.name] != data.password) {
        return 'Password does not match';
      }
      return null;*/
      
    });
  }
    
    return FlutterLogin(
      title: 'ScolioApp',
      logo: null,
      onLogin: _authUser,
      onSignup: _authUser,
      onSubmitAnimationCompleted: ()
      {
        Navigator.of(context).pushReplacement(MaterialPageRoute(
          builder: (context) => ListaPacientes(firebaseUser),
        ));
      },
      onRecoverPassword: _recoverPassword,
    );
  }
}