import 'dart:async';
import 'dart:io';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:app_play_store_games/models/gamemodel.dart';

class DatabaseProvider {
  static Database? _database;
  static final _databaseName = 'games_database.db';
  static final _databaseVersion = 1;

  DatabaseProvider._();

  static final DatabaseProvider instance = DatabaseProvider._();

  Future<Database> get database async {
    if (_database != null) return _database!;

    _database = await _initDatabase();
    return _database!;
  }

  Future<Database> _initDatabase() async {
    String path = join(await getDatabasesPath(), _databaseName);
    return await openDatabase(
      path,
      version: _databaseVersion,
      onCreate: _createDatabase,
    );
  }

  Future<void> _createDatabase(Database db, int version) async {
    await db.execute('''
      CREATE TABLE ${Games.tabela_games} (
        ${Games.campo_id} INTEGER PRIMARY KEY,
        ${Games.campo_nome} TEXT,
        ${Games.campo_descricao} TEXT,
        ${Games.campo_preco} REAL,
        ${Games.campo_avaliacao} REAL,
        ${Games.campo_imagem} TEXT,
        ${Games.campo_categoria} TEXT
      )
    ''');
  }
}
