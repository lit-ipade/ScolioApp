import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:scolioapp/components/Login.dart';
import 'package:scolioapp/models/Autenticador_service.dart';
import 'package:scolioapp/models/avaliacao.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:intl/intl.dart';
import 'dart:ui';
import 'dart:math';

import 'models/Autenticador_service.dart';
import 'models/pacientes.dart';
import 'components/PacienteForm.dart';
import 'components/PacienteList.dart';
import 'components/ConsultaForm.dart';
import 'components/ConsultaList.dart';
import 'components/ResultadoConsulta.dart';
import './provider/PacienteProvider.dart';

Future<void> main() async
{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(ScolioApp());
}
class ScolioApp extends StatelessWidget {
  
  @override
  Widget build(BuildContext context) {
    
    return MultiProvider
    (providers: 
    [
      Provider<AuthenticationService>
      (
        create: (_) => AuthenticationService(FirebaseAuth.instance),
      ),
      StreamProvider
      (
        create: (context)=>context.read<AuthenticationService>().authStateChanges,
      ),
      ChangeNotifierProvider
      (
        create: (context) => new PacienteProvider(),
      ),
    ],
      child: MaterialApp
      (
        home: AuthenticateWrapper(),
        theme: new ThemeData
        (
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
      ),
    );
  }
}


class AuthenticateWrapper extends StatelessWidget{
  const AuthenticateWrapper({
    Key key
  }) : super(key: key);

  @override
  Widget build(BuildContext context)
  {
    User firebaseUser = context.watch<User>(); 
    
    if(firebaseUser != null)
    {
      return ListaPacientes(firebaseUser);
    }
    return TelaLogin(); 
  }
  
}

class ListaPacientes extends StatefulWidget {
  
  final User user;
  
  ListaPacientes(this.user);
  @override
  _ListaPacientesState createState() => _ListaPacientesState(user);
}

class _ListaPacientesState extends State<ListaPacientes> {

  User user;

  _ListaPacientesState(this.user);
  @override
  Widget build(BuildContext context) {
    
    final pacientesProvider = Provider.of<PacienteProvider>(context);
    final List<Paciente> _pacientes = pacientesProvider.pacientes;
        
  _addPaciente(String nome, String sexo, String nascimento)
  {
    final novoCadastro = Paciente
    (
      nome: nome,
      sexo: sexo,
      nascimento: nascimento,
      avaliacoesHistorico: [],
    );
    setState(() {
      pacientesProvider.addPaciente(novoCadastro);
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

  _deletePaciente(int id)
  {
    setState(() {
      _pacientes.removeWhere((tr) => tr.id == id);
    });
  }


  //--------------------------------------------------------------------------------------------
    return Scaffold
    (
      appBar: AppBar
      (
        title: Text('Lista de Pacientes'),
        actions: <Widget>
        [
          IconButton
          (
            icon: const Icon(Icons.logout),
            tooltip: 'Logout',
            onPressed: ()
            {
              context.read<AuthenticationService>().signOut();
            },
          )
        ],
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
  final Paciente paciente;
  
  ListaConsulta(this.paciente);

  @override
  _ListaConsultaState createState() => _ListaConsultaState(paciente);
}

class _ListaConsultaState extends State<ListaConsulta> {
  final Paciente paciente;

  _ListaConsultaState(this.paciente);


  _addConsulta(bool desnivelOmbro, bool desnivelBacia, bool gibosidade, bool radiografia, int angulo, int maturidade)
  {
    final novoCadastro = Avaliacao
    (
      data: DateFormat('dd/MM/yyyy').format(DateTime.now()),
      proprietarioId: paciente.id,
      desnivelOmbro: desnivelOmbro,
      desnivelBacia: desnivelBacia,
      gibosidade: gibosidade,
      radiografia: radiografia,
      anguloCobb: angulo,
      maturidadeEsqueletica: maturidade
    );
    setState(() {
      paciente.avaliacoesHistorico.add(novoCadastro);
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

  _deleteConsulta(int id)
  {
    setState(() {
      paciente.avaliacoesHistorico.removeWhere((tr) => tr.id == id);
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
            ConsultaList(paciente.avaliacoesHistorico, _deleteConsulta, _exibirConsulta),
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
