import 'package:cthulhu_solo_investigator_app/core/models/basic_roll.dart';
import 'package:cthulhu_solo_investigator_app/core/models/npc.model.dart';

class DirectionRoll {
  String directionType;
  String directionTypeInfo;
  int directionTypeRoll;
  String directionSubType;
  String directionSubTypeInfo;
  int directionSubTypeRoll;
  String directionSubSubType;
  int directionSubSubRoll;
  List<BasicRoll> actionList;
  NPC? npc;

  DirectionRoll({
    required this.directionTypeRoll,
    required this.directionSubTypeRoll,
    required this.directionSubSubRoll,
    required this.directionType,
    required this.directionTypeInfo,
    required this.directionSubType,
    required this.directionSubTypeInfo,
    required this.directionSubSubType,
    required this.actionList,
    this.npc
  });
}
