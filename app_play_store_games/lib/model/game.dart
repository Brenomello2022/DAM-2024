import 'package:intl/intl.dart';

class Games {
  static const tabela_games = 'jogos';
  static const campo_id = '_id';
  static const campo_nome = 'nome';
  static const campo_descricao = 'descrição';
  static const campo_preco = 'preço';
  static const campo_avaliacao = 'avaliação';
  static const campo_imagem = 'imagem';

  int id;
  String nome;
  String descricao;
  double preco;
  double avaliacao;
  String imagem;

  Games({required this.id, required this.nome, required this.descricao,
    required this.preco, required this.avaliacao, required this.imagem});

  Map<String, dynamic> toMap() => <String, dynamic>{
    campo_id: id,
    campo_descricao: descricao,
    campo_nome: nome,
    campo_avaliacao: avaliacao,
    campo_preco: preco,
  };

  factory Games.fromMap(Map<String, dynamic> map) => Games(
    id: map[campo_id] is int ? map[campo_id]: null,
    descricao: map[campo_descricao] is String ? map[campo_descricao] : '',
    nome: map[campo_nome] is String ? map[campo_nome] : '',
    avaliacao: map[campo_avaliacao] is int ? map[campo_avaliacao] : '',
    preco: map[campo_preco] is int ? map[campo_preco] : '',
    imagem: map[campo_imagem] is String ? map[campo_imagem] : '',
  );
}

