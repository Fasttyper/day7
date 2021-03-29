import 'package:day7/tile_state.dart';
import 'package:flutter/material.dart';

class BoardTile extends StatelessWidget{

  final double dimension;

  final VoidCallback onPressed;

  final TileState tileState;

  BoardTile({Key key, this.tileState, this.dimension, this.onPressed,}) : super(key: key);

  @override
  Widget build(BuildContext context){
    return Container(
      width: dimension,
      height: dimension,
      //color: Colors.blue,
      child: IconButton(
        onPressed: onPressed,
        icon: _widgetForTileState(),
      ),
    );
  }

  Widget _widgetForTileState(){

    Widget widget;

    switch (tileState){
      case TileState.EMPTY: {
        widget = Container();
      } break;
      case TileState.CROSS: {
        widget = Image.asset("images/x.png");
      } break;
      case TileState.CIRCLE: {
        widget = Image.asset("images/o.png");
      } break;
      case TileState.EQUAL: {
        widget = Container();
      } break;
    }

    return widget;
  }
}