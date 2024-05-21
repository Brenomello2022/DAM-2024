import 'package:app_play_store_games/model/game.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

class DetalheGamePage extends StatefulWidget{
   final Games games;

   const DetalheGamePage({ Key? key, required this.games}) : super(key: key);

   @override
   DetalheGamePageState createState() => DetalheGamePageState();
}

class DetalheGamePageState extends State<DetalheGamePage>{

  @override
  Widget build(BuildContext context){
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.primaryContainer,
        title: const Text('Detalhes do Jogo'),
        centerTitle: false,
      ),
      body: _criarBody(),
    );
  }

  Widget _criarBody() {
    return Padding(
      padding: EdgeInsets.all(10),
      child: ListView(
        children: [
          Row(
            children: [
              Campo(descricao: 'Código:'),
              Valor(valor: '${widget.games.id}'),
            ],
          ),
          Row(
            children: [
              Campo(descricao: 'Nome:'),
              Valor(valor: Games.campo_nome),
            ],
          ),
          Row(
            children: [
              Campo(descricao: 'Descrição:'),
              Valor(valor: Games.campo_descricao),
            ],
          ),
          Row(
            children: [
              Campo(descricao: 'Preço:'),
              Valor(valor: Games.campo_preco),
            ],
          ),
          Row(
            children: [
              Campo(descricao: 'Avaliação:'),
              Valor(valor: Games.campo_avaliacao),
            ],
          ),
          Row(
            children: [
              Campo(descricao: 'Imagem:'),
              Valor(valor: Games.campo_imagem),
            ],
          ),
        ],
      ),
    );
  }

}

class Campo extends StatelessWidget{
  final String descricao;

  const Campo({ Key? key, required this.descricao}) : super(key: key);

  @override
  Widget build(BuildContext context){
    return Expanded(
        flex: 1,
        child: Text(descricao,
          style: const TextStyle(fontWeight: FontWeight.bold,
          ),
        )
    );
  }

}

class Valor extends StatelessWidget{
  final String valor;

  const Valor({ Key? key, required this.valor}) : super(key: key);

  Widget build(BuildContext context){
    return Expanded(
      flex: 4,
      child: Text(valor == '' ? 'Sem valor' : valor),
    );
  }
}