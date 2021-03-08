import 'package:flutter/material.dart';
import 'package:flutter_login/flutter_login.dart';
import 'package:scolioapp/Autenticador_service.dart';

import '../main.dart';


const users = const
{
 // 'adminscolioapp@gmail.com' : '12345'
};

class TelaLogin extends StatelessWidget 
{
  final void Function(LoginData) autenticarLogin;

  TelaLogin(this.autenticarLogin);

  Duration get loginTime => Duration(milliseconds: 2240);
  
  Future<String> _authUser(LoginData data){
    print('Name: ${data.name}, Password: ${data.password}');
    
    return Future.delayed(loginTime).then((_) {
      autenticarLogin(data);
      /*if (!users.containsKey(data.name)) {
        return 'Username not exists';
      }
      if (users[data.name] != data.password) {
        return 'Password does not match';
      }*/
      return null;
    });
  }

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
    

    return FlutterLogin(
      title: 'ScolioApp',
      logo: null,
      onLogin: _authUser,
      onSignup: _authUser,
      onSubmitAnimationCompleted: ()
      {
        Navigator.of(context).pushReplacement(MaterialPageRoute(
          builder: (context) => ListaPacientes(),
        ));
      },
      onRecoverPassword: _recoverPassword,
    );
  }
}