import 'dart:async';
import 'dart:io';
import 'package:scolioapp/models/pacientes.dart';
import 'package:scolioapp/models/avaliacao.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';

class DatabaseHelper{

  static DatabaseHelper _databaseHelper;
  static Database _database;

  //usado para definir as colunas Pacientes
  String pacienteTable = 'paciente';
  String colId = 'id';
  String colNome = 'nome';
  String colSexo = 'sexo';
  String colNascimento = 'nascimento';
  String colAvaliacoes = 'avaliacoes';

  //usado para definir as colunas Avaliações
  String avaliacaoTable = 'avaliacoes';
  String colIdAvaliacoes = 'id';
  String colProprietarioId = 'proprietarioID';
  String colDataAvaliacoes = 'data';
  String colDesnivelOmbro = 'desnivelOmbro';
  String colDesnivelBacia = 'desnivelBacia';
  String colGibosidade = 'gibosidade';
  String colRadiografia = 'radiografia';
  String colAnguloCobb = 'anguloCobb';
  String colMaturidade = 'maturidadeEsqueletica';


  DatabaseHelper._createInstance();

  factory DatabaseHelper(){
    if(_databaseHelper == null)
    {
      _databaseHelper = DatabaseHelper._createInstance();
    }
    return _databaseHelper;
  }

  Future<Database> get database async{
    if(_database == null)
    {
      _database = await initializeDatabase();
    }
    return _database;
  }

  Future<Database> initializeDatabase() async{
    Directory directory = await getApplicationDocumentsDirectory();
    String path = directory.path + 'pacientes.db';

    var db = await openDatabase(path, version: 1, onCreate: _createDb);
        return db;
  }

    FutureOr<void> _createDb(Database db, int version) async{
    await db.execute('PRAGMA foreign_keys = ON');
    await db.execute("CREATE TABLE $pacienteTable($colId INTEGER PRIMARY KEY AUTOINCREMENT, $colNome TEXT, $colSexo TEXT,$colNascimento TEXT)");
    await db.execute("CREATE TABLE $avaliacaoTable($colIdAvaliacoes INTEGER PRIMARY KEY AUTOINCREMENT, $colProprietarioId INTEGER NOT NULL, FOREIGN KEY ($colProprietarioId) REFERENCES $pacienteTable ($colId) , $colDataAvaliacoes TEXT, $colDesnivelOmbro BOOLEAN, $colDesnivelBacia BOOLEAN, $colGibosidade BOOLEAN, $colRadiografia BOOLEAN, $colAnguloCobb INTEGER, $colMaturidade INTEGER))");
  }

  //Incluir objeto paciente na tabela
  Future<int> insertPaciente(Paciente paciente)async{

  Database db = await this.database;
  var resultado = await db.insert(pacienteTable, paciente.toMap());

  return resultado;
  }
  //Inclui objeto avaliação na tabela
  Future<int> insertAvaliacao(Avaliacao avaliacao)async{

  Database db = await this.database;
  var resultado = await db.insert(avaliacaoTable, avaliacao.toMap());

  return resultado;
  }

  //Retorna todos os pacientes 
  Future<List<Paciente>> getAllPaciente() async{
    Database db = await this.database;
    List<Paciente> listAll;

    List<Map> maps = await db.rawQuery("SELECT * from $pacienteTable", null);

    if(maps.length > 0)
    {
      for(int i = 0; i<maps.length; i++)
      {
        listAll.add(Paciente.fromMap(maps[i]));
      }
      return listAll;
    }else{
      return null;
    }
  }

  //Retorna um paciente específico
  Future<Paciente> getPaciente(int idPaciente) async{
    Database db = await this.database;
    List<Map> maps = await db.query(pacienteTable,
    columns: [colId, colNome, colSexo, colNascimento],
    where: "$colId = ?",
    whereArgs: [idPaciente]
    );

    if(maps.length >0)
    {
      return Paciente.fromMap(maps.first);
    }
    else{
      return null;
    }
  }

  //Pega a lista de avaliações de um paciente
  Future<List<Avaliacao>> getListAvaliacao(int idPaciente)async{
    Database db = await this.database;

    List<Avaliacao> consultas;
    List<Map> maps = await db.query(avaliacaoTable,
    columns: [colIdAvaliacoes, colProprietarioId, colDataAvaliacoes, colDesnivelBacia, colDesnivelOmbro, colGibosidade, colRadiografia, colAnguloCobb, colMaturidade],
    where: "$colProprietarioId = ?",
    whereArgs: [idPaciente]
    );

    if(maps.length > 0)
    {
      for(int i = 0; i<maps.length; i++)
      {
        consultas.add(Avaliacao.fromMap(maps[i]));
      }
      return consultas;
    }else{
      return null;
    }
  }

  Future<int> updatePaciente(Paciente paciente) async{
    var db = await this.database;

    var resultado = 
    await db.update(pacienteTable, paciente.toMap(),
    where: '$colId = ?',
    whereArgs: [paciente.id], 
    );

    return resultado;
  }
}