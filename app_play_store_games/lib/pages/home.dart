import 'package:flutter/material.dart';
import '../model/game.dart';
import '';

class HomePage extends StatelessWidget {
  final List<Jogos> jogos = [
    Jogos(
      nome: "Stumble Guys",
      descricao: "Stumble Guys é um grande jogo de eliminatórias multijogador com até 32 jogadores on-line. Junte-se a milhões de jogadores e tropece por aí para alcançar a vitória neste divertido battle royale de eliminatórias multijogador! Você está preparado para participar da corrida caótica? Correr, tropeçar, cair, pular e vencer nunca foi tão divertido!",
      preco: 0.00,
      avaliacao: 4.3,
      imagem: "assets/stumble_guys.png",
    ),
    Jogos(
      nome: "Roblox",
      descricao: "A Roblox é o universo virtual definitivo que permite que você crie, compartilhe experiências com amizades e seja o que quiser imaginar. Junte-se a milhões de pessoas e descubra uma variedade infinita de experiências imersivas criadas por uma comunidade global!",
      preco: 0.00,
      avaliacao: 4.4,
      imagem: "assets/roblox.png",
    ),
    Jogos(
      nome: "Poppy Playtime Chapter 1",
      descricao: "Você deve permanecer vivo nesta aventura de terror/quebra-cabeça. Tente sobreviver aos brinquedos vingativos que esperam por você na fábrica de brinquedos abandonada. Use seu GrabPack para hackear circuitos elétricos ou capturar qualquer coisa à distância. Explore a instalação misteriosa... e não seja pego.",
      preco: 14.99,
      avaliacao: 4.6,
      imagem: "assets/poppy_playtime.png",
    ),
    Jogos(
      nome: "Fran Bow",
      descricao: "Depois de testemunhar a morte horrível dos pais, uma garotinha peculiar chamada Fran é presa no Hospício Oswald. Para sobreviver aos experimentos cruéis do hospício, Fran se automedica e ganha a habilidade de ver um mundo alternativo sinistro: a Ultrarrealidade.",
      preco: 0.00,
      avaliacao: 4.3,
      imagem: "assets/fran_bow.png",
    ),
    Jogos(
      nome: "Minecraft",
      descricao: "Minecraft é um jogo feito de blocos que você pode transformar em tudo que puder imaginar. Jogue no modo Criativo com recursos ilimitados, ou cace ferramentas para se defender do perigo no modo Sobrevivência.",
      preco: 35.99,
      avaliacao: 4.5,
      imagem: "assets/minecraft_pocket_edition.png",
    ),
    Jogos(
      nome: "Among Us",
      descricao: "Jogue on-line ou via WiFi local com 4 a 15 jogadores enquanto tenta preparar sua nave espacial para a partida, mas cuidado, pois um deles será um impostor determinado a matar todos! Os tripulantes podem vencer completando todas as tarefas ou descobrindo e votando no impostor para fora do navio. O Impostor pode usar a sabotagem para causar o caos, tornando as mortes mais fáceis e melhores álibis.",
      preco: 0.00,
      avaliacao: 3.5,
      imagem: "assets/among_us.png",
    ),
    Jogos(
      nome: "PUBG Mobile",
      descricao: "Vários eventos para você explorar. Chegue ao topo no PUBG MOBILE e largue o dedo no gatilho. Na zona de combate, cada disparo pode mudar o jogo. O PUBG MOBILE é o jogo original de Battle Royale para celular e um dos melhores jogos de tiro para celular.",
      preco: 0.00,
      avaliacao: 4.3,
      imagem: "assets/pubg_mobile.png",
    ),
    Jogos(
      nome: "Subway Surfs",
      descricao: "CORRA o mais rápido que puder! DESVIE os trens que se aproximam! Ajude Jake, Tricky e Fresh a escapar do mal-humorado Inspetor e de seu cachorro.",
      preco: 5.00,
      avaliacao: 4.8,
      imagem: "assets/subway_surfers.png",
    )
    // adicionar mais jogos
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Play Store Games'),
      ),
      body: ListView.builder(
        itemCount: jogos.length,
        itemBuilder: (context, index) {
          return ListTile(
            leading: Image.network(jogos[index].imagem),
            title: Text(jogos[index].nome),
            subtitle: Text(jogos[index].descricao),
            trailing: Text('\$${jogos[index].preco.toStringAsFixed(3)},   ${jogos[index].avaliacao}'),
            onTap: () {
              // Implementar jogos
            },
          );
        },
      ),
    );
  }
}
