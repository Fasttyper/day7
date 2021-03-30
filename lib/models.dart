import 'dart:math';

enum TileState{
  EMPTY,
  CROSS,
  CIRCLE,
  EQUAL,
}

List<List<TileState>> chunk(List<TileState> list, int size){
  return List.generate(
    (list.length / size).ceil(), 
    (index) => list.sublist(index * size,
      min(index * size + size, list.length),
    ),
  );
}

class SceneState{
  
  TileState currentTurn;
  int movesCount;
  List<TileState> tilesState;

  SceneState({this.currentTurn, this.movesCount, this.tilesState });
}