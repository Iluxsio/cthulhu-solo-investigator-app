import 'dart:developer';
import 'package:cthulhu_solo_investigator_app/core/models/clues.model.dart';
import 'package:cthulhu_solo_investigator_app/core/models/direction.model.dart';
import 'package:cthulhu_solo_investigator_app/core/models/npc.model.dart';
import 'package:cthulhu_solo_investigator_app/core/models/roll.model.dart';
import 'package:cthulhu_solo_investigator_app/core/models/verbs.model.dart';
import 'package:cthulhu_solo_investigator_app/core/services/clues.service.dart';
import 'package:cthulhu_solo_investigator_app/core/services/direction.service.dart';
import 'package:cthulhu_solo_investigator_app/core/services/npc.service.dart';
import 'package:cthulhu_solo_investigator_app/core/services/verbs.service.dart';
import 'package:cthulhu_solo_investigator_app/modules/home/rolls/roll_cards/clues_card.dart';
import 'package:cthulhu_solo_investigator_app/modules/home/rolls/roll_cards/direction_card.dart';
import 'package:cthulhu_solo_investigator_app/modules/home/rolls/roll_cards/npc_card.dart';
import 'package:cthulhu_solo_investigator_app/modules/home/rolls/roll_cards/verbs_card.dart';
import 'package:flutter/material.dart';
import 'package:cthulhu_solo_investigator_app/core/constants/rollTypes.dart' as rollTypes;

class CurrentSessionPage extends StatefulWidget {

  CurrentSessionPage();
  _CurrentSessionPageState createState() => _CurrentSessionPageState();
}

class _CurrentSessionPageState extends State<CurrentSessionPage> {
  final NPCService _npcService = NPCService();
  final DirectionService _directionService = DirectionService();
  final VerbsService _verbsService = VerbsService();
  final CluesService _cluesService = CluesService();

  late ValueNotifier<int> parentNotifier;
  List<Roll> rolls = [];
  List<NPC> npcs = [];

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Container(
        padding: EdgeInsets.all(8),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Row(
              children: [
                _buildButtonClues(),
                _buildButtonVerbs(),
                _buildButtonNPC(),
                _buildButtonDirection()
              ],
            ),
            SizedBox(
              height: 500,
              child: ListView(
                children: rolls.map((roll) => _buildRoll(roll)).toList(),
              ),
            ),
          ],
        ),
    ));
  }

  Widget _buildRoll(Roll roll) {
    switch (roll.type) {
      case rollTypes.ROLL_VERBS:
        return VerbsCard(roll.verbRoll!);
      case rollTypes.ROLL_NPC:
        return NPCCard(roll.npc!);
      case rollTypes.ROLL_DIRECTION:
        return DirectionCard(roll.directionRoll!);
      case rollTypes.ROLL_CLUE:
        return CluesCard(roll.cluesRoll!);
      default:
        return Text("No hay una tirada seleccionada");
    }
  }

  Widget _buildButtonClues() {
    return ElevatedButton(
      onPressed: () async {
        CluesRoll fetchedClues = await _cluesService.getCluesRoll();
        setState(() {
          Roll newRoll = Roll(type: rollTypes.ROLL_CLUE, cluesRoll: fetchedClues);
          rolls.add(newRoll);
        });
      },
      child: const Text('Pistas'),
    );
  }

  Widget _buildButtonVerbs() {
    return ElevatedButton(
      onPressed: () async {
        VerbRoll fetchedVerbs = await _verbsService.getVerbRoll();
        setState(() {
          Roll newRoll = Roll(type: rollTypes.ROLL_VERBS, verbRoll: fetchedVerbs);
          rolls.add(newRoll);
        });
      },
      child: const Text('Verbos'),
    );
  }

  Widget _buildButtonNPC() {
    return ElevatedButton(
      onPressed: () async {
        NPC fetchedNPC = await _npcService.getNPCRoll();
        setState(() {
          Roll newRoll = Roll(type: rollTypes.ROLL_NPC, npc: fetchedNPC);
          rolls.add(newRoll);
          npcs.add(fetchedNPC);
        });
      },
      child: const Text('NPC'),
    );
  }

  Widget _buildButtonDirection() {
    return ElevatedButton(
      onPressed: () async {
        DirectionRoll directionRoll = await _directionService.getDirectionRoll();
        setState(() {
          Roll newRoll = Roll(type: rollTypes.ROLL_DIRECTION, directionRoll: directionRoll);
          rolls.add(newRoll);
          inspect(rolls);
        });
      },
      child: const Text('Dirección'),
    );
  }

}