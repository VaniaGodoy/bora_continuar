import 'package:sqflite/sqflite.dart';
import 'dart:async';
import 'dart:io';
import 'package:path_provider/path_provider.dart';

import '../model/exercicio.dart';

class DbHelper {

  // Atributos:
  // nome da tabela e nomes das colunas

  String tblExercicio = "exercicio";

  String colId = "id";
  String colNome = "nome";
  String colGrupoMuscular = "grupoMuscular";
  String colSeries = "series";
  String colRepeticoes = "repeticoes";
  String colDuracao = "duracao";
  String colNivel = "nivel";


  // Construtor nomeado privado

  DbHelper._internal();


  // Instância única da classe (Singleton)

  static final DbHelper _dbHelper = DbHelper._internal();


  // Construtor Factory que retorna sempre
  // a mesma instância

  factory DbHelper() {
    return _dbHelper;
  }


  // Referência para o banco de dados

  static Database? _db;


  // Getter para o banco

  Future<Database> get db async {

    if (_db == null) {
      _db = await initializeDb();
    }

    return _db!;
  }


  // Inicializa o banco de dados

  Future<Database> initializeDb() async {

    // Busca o diretório de documentos do aplicativo

    Directory dir =
    await getApplicationDocumentsDirectory();


    // Caminho físico do banco

    String path = dir.path + "/bora_continuar.db";


    // Abre o banco de dados

    var dbExercicios = await openDatabase(
      path,
      version: 1,
      onCreate: _createDb,
    );

    return dbExercicios;
  }


  // Cria a tabela quando o banco não existir

  void _createDb(
      Database db,
      int newVersion,
      ) async {

    await db.execute(
        "CREATE TABLE $tblExercicio("
            "$colId INTEGER PRIMARY KEY, "
            "$colNome TEXT, "
            "$colGrupoMuscular TEXT, "
            "$colSeries INTEGER, "
            "$colRepeticoes INTEGER, "
            "$colDuracao INTEGER, "
            "$colNivel TEXT)"
    );
  }


  // Insere um exercício no banco

  Future<int> insertExercicio(
      Exercicio exercicio) async {

    Database db = await this.db;

    var result = await db.insert(
      tblExercicio,
      exercicio.toMap(),
    );

    return result;
  }


  // Recupera todos os exercícios

  Future<List> getExercicios() async {

    Database db = await this.db;

    var result = await db.rawQuery(
        "SELECT * FROM $tblExercicio "
            "ORDER BY $colNome ASC"
    );

    return result;
  }


  // Recupera o número de exercícios

  Future<int> getCount() async {

    Database db = await this.db;

    var result = Sqflite.firstIntValue(
      await db.rawQuery(
          "SELECT COUNT(*) FROM $tblExercicio"
      ),
    );

    return result!;
  }


  // Atualiza um exercício

  Future<int> updateExercicio(
      Exercicio exercicio) async {

    var db = await this.db;

    var result = await db.update(
      tblExercicio,
      exercicio.toMap(),
      where: "$colId = ?",
      whereArgs: [exercicio.id],
    );

    return result;
  }


  // Apaga um exercício

  Future<int> deleteExercicio(int id) async {

    int result;

    var db = await this.db;

    result = await db.rawDelete(
        'DELETE FROM $tblExercicio '
            'WHERE $colId = $id'
    );

    return result;
  }
}