import 'dart:async';
import 'dart:io';
import 'package:flutter/cupertino.dart';
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
  String colUid = 'uid';
  String colNome = 'nome';
  String colSexo = 'sexo';
  String colNascimento = 'nascimento';
  String colAvaliacoes = 'avaliacoes';

  //usado para definir as colunas Avaliações
  String avaliacaoTable = 'avaliacoes';
  String colIdAvaliacoes = 'id';
  String colProprietarioId = 'proprietarioid';
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

  Future<void> _createDb(Database db, int version) async{
    await db.execute('PRAGMA foreign_keys = ON');
    await db.execute("CREATE TABLE $pacienteTable($colId INTEGER PRIMARY KEY AUTOINCREMENT, $colUid TEXT, $colNome TEXT, $colSexo TEXT, $colNascimento TEXT)");
    await db.execute("CREATE TABLE $avaliacaoTable($colIdAvaliacoes INTEGER PRIMARY KEY AUTOINCREMENT, $colProprietarioId INTEGER, $colDataAvaliacoes TEXT, $colDesnivelOmbro INTEGER, $colDesnivelBacia INTEGER, $colGibosidade INTEGER, $colRadiografia INTEGER, $colAnguloCobb INTEGER, $colMaturidade INTEGER)");
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

  //Retorna todos os pacientes de um usuario
  Future<List<Paciente>> getAllPaciente(String uid) async {
    Database db = await this.database;

    List<Paciente> listAll;
    
    List<Map> pacientes = await db.query(pacienteTable,
    where: "$colUid = ?",
    whereArgs: [uid],
    );

    listAll = pacientes.isNotEmpty ? pacientes.map((e) => Paciente.fromMap(e)).toList() : [];
      return listAll;
    }
  
  
  //Retorna um paciente específico
  Future<Paciente> getPaciente(int idPaciente) async{
    Database db = await this.database;
    List<Map> maps = await db.query(pacienteTable,
    columns: [colId, colUid, colNome, colSexo, colNascimento],
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
    where: "$colProprietarioId = ?",
    whereArgs: [idPaciente]
    );

    consultas = maps.isNotEmpty ? maps.map((e) => Avaliacao.fromMap(e)).toList() : [];
      return consultas;
  }

  //Atualizar um Paciente
  Future<int> updatePaciente(Paciente paciente) async{
    var db = await this.database;

    var resultado = 
    await db.update(pacienteTable, paciente.toMap(),
    where: '$colId = ?',
    whereArgs: [paciente.id], 
    );
    return resultado;
  }

  //Excluir um paciente ById
  Future<int> deletarPaciente(int id) async{
    var db = await this.database;

    await db.delete(avaliacaoTable, 
    where: "$colProprietarioId = ?",
    whereArgs: [id]
    );
  
    int resultado = await db.delete(pacienteTable,
    where: "$colId = ?",
    whereArgs: [id]
    );

    return resultado;
  }

  //Exclui uma avaliação
  Future<int> deletarConsulta(int id) async{
    var db = await this.database;
  
    int resultado = await db.delete(avaliacaoTable,
    where: "$colIdAvaliacoes = ?",
    whereArgs: [id]
    );

    return resultado;
  }

  Future<String> getCountPaciente() async{
    Database db = await this.database;
    List<Map<String,dynamic>> x = await db.rawQuery('SELECT COUNT (*) FROM $pacienteTable');

    var resultado  = Sqflite.firstIntValue(x).toString();
    return resultado;
  }

  Future<int> getCountConsultas() async{
    Database db = await this.database;
    List<Map<String,dynamic>> x = await db.rawQuery('SELECT COUNT (*) FROM $avaliacaoTable');

    int resultado  = Sqflite.firstIntValue(x);
    return resultado;
  }

  Future close() async{
    Database db = await this.database;
    db.close();
  }

}