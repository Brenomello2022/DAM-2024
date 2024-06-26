import 'package:app_play_store_games/models/gamemodel.dart';
import 'package:app_play_store_games/database/database_provider.dart';

class GameDao {
  final dbProvider = DatabaseProvider.instance;

  Future<int> insertGame(Games game) async {
    final db = await dbProvider.database;
    return await db.insert(Games.tabela_games, game.toMap());
  }

  Future<List<Games>> getAllGames() async {
    final db = await dbProvider.database;
    var games = await db.query(Games.tabela_games);
    return games.map((gameMap) => Games.fromMap(gameMap)).toList();
  }
}
