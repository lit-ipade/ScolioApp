import 'avaliacao.dart';
import 'package:flutter/foundation.dart';

class Paciente 
{
  final String id;
  final String nome;
  final String sexo;
  final String nascimento;
  final List<Avaliacao> avaliacoesHistorico;

  Paciente
  ({
    this.id,
    @required this.nome,
    @required this.sexo,
    @required this.nascimento,
    this.avaliacoesHistorico
  });
}