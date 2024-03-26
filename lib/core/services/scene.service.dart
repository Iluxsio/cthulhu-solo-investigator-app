import 'dart:math';
import 'package:cthulhu_solo_investigator_app/core/models/npc.model.dart';
import 'package:cthulhu_solo_investigator_app/core/models/verbs.model.dart';
import 'package:cthulhu_solo_investigator_app/core/services/json.service.dart';
import 'package:cthulhu_solo_investigator_app/core/services/utils.service.dart';

class SceneService {
  final JSONService _jsonService = JSONService();
  final UtilsService _utilsService = UtilsService();

  Future<VerbRoll> getVerbRoll() async {
    List<String> verbs = await getVerbs();
    String action = await getAction();
    String subject = await getSubjects();

    VerbRoll verbRoll = VerbRoll(verb1: verbs[0], verb2: verbs[1], verb3: verbs[2], action: action, subject: subject);
    return verbRoll;
  }

  Future<List<String>> getVerbs() async {
    List<String> list = await _jsonService.getStringList('assets/data_base/verbs.json');
    Set<int> uniqueIndices = Set<int>();
    while (uniqueIndices.length < 3) {
      uniqueIndices.add(_utilsService.getRandomInt(list.length));
    }
    List<String> verbs = uniqueIndices.map((index) => list[index]).toList();
    return verbs;
  }

  Future<String> getAction() async {
    List<String> list = await _jsonService.getStringList('assets/data_base/verbs_actions.json');
    int randomInt = _utilsService.getRandomInt(list.length);
    return list[randomInt];
  }

  Future<String> getSubjects() async {
    List<String> list = await _jsonService.getStringList('assets/data_base/verbs_subjects.json');
    int randomInt = _utilsService.getRandomInt(list.length);
    return list[randomInt];
  }
}
