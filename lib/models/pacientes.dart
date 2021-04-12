import 'avaliacao.dart';
import 'package:flutter/foundation.dart';

class Paciente 
{
  int id;
  String nome;
  String sexo;
  String nascimento;
  List<Avaliacao> avaliacoesHistorico;

  Paciente
  ({
    this.id,
    @required this.nome,
    @required this.sexo,
    @required this.nascimento,
    this.avaliacoesHistorico
  });

  Map<String,dynamic> toMap(){
    var map = <String, dynamic>{
      'id':id,
      'nome':nome,
      'sexo':sexo,
      'nascimento':nascimento,
    };
    return map;
  }

  Paciente.fromMap(Map<String, dynamic> map){
    this.id = map['id'];
    this.nome = map['nome'];
    this.sexo = map['sexo'];
    this.nascimento = map['nascimento'];
  }

  @override
  String toString(){
    return "Paciente => (id: $id, nome: $nome, sexo: $sexo, nascimento: $nascimento)";
  }
}