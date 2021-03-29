import 'package:day7/board_tile.dart';
import 'package:day7/tile_state.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final navigatorKey = GlobalKey<NavigatorState>();

  int movesCount = 0;

  var _boardState = List.filled(9, TileState.EMPTY);

  var _currentTurn = TileState.CROSS;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      navigatorKey: navigatorKey,
      home: Scaffold(
        backgroundColor: Colors.grey[700],
        appBar: AppBar(
          backgroundColor: Colors.grey[900],
          title: Text("Darbadarlar makoni"),
        ),
        body: Container(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                child: SizedBox(
                  width: 230,
                  height: 60,
                  child: Center(
                    child: Text(
                      "${_currentTurn == TileState.CROSS ? "X" : "O"}  ning navbati",
                      style: TextStyle(
                        color: Colors.grey[200],
                        fontSize: 27.0,
                      ),
                    ),
                  ),
                ),
                decoration: BoxDecoration(
                  border: Border.all(
                    color: Colors.grey[600],
                    width: 8.0,
                  ),
                  borderRadius: 
                  BorderRadius.circular(5)
                ),
              ),
              SizedBox(
                height: 80.0,
              ),
              Stack(
                children: [
                  Image.asset(
                    'images/board.png',
                    color: Colors.grey[800],
                  ),
                  _boardTiles(),
                ],
              ),
            ],
          ),
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: _resetGame,
          backgroundColor: Colors.grey[800],
          child: Icon(Icons.rotate_left_rounded),
        ),
      ),
    );
  }

  Widget _boardTiles() {
    return Builder(builder: (context) {
      final boardDimension = MediaQuery.of(context).size.width;

      final tileDimension = boardDimension / 3;

      return Container(
        width: boardDimension,
        height: boardDimension,
        child: Column(
          children: chunk(_boardState, 3).asMap().entries.map((entry) {
            final chunkIndex = entry.key;
            final tileStateChunk = entry.value;
            return Row(
              children: tileStateChunk.asMap().entries.map((innerEntry) {
                final innerIndex = innerEntry.key;
                final tileState = innerEntry.value;
                final tileIndex = (chunkIndex * 3) + innerIndex;
                return BoardTile(
                  tileState: tileState,
                  dimension: tileDimension,
                  onPressed: () => _updateTileStateForIndex(tileIndex),
                );
              }).toList(),
            );
          }).toList(),
        ),
      );
    });
  }

  void _updateTileStateForIndex(int selectedIndex) {
    if (_boardState[selectedIndex] == TileState.EMPTY) {
      setState(() {
        _boardState[selectedIndex] = _currentTurn;
        _currentTurn = _currentTurn == TileState.CROSS
            ? TileState.CIRCLE
            : TileState.CROSS;
      });

      final winner = _findWinner();
      if (winner == TileState.CIRCLE || winner == TileState.CROSS) {
        print("Winner is : $winner");
        _showWinnerDialog(winner, "Bizda g'olib mavjud!");
      } else if (winner == TileState.EQUAL) {
        _showWinnerDialog(winner, "Do'stlik g'alaba qozondi!");
      }
    }
  }

  TileState _findWinner() {
    TileState Function(int, int, int) winnerForMatch = (a, b, c) {
      if (_boardState[a] != TileState.EMPTY) {
        if ((_boardState[a] == _boardState[b]) &&
            (_boardState[b] == _boardState[c])) {
          return _boardState[a];
        }
      }
      return null;
    };

    final checks = [
      winnerForMatch(0, 1, 2),
      winnerForMatch(3, 4, 5),
      winnerForMatch(6, 7, 8),
      winnerForMatch(0, 3, 6),
      winnerForMatch(1, 4, 7),
      winnerForMatch(2, 5, 8),
      winnerForMatch(0, 4, 8),
      winnerForMatch(2, 4, 6),
    ];

    movesCount = movesCount + 1 < 10 ? movesCount + 1 : movesCount;

    TileState winner;

    for (int i = 0; i < checks.length; i++) {
      if (checks[i] != null) {
        winner = checks[i];
        break;
      }
    }

    if (winner == null) if (movesCount == 9) {
      winner = TileState.EQUAL;
    }

    print(movesCount.toString());
    print(winner.toString());
    return winner;
  }

  void _showWinnerDialog(TileState tileState, String _title) {
    final context = navigatorKey.currentState.overlay.context;

    showDialog(
        context: context,
        builder: (_) {
          return AlertDialog(
            title: Text(
              _title,
              style: TextStyle(color: Colors.white),
            ),
            backgroundColor: Colors.grey[700],
            content: Image.asset(tileState == TileState.EQUAL
                ? "images/handshake.png"
                : tileState == TileState.CROSS
                    ? "images/x.png"
                    : "images/o.png"),
            actions: [
              TextButton(
                onPressed: () {
                  _resetGame();
                  Navigator.of(context).pop();
                },
                child: Text(
                  "Qayta boshlash",
                  style: TextStyle(
                    color: Colors.white,
                  ),),
              ),
            ],
          );
        });
  }

  void _resetGame() {
    setState(() {
      _boardState = List.filled(9, TileState.EMPTY);
      _currentTurn = TileState.CROSS;
      movesCount = 0;
    });
  }
}
