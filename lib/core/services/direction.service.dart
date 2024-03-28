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

  Future<DirectionRoll> getDirectionRoll(int mythsCounter) async {
    BasicRoll directionType = await getDirection(mythsCounter);
    String directionTypeInfo = "";
    BasicRoll? directionSubType;
    String directionSubTypeInfo = "";
    BasicRoll? directionSubSubType;
    List<BasicRoll> actionList = [];
    NPC? npc;
    // REST
    if (directionType.response == DIR_CONSTANTS.DIRECTION_TYPE_REST) {
      directionSubType = await getDisturbance(mythsCounter);
      if (directionSubType.response == DIR_CONSTANTS.DIRECTION_DISTURBANCE_SENSES) {
        actionList = await _verbsService.getVerbs();
      } else if(directionSubType.response == DIR_CONSTANTS.DIRECTION_DISTURBANCE_EVENT) {
        directionSubSubType = await getDisturbanceEvent();
        actionList = await getDisturbanceEvents(directionSubSubType.response, mythsCounter);
      }
    }
    // DEVELOPMENT
    else if(directionType.response == DIR_CONSTANTS.DIRECTION_TYPE_DEVELOPMENT) {
      DevelopmentRoll devRoll = await getDevelopment(mythsCounter);
      directionSubType = BasicRoll(response: devRoll.type, roll: devRoll.roll);
      directionSubTypeInfo = devRoll.text;
      if(devRoll.type == "RANDOM") {
        actionList.add(await getRandom(mythsCounter));
      } else if(devRoll.type == "VERBS") {
        actionList = await _verbsService.getVerbs();
      } else if(devRoll.type == "NPC") {
        NPC newNPC = await _npcService.getNPCRoll('Random');
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
      actionList = await getDisturbanceEvents(directionSubSubType.response, mythsCounter);
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

  Future<List<BasicRoll>> getDisturbanceEvents(String directionSubSubType, int mythsCounter) async {
    List<BasicRoll> actionList = [];
    if (directionSubSubType == DIR_CONSTANTS.DIRECTION_EVENT_HEAR) {
      actionList.add(await getAuditory());
      actionList.add(await getAuditoryWhere());
    } else if (directionSubSubType == DIR_CONSTANTS.DIRECTION_EVENT_SEE) {
      actionList.add(await getVisual(mythsCounter));
    } else if (directionSubSubType == DIR_CONSTANTS.DIRECTION_EVENT_EVENTFUL) {
      actionList.add(await getRandom(mythsCounter));
    }
    return actionList;
  }

  Future<BasicRoll> getDirection(int mythsCounter) async {
    List<String> list = await _jsonService.getStringList('assets/data_base/direction.json');
    int randomInt = _utilsService.getRandomInt(100);
    randomInt = randomInt + mythsCounter;
    switch(randomInt) {
      case (>=1 && <=20):
        return BasicRoll(response: list[0], roll: randomInt);
      case (>=21 && <=40):
        return BasicRoll(response: list[1], roll: randomInt);
      case (>=41 && <=60):
        return BasicRoll(response: list[2], roll: randomInt);
      case (>=61 && <=80):
        return BasicRoll(response: list[3], roll: randomInt);
      case (>=81):
        return BasicRoll(response: list[4], roll: randomInt);
      default:
        return BasicRoll(response: list[1], roll: randomInt);
    }
  }

  Future<BasicRoll> getDisturbance(int mythsCounter) async {
    List<String> list = await _jsonService.getStringList('assets/data_base/disturbance.json');
    int randomInt = _utilsService.getRandomInt(100) + mythsCounter;
    switch(randomInt) {
      case (>=1 && <=30):
        return BasicRoll(response: list[0], roll: randomInt);
      case (>=31 && <=60):
        return BasicRoll(response: list[1], roll: randomInt);
      case (>=61):
        return BasicRoll(response: list[2], roll: randomInt);
      default:
        return BasicRoll(response: list[2], roll: randomInt);
    }
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

  Future<BasicRoll> getVisual(int mythsCounter) async {
    List<String> list = await _jsonService.getStringList('assets/data_base/event_visual.json');
    int randomInt = _utilsService.getRandomInt(list.length) + mythsCounter;
    switch(randomInt) {
      case (>=1 && <=4):
        return BasicRoll(response: list[1], roll: randomInt);
      case (>=5 && <=8):
        return BasicRoll(response: list[1], roll: randomInt);
      case (>=9 && <=12):
        return BasicRoll(response: list[2], roll: randomInt);
      case (>=13 && <=16):
        return BasicRoll(response: list[3], roll: randomInt);
      case (>=17 && <=20):
        return BasicRoll(response: list[4], roll: randomInt);
      case (>=21 && <=24):
        return BasicRoll(response: list[5], roll: randomInt);
      case (>=25 && <=28):
        return BasicRoll(response: list[6], roll: randomInt);
      case (>=29 && <=32):
        return BasicRoll(response: list[7], roll: randomInt);
      case (>=33 && <=36):
        return BasicRoll(response: list[8], roll: randomInt);
      case (>=37 && <=40):
        return BasicRoll(response: list[9], roll: randomInt);
      case (>=41 && <=44):
        return BasicRoll(response: list[10], roll: randomInt);
      case (>=45 && <=48):
        return BasicRoll(response: list[11], roll: randomInt);
      case (>=49 && <=52):
        return BasicRoll(response: list[12], roll: randomInt);
      case (>=53 && <=56):
        return BasicRoll(response: list[13], roll: randomInt);
      case (>=57 && <=60):
        return BasicRoll(response: list[14], roll: randomInt);
      case (>=61 && <=64):
        return BasicRoll(response: list[15], roll: randomInt);
      case (>=65 && <=68):
        return BasicRoll(response: list[16], roll: randomInt);
      case (>=69 && <=72):
        return BasicRoll(response: list[17], roll: randomInt);
      case (>=73 && <=76):
        return BasicRoll(response: list[18], roll: randomInt);
      case (>=77 && <=80):
        return BasicRoll(response: list[19], roll: randomInt);
      case (>=81 && <=84):
        return BasicRoll(response: list[20], roll: randomInt);
      case (>=85 && <=88):
        return BasicRoll(response: list[21], roll: randomInt);
      case (>=89 && <=92):
        return BasicRoll(response: list[22], roll: randomInt);
      case (>=93 && <=96):
        return BasicRoll(response: list[23], roll: randomInt);
      case (>=97):
        return BasicRoll(response: list[24], roll: randomInt);
      default:
        return BasicRoll(response: list[1], roll: randomInt);
    }
  }

  Future<BasicRoll> getRandom(int mythsCounter) async {
    List<String> dataList = await _jsonService.getStringList('assets/data_base/event_random.json');
    int randomInt = _utilsService.getRandomInt(100) + mythsCounter;
    List<String> list = [];
    for (int i = 0; i < dataList.length; i++) {
      list.add(dataList[i]);
      list.add(dataList[i]);
    }
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

  Future<DevelopmentRoll> getDevelopment(int mythsCounter) async {
    List<dynamic> jsonList = await _jsonService.getObjectList('assets/data_base/development.json');
    List<DevelopmentRoll> dataList = [];
    jsonList.forEach((value) {
      dataList.add(new DevelopmentRoll.fromJson(value));
    });
    int randomInt = _utilsService.getRandomInt(dataList.length) + mythsCounter;
    List<DevelopmentRoll> list = [];
    for (int i = 0; i < dataList.length; i++) {
      for (int j = 0; j < 10; j++) {
        list.add(dataList[i]);
      }
    }
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
