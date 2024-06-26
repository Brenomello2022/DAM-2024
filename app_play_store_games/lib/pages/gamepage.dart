import 'package:flutter/material.dart';
import 'package:app_play_store_games/models/gamemodel.dart';
import 'package:app_play_store_games/dao/game_dao.dart';
import 'package:app_play_store_games/pages/filterpage.dart';

class GamePage extends StatefulWidget {
  const GamePage({Key? key}) : super(key: key);

  @override
  _GamePageState createState() => _GamePageState();

  static List<Games> getGamesList() {
    return [
      Games(
        id: 1,
        nome: "Stumble Guys",
        descricao:
        "Stumble Guys é um grande jogo de eliminatórias multijogador com até 32 jogadores on-line. Junte-se a milhões de jogadores e tropece por aí para alcançar a vitória neste divertido battle royale de eliminatórias multijogador! Você está preparado para participar da corrida caótica? Correr, tropeçar, cair, pular e vencer nunca foi tão divertido!",
        preco: 11.20,
        avaliacao: 4.3,
        imagem: "assets/stumble_guys.png",
        categoria: "Ação",
      ),
      Games(
        id: 2,
        nome: "Roblox",
        descricao:
        "A Roblox é o universo virtual definitivo que permite que você crie, compartilhe experiências com amizades e seja o que quiser imaginar. Junte-se a milhões de pessoas e descubra uma variedade infinita de experiências imersivas criadas por uma comunidade global!",
        preco: 10.20,
        avaliacao: 4.4,
        imagem: "assets/roblox.png",
        categoria: "Aventura",
      ),
      Games(
        id: 3,
        nome: "Poppy Playtime Chapter 1",
        descricao:
        "Você deve permanecer vivo nesta aventura de terror/quebra-cabeça. Tente sobreviver aos brinquedos vingativos que esperam por você na fábrica de brinquedos abandonada. Use seu GrabPack para hackear circuitos elétricos ou capturar qualquer coisa à distância. Explore a instalação misteriosa... e não seja pego.",
        preco: 14.99,
        avaliacao: 4.6,
        imagem: "assets/poppy_playtime.png",
        categoria: "Terror",
      ),
      Games(
        id: 4,
        nome: "Fran Bow",
        descricao:
        "Depois de testemunhar a morte horrível dos pais, uma garotinha peculiar chamada Fran é presa no Hospício Oswald. Para sobreviver aos experimentos cruéis do hospício, Fran se automedica e ganha a habilidade de ver um mundo alternativo sinistro: a Ultrarrealidade.",
        preco: 13.35,
        avaliacao: 4.3,
        imagem: "assets/fran_bow.png",
        categoria: "Terror",
      ),
      Games(
        id: 5,
        nome: "Minecraft",
        descricao:
        "Minecraft é um jogo feito de blocos que você pode transformar em tudo que puder imaginar. Jogue no modo Criativo com recursos ilimitados, ou cace ferramentas para se defender do perigo no modo Sobrevivência.",
        preco: 35.99,
        avaliacao: 4.5,
        imagem: "assets/minecraft_pocket_edition.png",
        categoria: "Aventura",
      ),
      Games(
        id: 6,
        nome: "Among Us",
        descricao:
        "Jogue on-line ou via WiFi local com 4 a 15 jogadores enquanto tenta preparar sua nave espacial para a partida, mas cuidado, pois um deles será um impostor determinado a matar todos! Os tripulantes podem vencer completando todas as tarefas ou descobrindo e votando no impostor para fora do navio. O Impostor pode usar a sabotagem para causar o caos, tornando as mortes mais fáceis e melhores álibis.",
        preco: 17.50,
        avaliacao: 3.5,
        imagem: "assets/among_us.png",
        categoria: "Ação",
      ),
      Games(
        id: 7,
        nome: "PUBG Mobile",
        descricao:
        "Vários eventos para você explorar. Chegue ao topo no PUBG MOBILE e largue o dedo no gatilho. Na zona de combate, cada disparo pode mudar o jogo. O PUBG MOBILE é o jogo original de Battle Royale para celular e um dos melhores jogos de tiro para celular.",
        preco: 16.40,
        avaliacao: 4.4,
        imagem: "assets/pubg_mobile.png",
        categoria: "Ação",
      ),
      Games(
        id: 8,
        nome: "Subway Surfs",
        descricao:
        "CORRA o mais rápido que puder! DESVIE os trens que se aproximam! Ajude Jake, Tricky e Fresh a escapar do mal-humorado Inspetor e de seu cachorro.",
        preco: 10.50,
        avaliacao: 4.8,
        imagem: "assets/subway_surfers.png",
        categoria: "Aventura",
      ),
    ];
  }
}

