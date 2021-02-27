import 'package:flutter/material.dart';
import 'package:flutter_login/flutter_login.dart';
import 'package:intl/intl.dart';
import 'package:scolioapp/models/avaliacao.dart';
import 'dart:ui';
import 'dart:math';

import 'components/BotaoCaminho.dart';
import 'models/pacientes.dart';
import 'components/PacienteForm.dart';
import 'components/PacienteList.dart';
import 'components/ConsultaForm.dart';
import 'components/ConsultaList.dart';
import 'components/ResultadoConsulta.dart';
import 'components/Login.dart';

main()=>runApp(ScolioApp());

class ScolioApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: TelaLogin(),
      theme: new ThemeData(
        primarySwatch: Colors.blue,
        dividerColor: Colors.grey,
        appBarTheme: AppBarTheme
        (
            color: Colors.white,
            iconTheme: IconThemeData
            (
              color: Colors.blue[900]
            )
          ),
        primaryTextTheme: TextTheme
        (
          headline6: TextStyle
          (
            color: Colors.black
          )
        ),
        disabledColor: Colors.grey[600],
        primaryColor: Colors.blue[900],
        scaffoldBackgroundColor: Colors.grey[200],
        accentColor: Colors.blue[900],
        backgroundColor: Colors.grey[200]
    ),
    );
  }
}

class MyHomePage extends StatefulWidget {
  
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {

  @override
  Widget build(BuildContext context) {
    return Scaffold
    (
      appBar: AppBar
      (
        title: Text('ScolioApp'),
      ),
      body: Column
        (
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>
            [
              Container
              (
                alignment: Alignment.center,
                child: BotaoCaminho('Pacientes Cadastrados', Theme.of(context).primaryColor, ListaPacientes()),
              ),
            ]
        ),
    );
  }
}

class ListaPacientes extends StatefulWidget {
  
  @override
  _ListaPacientesState createState() => _ListaPacientesState();
}

class _ListaPacientesState extends State<ListaPacientes> {

    final List<Paciente> _pacientes =
    [
      
    ];
  _addPaciente(String nome, String sexo, DateTime nascimento)
  {
    final novoCadastro = Paciente
    (
      id: Random().nextDouble().toString(),
      nome: nome,
      sexo: sexo,
      nascimento: nascimento,
      avaliacoesHistorico: [],
    );
    setState(() {
      _pacientes.add(novoCadastro);
    });
    Navigator.of(context).pop();
  }

  _openCadastroFormModal(BuildContext context)
  {
    showModalBottomSheet
    (
      context: context,
      builder: (_)
      {
        return PacienteForm(_addPaciente);
      }
    );
  }

  _deletePaciente(String id)
  {
    setState(() {
      _pacientes.removeWhere((tr) => tr.id == id);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold
    (
      appBar: AppBar
      (
        title: Text('Lista de Pacientes'),
      ),
      body: SingleChildScrollView
      (
        child: Column
        (
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children:<Widget>
          [
            PacienteList(_pacientes, _deletePaciente),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton
            (
              child: Icon(Icons.add),
              onPressed: ()
              {
                _openCadastroFormModal(context);
              }
            ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat  
    );
  }
}

class ListaConsulta extends StatefulWidget {
  final List<Avaliacao> consultasPaciente;
  
  ListaConsulta(this.consultasPaciente);

  @override
  _ListaConsultaState createState() => _ListaConsultaState(consultasPaciente);
}

class _ListaConsultaState extends State<ListaConsulta> {
  final List<Avaliacao> consultasPaciente;

  _ListaConsultaState(this.consultasPaciente);


  _addConsulta(bool desnivelOmbro, bool desnivelBacia, bool gibosidade, bool radiografia, int angulo, int maturidade)
  {
    final novoCadastro = Avaliacao
    (
      id: Random().nextDouble().toString(),
      data: DateTime.now(),
      desnivelOmbro: desnivelOmbro,
      desnivelBacia: desnivelBacia,
      gibosidade: gibosidade,
      radiografia: radiografia,
      anguloCobb: angulo,
      maturidadeEsqueletica: maturidade
    );
    setState(() {
      consultasPaciente.add(novoCadastro);
    });
    Navigator.of(context).pop();
  }

  _abrirNovoCadastro(BuildContext context)
  {
    Navigator.of(context).push
    (
      MaterialPageRoute
      (
        builder:(_)
        {
          return ConsultaForm(_addConsulta);
        },
      ),
    );
  }
  _openCadastroFormModal(BuildContext context)
  {
    showModalBottomSheet
    (
      context: context,
      builder: (_)
      {
       return ConsultaForm(_addConsulta);
      }
    );
  }

  _deleteConsulta(String id)
  {
    setState(() {
      consultasPaciente.removeWhere((tr) => tr.id == id);
    });
  }

  _exibirConsulta(Avaliacao consulta)
  {
    Navigator.of(context).push
    (
      MaterialPageRoute
      (
        builder:(_)
        {
          return ResultadoConsulta(consulta);
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold
    (
      appBar: AppBar
      (
        title: Text('Lista de Consultas'),
      ),
      body: SingleChildScrollView
      (
        child: Column
        (
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children:<Widget>
          [
            ConsultaList(consultasPaciente, _deleteConsulta, _exibirConsulta),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton
            (
              child: Icon(Icons.add),
              onPressed: ()
              {
                _abrirNovoCadastro(context);
              }
            ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat 
    );
  }
}
