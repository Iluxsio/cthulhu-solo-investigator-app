import 'package:cthulhu_solo_investigator_app/core/models/clues.model.dart';
import 'package:cthulhu_solo_investigator_app/core/models/direction.model.dart';
import 'package:cthulhu_solo_investigator_app/core/models/npc.model.dart';
import 'package:cthulhu_solo_investigator_app/core/models/odds.model.dart';
import 'package:cthulhu_solo_investigator_app/core/models/scene.model.dart';
import 'package:cthulhu_solo_investigator_app/core/models/verbs.model.dart';

class Roll {
  String type;
  NPC? npc;
  DirectionRoll? directionRoll;
  VerbRoll? verbRoll;
  CluesRoll? cluesRoll;
  QuestionRoll? questionRoll;
  SceneRoll? sceneRoll;
  Roll({
    required this.type,
    this.npc,
    this.directionRoll,
    this.verbRoll,
    this.cluesRoll,
    this.questionRoll,
    this.sceneRoll
  });
}
