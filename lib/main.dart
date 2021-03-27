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
  var _boardState = List.filled(9, TileState.EMPTY);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: Center(
          child: Stack(
            children: [
              Image.asset('images/board.png'),
              _boardTiles(),
            ],
          ),
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
                  onPressed: () => print("Tapped index $tileIndex"),
                );
              }).toList(),
            );
          }).toList(),
        ),
      );
    });
  }
}
