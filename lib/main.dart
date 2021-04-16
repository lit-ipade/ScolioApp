import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:scolioapp/components/Login.dart';
import 'package:scolioapp/database/databaseHelper.dart';
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

  DatabaseHelper db = DatabaseHelper();
  List<Paciente> _pacientes = [];

  @override
  void initState(){

    super.initState();

    db.getAllPaciente(user.uid).then((lista)
      {
        setState(() {
          _pacientes = lista;
        });
      }
    );
  }

  @override
  Widget build(BuildContext context) {
    
    print(user.uid + " asuhdoiuahsdpoashdpoaushd");
    final pacientesProvider = Provider.of<PacienteProvider>(context);
    print(db.getCountPaciente());
  _addPaciente(String nome, String sexo, String nascimento)
  {
    final novoCadastro = Paciente
    (
      uid: user.uid,
      nome: nome,
      sexo: sexo,
      nascimento: nascimento,
    );
    setState(() {
      db.insertPaciente(novoCadastro);
      db.getAllPaciente(user.uid).then((lista)
      {
        setState(() {
          _pacientes = lista;
        });
      }
    );
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
      db.deletarPaciente(id);
      _pacientes.removeWhere((tr) => tr.id == id);
      db.getAllPaciente(user.uid).then((lista)
      {
        setState(() {
          _pacientes = lista;
        });
      });
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




//--------------------------------------------------------------------------------------------------Lista de Pacientes ------------------------------------------
class ListaConsulta extends StatefulWidget {
  final Paciente paciente;
  
  ListaConsulta(this.paciente);

  @override
  _ListaConsultaState createState() => _ListaConsultaState(paciente);
}

class _ListaConsultaState extends State<ListaConsulta> {
  final Paciente paciente;

  _ListaConsultaState(this.paciente);

  DatabaseHelper db = DatabaseHelper();

  List<Avaliacao> _consultas;

  void _atualizarLista(){
    db.getListAvaliacao(paciente.id).then((lista){
      setState(() {
        _consultas = lista;
      });
    });
  }

  void initSuper()
  {
    super.initState();
    db.getListAvaliacao(paciente.id).then((lista){
      setState(() {
        _consultas = lista;
      });
    });
  }

  _addConsulta(bool desnivelOmbro, bool desnivelBacia, bool gibosidade, bool radiografia, int angulo, int maturidade)
  {
    final novoCadastro = Avaliacao
    (
      data: DateFormat('dd/MM/yyyy').format(DateTime.now()).toString(),
      proprietarioId: paciente.id,
      desnivelOmbro: desnivelOmbro,
      desnivelBacia: desnivelBacia,
      gibosidade: gibosidade,
      radiografia: radiografia,
      anguloCobb: angulo,
      maturidadeEsqueletica: maturidade
    );
    setState(() {
      db.insertAvaliacao(novoCadastro);
      db.getListAvaliacao(paciente.id).then((lista){
        setState(() {
          _consultas = lista;
        });
      });
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
      db.deletarConsulta(id);
      db.getListAvaliacao(paciente.id).then((lista){
      setState(() {
        _consultas = lista;
      });
    });
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
    _atualizarLista();
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
            ConsultaList(paciente ,_consultas, _deleteConsulta, _exibirConsulta),
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
