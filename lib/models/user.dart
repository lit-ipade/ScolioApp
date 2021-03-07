import 'pacientes.dart';

class Usuario
{
  final String id;
  final String login;
  final String pass;
  final List<Paciente> pacientes;

  Usuario(this.id,this.login,this.pass,this.pacientes);
}