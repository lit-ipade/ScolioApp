import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_login/flutter_login.dart';
import 'package:provider/provider.dart';
import 'package:scolioapp/Autenticador_service.dart';
import 'package:scolioapp/models/avaliacao.dart';
import 'package:firebase_core/firebase_core.dart';
import 'dart:ui';
import 'dart:math';

import 'Autenticador_service.dart';
import 'models/pacientes.dart';
import 'components/PacienteForm.dart';
import 'components/PacienteList.dart';
import 'components/ConsultaForm.dart';
import 'components/ConsultaList.dart';
import 'components/ResultadoConsulta.dart';
import 'components/Login.dart';

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
      )
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
    void autenticarLogin(LoginData data)
    {
      context.read<AuthenticationService>().signIn(data.name,data.password);
    }
    final firebaseUser = context.watch<User>();
    if(firebaseUser != null)
    {
      return ListaPacientes();
    }
    return TelaLogin(autenticarLogin);
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
