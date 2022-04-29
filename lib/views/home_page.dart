import 'package:flutter/material.dart';
import '../models/player.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final _playerOne = Player(name: "TIME 1", score: 0, victories: 0);
  final _playerTwo = Player(name: "TIME 2", score: 0, victories: 0);

  @override
  void initState() {
    super.initState();
    _resetPlayers();
  }

  void _resetPlayer({required Player player, bool resetVictories = true}) {
    setState(() {
      player.score = 0;
      if (resetVictories) player.victories = 0;
    });
  }

  void _resetPlayers({bool resetVictories = true}) {
    _resetPlayer(player: _playerOne, resetVictories:  resetVictories);
    _resetPlayer(player: _playerTwo, resetVictories:  resetVictories);
  }

  void _checkPlayerWin({required Player player}) {
    if (player.score == 12) {
      _showDialog(
          title: 'Fim de Jogo',
          message: '${player.name} ganhou!!',
          confirm: () {
            setState(() {
              player.victories++;
            });
            _resetPlayers(resetVictories: false);
          },
          cancel: () {
            setState(() {
              player.score--;
            });
          }
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.indigo,
        title: const Text("Marcador Pontos (Truco!)"),
        actions: <Widget>[
          IconButton(
            onPressed: () {
              _showDialog(
                  title: 'Zerar',
                  message:
                  'Tem certeza que deseja começar novamente a pontuação?',
                  confirm: () {},
                  cancel: () {}
              );
            },
            icon: const Icon(Icons.refresh),
          )
        ],
      ),
      body: _showPlayers(),
    );
  }

  Widget _showPlayerBoard(Player player) {
    return Expanded(
      flex: 1,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          _showPlayerName(player.name),
          _showPlayerScore(player.score),
          _showPlayerVictories(player.victories),
          _showScoreButtons(player),
        ],
      ),
    );
  }

  Widget _showPlayers() {
    return Row(
      mainAxisSize: MainAxisSize.max,
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: <Widget>[
        _showPlayerBoard(_playerOne),
        _showPlayerBoard(_playerTwo),
      ],
    );
  }

  Widget _showPlayerName(String name) {
    return Text(
      name.toUpperCase(),
      style: const TextStyle(
          fontSize: 22.0,
          fontWeight: FontWeight.w500,
          color: Colors.black),
    );
  }

  Widget _showPlayerVictories(int victories) {
    return Text(
      "vitórias ( $victories )",
      style: const TextStyle(fontSize: 18.0, fontWeight: FontWeight.w300),
    );
  }

  Widget _showPlayerScore(int score) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 52.0),
      child: Text(
        "$score",
        style: const TextStyle(fontSize: 120.0),
      ),
    );
  }

  Widget _buildRoundedButton(
      {required String text, double size = 52.0, required Color color, required void Function() onTap}) {
    return GestureDetector(
      onTap: onTap,
      child: ClipOval(
        child: Container(
          color: color,
          height: size,
          width: size,
          child: Center(
              child: Text(
                text,
                style: const TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),
              )),
        ),
      ),
    );
  }

  Widget _showScoreButtons(Player player) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: <Widget>[
        _buildRoundedButton(
          text: '-1',
          color: Colors.black.withOpacity(0.1),
          onTap: () {
            setState(() {
              player.score--;
            });
          },
        ),
        _buildRoundedButton(
          text: '+1',
          color: Colors.indigoAccent,
          onTap: () {
            setState(() {
              player.score++;
            });
            _checkPlayerWin(player: player);
          },
        ),
      ],
    );
  }

  void _showDialog(
      {required String title, required String message, required Function confirm, required Function cancel}) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(title),
          content: Text(message),
          actions: <Widget>[
            ElevatedButton(
              child: const Text("CANCEL"),
              onPressed: () {
                Navigator.of(context).pop();
                cancel();
              },
            ),
            ElevatedButton(
              child: const Text("OK"),
              onPressed: () {
                Navigator.of(context).pop();
                confirm();
              },
            ),
          ],
        );
      },
    );
  }
}