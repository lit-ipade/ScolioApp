import 'package:flutter/foundation.dart';

class Avaliacao
{
  int id;
  String data;
  int proprietarioId;
  bool desnivelOmbro;
  bool desnivelBacia;
  bool gibosidade;
  bool radiografia;
  int anguloCobb;
  int maturidadeEsqueletica;

  Avaliacao({
   this.id,
   @required this.data,
   @required this.proprietarioId,
   @required this.desnivelOmbro,
   @required this.desnivelBacia,
   @required this.gibosidade,
   @required this.radiografia,
    this.anguloCobb,
    this.maturidadeEsqueletica,
  });

  Map<String, dynamic> toMap(){
   var map = <String, dynamic>{
    'id':id,
    'data':data,
    'desnivelOmbro':desnivelOmbro,
    'proprietarioId':proprietarioId,
    'desnivelBacia':desnivelBacia,
    'gibosidade':gibosidade,
    'radiografia':radiografia,
    'anguloCobb':anguloCobb,
    'maturidadeEsqueletica':maturidadeEsqueletica,
   };
    return map;
  }

  Avaliacao.fromMap(Map<String,dynamic> map)
  {
    this.id = map['id'];
    this.data = map['data'];
    this.proprietarioId = map['proprietarioId'];
    this.desnivelOmbro = map['desnivelOmbro'];
    this.desnivelBacia = map['desnivelBacia'];
    this.gibosidade = map['gibosidade'];
    this.radiografia = map['radiografia'];
    this.anguloCobb = map['anguloCobb'];
    this.maturidadeEsqueletica = map['maturidadeEsqueletica'];
  }
}