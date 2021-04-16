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

  bool _intToBool (int variavel)
    {
      bool resultado = (variavel == 1) ?true :  false;
      return resultado;
    }

  int _boolToint(bool variavel)
   {
     int resultado = (variavel)? 1 : 0;
     return resultado;
   }
  
  Map<String, dynamic> toMap(){

   var map = <String, dynamic>{
    'id':id,
    'data':data,
    'proprietarioId':proprietarioId,
    'desnivelOmbro':_boolToint(desnivelOmbro),
    'desnivelBacia':_boolToint(desnivelBacia),
    'gibosidade':_boolToint(gibosidade),
    'radiografia':_boolToint(radiografia),
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
    this.desnivelOmbro = _intToBool(map['desnivelOmbro']);
    this.desnivelBacia = _intToBool(map['desnivelBacia']);
    this.gibosidade = _intToBool(map['gibosidade']);
    this.radiografia = _intToBool(map['radiografia']);
    this.anguloCobb = map['anguloCobb'];
    this.maturidadeEsqueletica = map['maturidadeEsqueletica'];
  }
}