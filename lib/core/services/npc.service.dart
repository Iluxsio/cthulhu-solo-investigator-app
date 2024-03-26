import 'dart:math';
import 'package:cthulhu_solo_investigator_app/core/models/npc.model.dart';
import 'package:cthulhu_solo_investigator_app/core/services/json.service.dart';
import 'package:cthulhu_solo_investigator_app/core/services/utils.service.dart';

class NPCService {
  final JSONService _jsonService = JSONService();
  final UtilsService _utilsService = UtilsService();

  Future<NPC> getNPCRoll() async {
    String job = await getJob();
    String gender = await getGender();
    String name = (gender == "Mujer" ? await getNameFemale() : await getNameMale()) as String;
    String surname =  await getSurname();
    String fullName = '$name $surname';
    String adjective = await getAdjective();

    NPC character = NPC(
      job: job, gender: gender, fullName: fullName, adjective: adjective
    );
    return character;
  }

  Future<String> getGender() async {
    Random random = new Random();
    int randomNumber = random.nextInt(101);
    return randomNumber <= 50 ? "Mujer" : "Hombre";
  }

  Future<String> getJob() async {
    List<String> list = await _jsonService.getStringList('assets/data_base/npc_jobs.json');
    int randomInt = _utilsService.getRandomInt(list.length);
    return list[randomInt];
  }

  Future<String> getAdjective() async {
    List<String> list = await _jsonService.getStringList('assets/data_base/npc_adjectives.json');
    int randomInt = _utilsService.getRandomInt(list.length);
    return list[randomInt];
  }

  Future<String> getNameMale() async {
    List<String> list = await _jsonService.getStringList('assets/data_base/npc_names_male.json');
    int randomInt = _utilsService.getRandomInt(list.length);
    return list[randomInt];
  }

  Future<String> getNameFemale() async {
    List<String> list = await _jsonService.getStringList('assets/data_base/npc_names_female.json');
    int randomInt = _utilsService.getRandomInt(list.length);
    return list[randomInt];
  }

  Future<String> getSurname() async {
    List<String> list = await _jsonService.getStringList('assets/data_base/npc_surnames.json');
    int randomInt = _utilsService.getRandomInt(list.length);
    return list[randomInt];
  }
}
