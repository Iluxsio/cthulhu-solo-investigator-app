import 'package:cthulhu_solo_investigator_app/core/models/npc.model.dart';
import 'package:flutter/material.dart';

class NPCCard extends StatelessWidget {
  final NPC npcRoll;
  NPCCard(this.npcRoll);
  late ValueNotifier<int> parentNotifier;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 200,
      height: 140,
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
          Text('Full Name: ${npcRoll.fullName}'),
          Text('Gender: ${npcRoll.gender}'),
          Text('Job: ${npcRoll.job}'),
          Text('Adjective: ${npcRoll.adjective}'),
        ],
      ),
    );
  }
}