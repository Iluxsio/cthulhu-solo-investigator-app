import 'dart:math';
import 'package:cthulhu_solo_investigator_app/core/models/basic_roll.dart';
import 'package:cthulhu_solo_investigator_app/core/models/npc.model.dart';
import 'package:cthulhu_solo_investigator_app/core/models/verbs.model.dart';
import 'package:cthulhu_solo_investigator_app/core/services/json.service.dart';
import 'package:cthulhu_solo_investigator_app/core/services/utils.service.dart';

class VerbsService {
  final JSONService _jsonService = JSONService();
  final UtilsService _utilsService = UtilsService();

  Future<VerbRoll> getVerbRoll() async {
    List<BasicRoll> verbs = await getVerbs();
    BasicRoll action = await getAction();
    BasicRoll subject = await getSubjects();
    VerbRoll verbRoll = VerbRoll(
      verb1: verbs[0].response, verb2: verbs[1].response, verb3: verbs[2].response, action: action.response, subject: subject.response, 
      verb1Roll: verbs[0].roll, verb2Roll: verbs[1].roll, verb3Roll: verbs[2].roll, actionRoll: action.roll, subjectRoll: action.roll);
    return verbRoll;
  }

  Future<List<BasicRoll>> getVerbs() async {
    List<String> list = await _jsonService.getStringList('assets/data_base/verbs.json');
    List<int> verbInts = _utilsService.getMultipleRandomInst(3, list.length);
    List<BasicRoll> rolls = [
      BasicRoll(response: list[verbInts[0]], roll: verbInts[0]),
      BasicRoll(response: list[verbInts[1]], roll: verbInts[1]),
      BasicRoll(response: list[verbInts[2]], roll: verbInts[2])
    ];
    return rolls;
  }

  Future<BasicRoll> getAction() async {
    List<String> list = await _jsonService.getStringList('assets/data_base/verbs_actions.json');
    int randomInt = _utilsService.getRandomInt(list.length);
    BasicRoll roll = BasicRoll(response: list[randomInt], roll: randomInt);
    return roll;
  }

  Future<BasicRoll> getSubjects() async {
    List<String> list = await _jsonService.getStringList('assets/data_base/verbs_subjects.json');
    int randomInt = _utilsService.getRandomInt(list.length);
    BasicRoll roll = BasicRoll(response: list[randomInt], roll: randomInt);
    return roll;
  }
}
