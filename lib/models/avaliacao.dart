import 'package:flutter/foundation.dart';

class Avaliacao
{
  final String id;
  final String data;
  final bool desnivelOmbro;
  final bool desnivelBacia;
  final bool gibosidade;
  final bool radiografia;
  final int anguloCobb;
  final int maturidadeEsqueletica;

  Avaliacao({
   @required this.id,
   @required this.data,
   @required this.desnivelOmbro,
   @required this.desnivelBacia,
   @required this.gibosidade,
   @required this.radiografia,
    this.anguloCobb,
    this.maturidadeEsqueletica,
  });
}