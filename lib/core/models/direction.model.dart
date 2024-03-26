import 'package:cthulhu_solo_investigator_app/core/models/npc.model.dart';

class DirectionRoll {
  String directionType;
  String directionTypeInfo;
  String directionSubType;
  String directionSubTypeInfo;
  String directionSubSubType;
  List<String> actionList;
  NPC? npc;

  DirectionRoll({
    required this.directionType,
    required this.directionTypeInfo,
    required this.directionSubType,
    required this.directionSubTypeInfo,
    required this.directionSubSubType,
    required this.actionList,
    this.npc
  });
}
