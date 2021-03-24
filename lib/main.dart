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
          children: [
            Row(
              children: [
                BoardTile(dimension: tileDimension, tileState: TileState.CROSS,),
                BoardTile(dimension: tileDimension, tileState: TileState.CROSS,),
                BoardTile(dimension: tileDimension, tileState: TileState.CROSS,),
              ],
            ),
            Row(
              children: [
                BoardTile(dimension: tileDimension, tileState: TileState.CROSS,),
                BoardTile(dimension: tileDimension, tileState: TileState.CROSS,),
                BoardTile(dimension: tileDimension, tileState: TileState.CROSS,),
              ],
            ),
            Row(
              children: [
                BoardTile(dimension: tileDimension, tileState: TileState.CROSS,),
                BoardTile(dimension: tileDimension, tileState: TileState.CROSS,),
                BoardTile(dimension: tileDimension, tileState: TileState.CROSS,),
              ],
            ),
          ],
        ),
      );
    });
  }
}
