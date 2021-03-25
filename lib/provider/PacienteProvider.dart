import 'dart:convert';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http; 
import '../data/PacientesData.dart';
import 'package:scolioapp/models/pacientes.dart';

class PacienteProvider with ChangeNotifier {
  static const _baseUrl = 'https://scolioapp-default-rtdb.firebaseio.com/';
  final List<Paciente> _pacientes = DUMMY_PACIENTES;

  List<Paciente> get pacientes => [..._pacientes];

  void addPaciente(Paciente paciente)
  {
    if(paciente == null)
    {
      return;
    }
    Paciente pacienteComparado = _pacientes.firstWhere((pacienteListado) => pacienteListado.id == paciente.id, orElse: () => null);
    if(pacienteComparado == null)
    {
      _pacientes.add(paciente);
    }
    else
    {
      pacienteComparado = paciente;
    }
    
    notifyListeners();
  }


  
}