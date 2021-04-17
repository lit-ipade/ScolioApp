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
  
  

  

  @override
  Widget build(BuildContext context) {
    final firebaseUser = context.watch<User>();

    Future<String> _authUser(LoginData data){
    print('Name: ${data.name}, Password: ${data.password}');
    return Future.delayed(loginTime).then((_) {
      final result = context.read<AuthenticationService>().signIn(data);
      return result;
      
    });
    }
    
    Future<String> onSignup(LoginData data){
    print('Name: ${data.name}, Password: ${data.password}');
    
    return Future.delayed(loginTime).then((_) {
      final result = context.read<AuthenticationService>().signUp(data);

      return result;
      
    });
  }

  Future<String> _recoverPassword(String name) 
  {
    print('Name: $name');
    return Future.delayed(loginTime).then((_) {
      final result = context.read<AuthenticationService>().recuperarSenha(name);
        return result;
    });
  }
    
    return Padding(
      padding: const EdgeInsets.fromLTRB(0,10.0,0,0),
      child: FlutterLogin(
        title: 'ScolioApp',
        logo: 'assets/scolio.png',
        onLogin: _authUser,
        onSignup: onSignup,
        onSubmitAnimationCompleted: ()
        {
          Navigator.of(context).pushReplacement(MaterialPageRoute(
            builder: (context) => ListaPacientes(firebaseUser),
          ));
        },
        onRecoverPassword: _recoverPassword,
        theme: LoginTheme(
          titleStyle: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
          ),
        messages: 
          LoginMessages(
            passwordHint: 'Senha',
            signupButton:'Registrar',
            forgotPasswordButton: 'Esqueceu a senha ?',
            recoverPasswordButton: 'Recuperar',
            recoverPasswordDescription: 'Cheque sua caixa de email e o lixo eletrônico',
            goBackButton: 'Voltar',
            recoverPasswordSuccess: 'Senha recuperada',
            recoverPasswordIntro: 'Recupere sua senha',
            confirmPasswordError: 'Senhas não coincidem',
          ),
      ),
    );
  }
}