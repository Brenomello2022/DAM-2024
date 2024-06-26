import 'package:flutter/material.dart';
import 'package:app_play_store_games/models/gamemodel.dart';
import 'package:app_play_store_games/pages/gamepage.dart';
import 'package:app_play_store_games/services/gps_service.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final TextEditingController _searchController = TextEditingController();
  List<Games> _games = [];
  bool _showGames = false;
  bool _gameFound = false;

  @override
  void initState() {
    super.initState();
    _searchController.addListener(_handleSearchTextChange);
  }

  void _handleSearchTextChange() {
    setState(() {
      _gameFound = false;
    });
  }

  void _filterGames() {
    final query = _searchController.text.toLowerCase();
    List<Games> allGames = GamePage.getGamesList();

    if (query.isEmpty) {
      setState(() {
        _showGames = false;
      });
      return;
    }

    List<Games> filteredGames = allGames.where((game) =>
    game.nome.toLowerCase().contains(query) ||
        game.descricao.toLowerCase().contains(query) ||
        game.categoria.toLowerCase().contains(query)
    ).toList();

    if (filteredGames.isNotEmpty) {
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: Text(
            'Jogo localizado!',
          ),
          content: Text(
            'O jogo que você pesquisou foi encontrado!',
            style: TextStyle(color: Colors.red),
          ),
          actions: <Widget>[
            TextButton(
              child: Text('OK'),
              onPressed: () {
                Navigator.of(context).pop();
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => GamePage()),
                );
              },
            ),
          ],
        ),
      );
      setState(() {
        _showGames = false;
        _gameFound = true;
      });
    } else {
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: Text(
            'Jogo não encontrado',
          ),
          content: Text(
            'O jogo que você pesquisou não existe ou não está disponível no momento! Tente novamente mais tarde!',
            style: TextStyle(color: Colors.red),
          ),
          actions: <Widget>[
            TextButton(
              child: Text('OK'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        ),
      );
      setState(() {
        _showGames = false;
        _gameFound = false;
      });
    }
  }


  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Página Inicial',
          textAlign: TextAlign.center,
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            Container(
              alignment: Alignment.center,
              child: Column(
                children: [
                  Image.asset(
                    'assets/games1.png',
                    width: 200,
                    height: 200,
                  ),
                  Text(
                    'Bem-vindo ao mundo dos jogos,\nonde a diversão nunca tem fim!',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 18.0,
                      fontWeight: FontWeight.bold,
                      color: Colors.blue,
                    ),
                  ),
                  SizedBox(height: 16.0),
                ],
              ),
            ),
            SizedBox(height: 16.0),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: GestureDetector(
                onTap: () {
                  FocusScope.of(context).requestFocus(
                      FocusNode());
                },
                child: TextField(
                  controller: _searchController,
                  decoration: InputDecoration(
                    labelText: 'Pesquisar Jogos Disponíveis',
                    border: OutlineInputBorder(),
                  ),
                  onTap: () {
                    _searchController
                        .clear();
                  },
                  onSubmitted: (value) {
                    _filterGames();
                  },
                ),
              ),
            ),
            _showGames
                ? Center(
              child: CircularProgressIndicator(),
            )
                : SizedBox.shrink(),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => GamePage()),
                );
              },
              child: Text('Jogos Disponíveis'),
            ),
            SizedBox(height: 16.0),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => GpsService()),
                );
              },
              child: Text('Voltar Para a Localização'),
            ),
            SizedBox(height: 16.0),
          ],
        ),
      ),
    );
  }
}
