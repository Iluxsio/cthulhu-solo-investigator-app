import 'dart:math';
import 'package:cthulhu_solo_investigator_app/core/models/basic_roll.dart';
import 'package:cthulhu_solo_investigator_app/core/models/scene.model.dart';
import 'package:cthulhu_solo_investigator_app/core/models/verbs.model.dart';
import 'package:cthulhu_solo_investigator_app/core/services/json.service.dart';
import 'package:cthulhu_solo_investigator_app/core/services/utils.service.dart';

class SceneService {
  final JSONService _jsonService = JSONService();
  final UtilsService _utilsService = UtilsService();

  Future<SceneRoll> getSceneRoll(int mythsCounter) async {
    SceneRoll sceneRoll;
    if (mythsCounter >= 1 && mythsCounter <= 33) {
      BasicRoll scene = await getSceneNormal();
      sceneRoll = SceneRoll(type: 'Normal', response: scene.response, roll: scene.roll);
    } else if (mythsCounter >= 44 && mythsCounter <= 66) {
      BasicRoll scene = await getSceneGruesome();
      sceneRoll = SceneRoll(type: 'Turbia', response: scene.response, roll: scene.roll);
    } else {
      BasicRoll scene = await getSceneParanormal();
      sceneRoll = SceneRoll(type: 'Paranormal', response: scene.response, roll: scene.roll);
    }
    return sceneRoll;
  }

  Future<BasicRoll> getSceneNormal() async {
    List<String> list = await _jsonService.getStringList('assets/data_base/scenes_normal.json');
    int randomInt = _utilsService.getRandomInt(list.length);
    BasicRoll roll = BasicRoll(response: list[randomInt], roll: randomInt);
    return roll;
  }

  Future<BasicRoll> getSceneGruesome() async {
    List<String> list = await _jsonService.getStringList('assets/data_base/scenes_gruesome.json');
    int randomInt = _utilsService.getRandomInt(list.length);
    BasicRoll roll = BasicRoll(response: list[randomInt], roll: randomInt);
    return roll;
  }

  Future<BasicRoll> getSceneParanormal() async {
    List<String> list = await _jsonService.getStringList('assets/data_base/scenes_paranormal.json');
    int randomInt = _utilsService.getRandomInt(list.length);
    BasicRoll roll = BasicRoll(response: list[randomInt], roll: randomInt);
    return roll;
  }
}
