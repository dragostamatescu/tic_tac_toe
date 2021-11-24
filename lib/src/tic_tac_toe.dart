import 'package:flutter/material.dart';

void main() => runApp(const TicTacToeApp());

class TicTacToeApp extends StatelessWidget {
  const TicTacToeApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      title: 'Tic Tac Toe',
      home: HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final List<Color> _tileList = List<Color>.filled(9, Colors.white);
  List<int> _winnerList = <int>[];
  bool _player = false;
  bool _gameEnded = false;

  List<int> checkWinner() {
    final List<int> winnerList = <int>[];

    //check winner on lines
    if (_tileList[0] == _tileList[1] && _tileList[1] == _tileList[2] && _tileList[2] != Colors.white) {
      winnerList.add(0);
      winnerList.add(1);
      winnerList.add(2);
    }
    if (_tileList[3] == _tileList[4] && _tileList[4] == _tileList[5] && _tileList[5] != Colors.white) {
      winnerList.add(3);
      winnerList.add(4);
      winnerList.add(5);
    }
    if (_tileList[6] == _tileList[7] && _tileList[7] == _tileList[8] && _tileList[8] != Colors.white) {
      winnerList.add(6);
      winnerList.add(7);
      winnerList.add(8);
    }

    // check winner on columns
    if (_tileList[0] == _tileList[3] && _tileList[3] == _tileList[6] && _tileList[6] != Colors.white) {
      winnerList.add(0);
      winnerList.add(3);
      winnerList.add(6);
    }
    if (_tileList[1] == _tileList[4] && _tileList[4] == _tileList[7] && _tileList[7] != Colors.white) {
      winnerList.add(1);
      winnerList.add(4);
      winnerList.add(7);
    }
    if (_tileList[2] == _tileList[5] && _tileList[5] == _tileList[8] && _tileList[8] != Colors.white) {
      winnerList.add(2);
      winnerList.add(5);
      winnerList.add(8);
    }

    // check winner on diagonals
    if (_tileList[0] == _tileList[4] && _tileList[4] == _tileList[8] && _tileList[8] != Colors.white) {
      winnerList.add(0);
      winnerList.add(4);
      winnerList.add(8);
    }
    if (_tileList[2] == _tileList[4] && _tileList[4] == _tileList[6] && _tileList[6] != Colors.white) {
      winnerList.add(2);
      winnerList.add(4);
      winnerList.add(6);
    }

    // check if game ended with no winner
    if (winnerList.isEmpty && !_tileList.contains(Colors.white)) {
      _gameEnded = true;
    }

    return winnerList;
  }

  void resetBoard() {
    for (int i = 0; i < 9; ++i) {
      _tileList[i] = Colors.white;
    }
    _gameEnded = false;
    _player = false;
  }

  void showcaseLine() {
    for (int i = 0; i < 9; ++i) {
      if (!_winnerList.contains(i)) {
        _tileList[i] = Colors.white;
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Center(child: Text('Tic Tac Toe'))),
      body: Column(
        children: <Widget>[
          Expanded(
            child: GridView.builder(
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 3,
              ),
              itemCount: 9,
              itemBuilder: (BuildContext context, int index) {
                final Color color = _tileList[index];
                return GestureDetector(
                  child: AnimatedContainer(
                    duration: const Duration(milliseconds: 300),
                    decoration: BoxDecoration(
                      border: Border.all(),
                      color: color,
                    ),
                  ),
                  onTap: () {
                    setState(
                      () {
                        if (color == Colors.white) {
                          _tileList[index] = _player ? Colors.green : Colors.red;
                          _winnerList = checkWinner();
                          if (_winnerList.isNotEmpty) {
                            showcaseLine();
                            _gameEnded = true;
                          } else {
                            _player = !_player;
                          }
                        }
                      },
                    );
                  },
                );
              },
            ),
          ),
          Align(
            alignment: Alignment.topCenter,
            child: Visibility(
              // ignore: avoid_bool_literals_in_conditional_expressions
              visible: _gameEnded ? true : false,
              child: OutlinedButton(
                child: const Text('Play again!'),
                onPressed: () {
                  setState(
                    () {
                      resetBoard();
                    },
                  );
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}
