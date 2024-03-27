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
      margin: EdgeInsets.only(bottom: 8),
      decoration: BoxDecoration(
        color: Color.fromRGBO(19, 19, 19, 1),
        borderRadius: BorderRadius.circular(16.0),
        border: Border.all(
          color: Color.fromARGB(255, 255, 212, 21),
          width: 2,
        ),
      ),
      padding: EdgeInsets.all(14),
      child: Column(
        children: [
          Row(children: [Text('NPC:', style:
                        TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.w600)),],),
          Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text('${npcRoll.fullName} (${npcRoll.gender})', style: TextStyle(color: Colors.white)),
              Text('${npcRoll.job} || ${npcRoll.adjective}', style: TextStyle(color: Colors.white)),
            ],
          ),
        ],
      ),
    );
  }
}