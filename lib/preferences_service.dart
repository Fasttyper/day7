import 'package:shared_preferences/shared_preferences.dart';
import 'package:day7/models.dart';

class PreferencesService{
  Future saveState(SceneState sceneState) async {
    
    final preferences = await SharedPreferences.getInstance();

    await preferences.setInt("movesCount", sceneState.movesCount);
    await preferences.setInt("currentTurn", sceneState.currentTurn.index);
    
    await preferences.setStringList(
      "tilesState",
      sceneState.tilesState
          .map(
            (tile) => tile.index.toString(),
          )
          .toList(),
    );

    print("SceneState saved!");
  }
}