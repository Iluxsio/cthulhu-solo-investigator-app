import 'package:cthulhu_solo_investigator_app/core/models/npc.model.dart';
import 'package:cthulhu_solo_investigator_app/core/models/odds.model.dart';
import 'package:flutter/material.dart';

class QuestionCard extends StatelessWidget {
  final QuestionRoll questionRoll;
  QuestionCard(this.questionRoll);
  late ValueNotifier<int> parentNotifier;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 200,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16.0),
        border: Border.all(
            color: const Color.fromRGBO(179, 179, 193, 1),
            width: 1,
          ),
      ),
      padding: EdgeInsets.all(14),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Pregunta: ${questionRoll.question}'),
          Text('Probabilidad: ${questionRoll.likelihood}'),
          Text('Respuesta: (${questionRoll.roll}) ${questionRoll.answer}'),
        ],
      ),
    );
  }
}