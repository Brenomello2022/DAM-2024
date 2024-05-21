import 'package:app_play_store_games/database/database_provider.dart';
import 'package:app_play_store_games/model/game.dart';

class GameDao {
  final dbProvider = DatabaseProvider.instance;

  Future<bool> salvar(Games game) async {
    final db = await dbProvider.database;
    final valores = game.toMap();
    if (game.id == null) {
      game.id = await db.insert(Games.tabela_games, valores);
      return true;
    } else {
      final registrosAtualizados = await db.update(
          Games.campo_nome, valores,
          where: '${Games.campo_id} = ?',
          whereArgs: [Games.campo_id]);

      return registrosAtualizados > 0;
    }
  }

  Future<bool> remover(int id) async {
    final db = await dbProvider.database;
    final removerRegistro = await db.delete(Games.tabela_games,
        where: '${Games.campo_id} = ?', whereArgs: [id]);

    return removerRegistro > 0;
  }

  Future<List<Games>> Lista({
    String filtro = '',
    String campoOrdenacao = Games.campo_id,
    bool usarOrdemDecrescente = false,
  }) async {
    final db = await dbProvider.database;
    String? where;
    if (filtro.isNotEmpty) {
      where = "UPPER(${Games.campo_descricao}) LIKE '${filtro.toUpperCase()}%'";
    }

    var orderBy = campoOrdenacao;

    if (usarOrdemDecrescente) {
      orderBy += ' DESC';
    }

    final resultado = await db.query(Games.tabela_games,
      columns: [
        Games.campo_id,
        Games.campo_nome,
        Games.campo_descricao,
        Games.campo_preco,
        Games.campo_avaliacao,
        Games.campo_imagem],
      where: where,
      orderBy: orderBy,
    );
    return resultado.map((m) => Games.fromMap(m)).toList();
  }
}