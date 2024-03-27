import 'dart:math';
import 'package:cthulhu_solo_investigator_app/core/constants/directions.dart' as DIR_CONSTANTS;
import 'package:cthulhu_solo_investigator_app/core/models/basic_roll.dart';
import 'package:cthulhu_solo_investigator_app/core/models/development.model.dart';
import 'package:cthulhu_solo_investigator_app/core/models/direction.model.dart';
import 'package:cthulhu_solo_investigator_app/core/models/npc.model.dart';
import 'package:cthulhu_solo_investigator_app/core/models/verbs.model.dart';
import 'package:cthulhu_solo_investigator_app/core/services/json.service.dart';
import 'package:cthulhu_solo_investigator_app/core/services/npc.service.dart';
import 'package:cthulhu_solo_investigator_app/core/services/utils.service.dart';
import 'package:cthulhu_solo_investigator_app/core/services/verbs.service.dart';

class DirectionService {
  final JSONService _jsonService = JSONService();
  final UtilsService _utilsService = UtilsService();
  final VerbsService _verbsService = VerbsService();
  final NPCService _npcService = NPCService();

  Future<DirectionRoll> getDirectionRoll() async {
    BasicRoll directionType = await getDirection();
    String directionTypeInfo = "";
    BasicRoll? directionSubType;
    String directionSubTypeInfo = "";
    BasicRoll? directionSubSubType;
    List<BasicRoll> actionList = [];
    NPC? npc;
    // REST
    if (directionType.response == DIR_CONSTANTS.DIRECTION_TYPE_REST) {
      directionSubType = await getDisturbance();
      if (directionSubType.response == DIR_CONSTANTS.DIRECTION_DISTURBANCE_SENSES) {
        actionList = await _verbsService.getVerbs();
      } else if(directionSubType.response == DIR_CONSTANTS.DIRECTION_DISTURBANCE_EVENT) {
        directionSubSubType = await getDisturbanceEvent();
        actionList = await getDisturbanceEvents(directionSubSubType.response);
      }
    }
    // DEVELOPMENT
    else if(directionType.response == DIR_CONSTANTS.DIRECTION_TYPE_DEVELOPMENT) {
      DevelopmentRoll devRoll = await getDevelopment();
      directionSubType = BasicRoll(response: devRoll.type, roll: devRoll.roll);
      directionSubTypeInfo = devRoll.text;
      if(devRoll.type == "RANDOM") {
        actionList.add(await getRandom());
      } else if(devRoll.type == "VERBS") {
        actionList = await _verbsService.getVerbs();
      } else if(devRoll.type == "NPC") {
        NPC newNPC = await _npcService.getNPCRoll();
        npc = NPC(
          job: newNPC.job, gender: newNPC.gender, fullName: newNPC.fullName, adjective: newNPC.adjective
        );
      }
    }
    // DISCOVERY
    else if(directionType.response == DIR_CONSTANTS.DIRECTION_TYPE_DISCOVERY) {
      DevelopmentRoll devRoll = await getDiscovery();
      directionSubType = BasicRoll(response: devRoll.type, roll: devRoll.roll);
      directionSubTypeInfo = devRoll.text;
      if(directionSubTypeInfo.contains("Rumor")) {
        actionList.add(await getRumour());
      }
    }
    // DANGER
    else if(directionType.response == DIR_CONSTANTS.DIRECTION_TYPE_DANGER) {
      BasicRoll danger = await getDanger();
      directionTypeInfo = '(${danger.roll}) ${danger.response}';
      actionList = await _verbsService.getVerbs();
    }
    // EVENT
    else if(directionType.response == DIR_CONSTANTS.DIRECTION_TYPE_EVENT) {
      directionSubType = BasicRoll(response: DIR_CONSTANTS.DIRECTION_DISTURBANCE_EVENT, roll: 0);
      directionSubSubType = await getDisturbanceEvent();
      actionList = await getDisturbanceEvents(directionSubSubType.response);
    }
    DirectionRoll directionRoll = DirectionRoll(
      directionType: directionType.response,
      directionTypeInfo: directionTypeInfo,
      directionSubType: directionSubType != null ? directionSubType!.response : "", 
      directionSubTypeInfo: directionSubTypeInfo, 
      directionSubSubType: directionSubSubType != null ? directionSubSubType.response : "", 
      actionList: actionList, 
      directionTypeRoll: directionType.roll, 
      directionSubTypeRoll: directionSubType != null ? directionSubType.roll : -1, 
      directionSubSubRoll: directionSubSubType != null ? directionSubSubType.roll : -1);
    if (npc != null) {
      directionRoll.npc = npc;
    }
    return directionRoll;
  }

