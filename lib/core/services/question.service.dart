import 'package:cthulhu_solo_investigator_app/core/models/odds.model.dart';
import 'package:cthulhu_solo_investigator_app/core/services/json.service.dart';
import 'package:cthulhu_solo_investigator_app/core/services/utils.service.dart';

class QuestionService {
  final JSONService _jsonService = JSONService();
  final UtilsService _utilsService = UtilsService();

  Future<QuestionRoll> getQuestionRoll(String question, String likelihood) async {
    List<Odds> odds = await getOdds();
    int roll = _utilsService.getRandomInt(100);
    Odds oddSelected = odds.where((odd) => odd.title == likelihood).first;
    roll = roll + oddSelected.odds;
    QuestionRoll qaRoll = QuestionRoll(question: question, likelihood: likelihood,roll: roll, answer: getAnswer(roll));
    return qaRoll;
  }

  Future<List<Odds>> getOdds() async {
    List<dynamic> jsonList = await _jsonService.getObjectList('assets/data_base/odds.json');
    List<Odds> dataList = [];
    jsonList.forEach((value) {
      dataList.add(new Odds.fromJson(value));
    });
    return dataList;
  }

  String getAnswer(int roll) {
    switch (roll) {
      case (<= 34):
        return "NO";
      case (>=35 && <=59):
        return "QUIZÁS. Tira habilidad para comprobarlo o pregunta mejor. Si sale 2 QUIZÁS seguidos, tira verbos";
      case (>=60):
        return "SÍ";
      default:
        return "ERROR";
    }
  }
}