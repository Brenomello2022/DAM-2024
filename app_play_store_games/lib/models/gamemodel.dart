import 'package:intl/intl.dart';

class Games {
  static const String tabela_games = 'jogos';
  static const String campo_id = '_id';
  static const String campo_nome = 'nome';
  static const String campo_descricao = 'descricao';
  static const String campo_preco = 'preco';
  static const String campo_avaliacao = 'avaliacao';
  static const String campo_imagem = 'imagem';
  static const String campo_categoria = 'categoria';

  int id;
  String nome;
  String descricao;
  double preco;
  double avaliacao;
  String imagem;
  String categoria;

  Games({
    required this.id,
    required this.nome,
    required this.descricao,
    required this.preco,
    required this.avaliacao,
    required this.imagem,
    required this.categoria,
  });

  Map<String, dynamic> toMap() => {
    campo_id: id,
    campo_nome: nome,
    campo_descricao: descricao,
    campo_preco: preco,
    campo_avaliacao: avaliacao,
    campo_imagem: imagem,
    campo_categoria: categoria,
  };

  factory Games.fromMap(Map<String, dynamic> map) => Games(
    id: map[campo_id] is int ? map[campo_id] : 0,
    nome: map[campo_nome] is String ? map[campo_nome] : '',
    descricao: map[campo_descricao] is String ? map[campo_descricao] : '',
    preco: map[campo_preco] is double ? map[campo_preco] : 0.0,
    avaliacao: map[campo_avaliacao] is double ? map[campo_avaliacao] : 0.0,
    imagem: map[campo_imagem] is String ? map[campo_imagem] : '',
    categoria: map[campo_categoria] is String ? map[campo_categoria] : '',
  );
}