  Future<List<BasicRoll>> getDisturbanceEvents(String directionSubSubType) async {
    List<BasicRoll> actionList = [];
    if (directionSubSubType == DIR_CONSTANTS.DIRECTION_EVENT_HEAR) {
      actionList.add(await getAuditory());
      actionList.add(await getAuditoryWhere());
    } else if (directionSubSubType == DIR_CONSTANTS.DIRECTION_EVENT_SEE) {
      actionList.add(await getVisual());
    } else if (directionSubSubType == DIR_CONSTANTS.DIRECTION_EVENT_EVENTFUL) {
      actionList.add(await getRandom());
    }
    return actionList;
  }

  Future<BasicRoll> getDirection() async {
    List<String> list = await _jsonService.getStringList('assets/data_base/direction.json');
    int randomInt = _utilsService.getRandomInt(list.length);
    BasicRoll roll = BasicRoll(response: list[randomInt], roll: randomInt);
    return roll;
  }

  Future<BasicRoll> getDisturbance() async {
    List<String> list = await _jsonService.getStringList('assets/data_base/disturbance.json');
    int randomInt = _utilsService.getRandomInt(list.length);
    BasicRoll roll = BasicRoll(response: list[randomInt], roll: randomInt);
    return roll;
  }

  Future<BasicRoll> getDisturbanceEvent() async {
    List<String> list = await _jsonService.getStringList('assets/data_base/disturbance_event.json');
    int randomInt = _utilsService.getRandomInt(list.length);
    BasicRoll roll = BasicRoll(response: list[randomInt], roll: randomInt);
    return roll;
  }

  Future<BasicRoll> getAuditory() async {
    List<String> list = await _jsonService.getStringList('assets/data_base/event_auditory.json');
    int randomInt = _utilsService.getRandomInt(list.length);
    BasicRoll roll = BasicRoll(response: list[randomInt], roll: randomInt);
    return roll;
  }

  Future<BasicRoll> getAuditoryWhere() async {
    List<String> list = await _jsonService.getStringList('assets/data_base/event_auditory_where.json');
    int randomInt = _utilsService.getRandomInt(list.length);
    BasicRoll roll = BasicRoll(response: list[randomInt], roll: randomInt);
    return roll;
  }

  Future<BasicRoll> getVisual() async {
    List<String> list = await _jsonService.getStringList('assets/data_base/event_visual.json');
    int randomInt = _utilsService.getRandomInt(list.length);
    BasicRoll roll = BasicRoll(response: list[randomInt], roll: randomInt);
    return roll;
  }

  Future<BasicRoll> getRandom() async {
    List<String> list = await _jsonService.getStringList('assets/data_base/event_random.json');
    int randomInt = _utilsService.getRandomInt(list.length);
    BasicRoll roll = BasicRoll(response: list[randomInt], roll: randomInt);
    return roll;
  }

  Future<BasicRoll> getRumour() async {
    List<String> list = await _jsonService.getStringList('assets/data_base/rumour.json');
    int randomInt = _utilsService.getRandomInt(list.length);
    BasicRoll roll = BasicRoll(response: list[randomInt], roll: randomInt);
    return roll;
  }
  
  Future<BasicRoll> getDanger() async {
    List<String> list = await _jsonService.getStringList('assets/data_base/danger.json');
    int randomInt = _utilsService.getRandomInt(list.length);
    BasicRoll roll = BasicRoll(response: list[randomInt], roll: randomInt);
    return roll;
  }

  Future<DevelopmentRoll> getDevelopment() async {
    List<dynamic> jsonList = await _jsonService.getObjectList('assets/data_base/development.json');
    List<DevelopmentRoll> dataList = [];
    jsonList.forEach((value) {
      dataList.add(new DevelopmentRoll.fromJson(value));
    });
    int randomInt = _utilsService.getRandomInt(dataList.length);
    return dataList[randomInt];
  }

  Future<DevelopmentRoll> getDiscovery() async {
    List<dynamic> jsonList = await _jsonService.getObjectList('assets/data_base/discovery.json');
    List<DevelopmentRoll> dataList = [];
    jsonList.forEach((value) {
      dataList.add(new DevelopmentRoll.fromJson(value));
    });
    int randomInt = _utilsService.getRandomInt(dataList.length);
    return dataList[randomInt];
  }
}