class _GamePageState extends State<GamePage> {
  final GameDao _gameDao = GameDao();
  List<Games> _games = [];

  @override
  void initState() {
    super.initState();
    _loadGames();
  }

  void _loadGames() async {
    await Future.delayed(Duration(seconds: 1));
    setState(() {
      _games = GamePage.getGamesList();
    });
  }

  void _applyFilters(Map<String, String>? filters) {
    if (filters != null) {
      List<Games> filteredGames = GamePage.getGamesList();

      if (filters['category']!.isNotEmpty) {
        filteredGames = filteredGames
            .where((game) => game.categoria == filters['category'])
            .toList();
      }

      switch (filters['sortBy']) {
        case 'AlfabéticaAscendente':
          filteredGames.sort((a, b) => a.nome.compareTo(b.nome));
          break;
        case 'AlfabéticaDescendente':
          filteredGames.sort((a, b) => b.nome.compareTo(a.nome));
          break;
        case 'AvaliaçãoCrescente':
          filteredGames.sort((a, b) => a.avaliacao.compareTo(b.avaliacao));
          break;
        case 'AvaliaçãoDecrescente':
          filteredGames.sort((a, b) => b.avaliacao.compareTo(a.avaliacao));
          break;
        case 'PreçoCrescente':
          filteredGames.sort((a, b) => a.preco.compareTo(b.preco));
          break;
        case 'PreçoDecrescente':
          filteredGames.sort((a, b) => b.preco.compareTo(a.preco));
          break;
      }

      setState(() {
        _games = filteredGames;
      });
    }
  }

  void _openFilterPage() async {
    final filters = await Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => FilterPage()),
    );
    _applyFilters(filters as Map<String, String>?);
  }

  void _showDescription(String description) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Descrição do Jogo'),
          content: SingleChildScrollView(
            child: Text(description),
          ),
          actions: <Widget>[
            ButtonBar(
              alignment: MainAxisAlignment.end,
              children: [
                TextButton(
                  child: Text('Fechar'),
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                ),
              ],
            ),
          ],
        );
      },
    );
  }

  void _showNotAvailableMessage() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Função não disponível'),
          content: Text(
            'Este aplicativo ainda não possui essa funcionalidade!',
            style: TextStyle(color: Colors.red),
          ),
          actions: <Widget>[
            TextButton(
              child: Text('Fechar'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Play Store Games'),
        centerTitle: true,
      ),
      body: Column(
        children: [
          Center(
            child: ElevatedButton(
              onPressed: _openFilterPage,
              child: Text('Filtrar Jogos'),
            ),
          ),
          Expanded(
            child: _games.isEmpty
                ? Center(child: CircularProgressIndicator())
                : ListView.builder(
              itemCount: _games.length,
              itemBuilder: (context, index) {
                final game = _games[index];
                return Card(
                  color: Colors.grey.shade300,
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        ClipRRect(
                          borderRadius: BorderRadius.circular(8.0),
                          child: Image.asset(
                            game.imagem,
                            width: 80,
                            height: 80,
                            fit: BoxFit.cover,
                          ),
                        ),
                        SizedBox(width: 16),
                        Expanded(
                          child: Column(
                            crossAxisAlignment:
                            CrossAxisAlignment.start,
                            children: [
                              Text(
                                game.nome,
                                style: TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              SizedBox(height: 8),
                              Row(
                                children: [
                                  Text(
                                    'Preço: ',
                                    style: TextStyle(
                                      color: Colors.black,
                                    ),
                                  ),
                                  Text(
                                    'R\$ ${game.preco.toStringAsFixed(2).replaceAll('.', ',')}',
                                    style: TextStyle(
                                      color: Colors.blue,
                                    ),
                                  ),
                                ],
                              ),
                              Row(
                                children: [
                                  Text(
                                    'Avaliação: ',
                                    style: TextStyle(
                                      color: Colors.black,
                                    ),
                                  ),
                                  Text(
                                    '${game.avaliacao}',
                                    style: TextStyle(
                                      color: Colors.green,
                                    ),
                                  ),
                                ],
                              ),
                              SizedBox(height: 8),
                              Row(
                                children: [
                                  ElevatedButton(
                                    onPressed: () =>
                                        _showDescription(game.descricao),
                                    child: Text('Descrição'),
                                  ),
                                  SizedBox(width: 8),
                                  ElevatedButton(
                                    onPressed: _showNotAvailableMessage,
                                    child: Text('Jogar'),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

void main() {
  runApp(MaterialApp(
    home: GamePage(),
  ));
}
