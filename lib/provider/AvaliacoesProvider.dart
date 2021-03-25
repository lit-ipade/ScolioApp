import 'package:flutter/material.dart';
import 'package:scolioapp/models/avaliacao.dart';

class AvaliacoesProvider with ChangeNotifier{

  
  final List<Avaliacao> avaliacoes;

  AvaliacoesProvider(this.avaliacoes);

  
}