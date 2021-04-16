import 'avaliacao.dart';
import 'package:flutter/foundation.dart';

class Paciente 
{
  int id;
  String uid;
  String nome;
  String sexo;
  String nascimento;
  List<Avaliacao> avaliacoesHistorico;

  Paciente
  ({
    this.id,
    this.uid,
    @required this.nome,
    @required this.sexo,
    @required this.nascimento,
    this.avaliacoesHistorico
  });

  Map<String,dynamic> toMap(){
    var map = <String, dynamic>{
      'id':id,
      'uid':uid,
      'nome':nome,
      'sexo':sexo,
      'nascimento':nascimento,
    };
    return map;
  }

  Paciente.fromMap(Map<String, dynamic> map){
    this.id = map['id'];
    this.uid = map['uid'];
    this.nome = map['nome'];
    this.sexo = map['sexo'];
    this.nascimento = map['nascimento'];
  }

  @override
  String toString(){
    return "Paciente => (id: $id, uid:$uid,nome: $nome, sexo: $sexo, nascimento: $nascimento)";
  }
}