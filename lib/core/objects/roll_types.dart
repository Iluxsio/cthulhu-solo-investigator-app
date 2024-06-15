
import 'package:cthulhu_solo_investigator_app/core/constants/rollTypes.dart';
import 'package:cthulhu_solo_investigator_app/core/models/roll_types.dart';
import 'package:flutter/material.dart';

List<RollTypes> list = [
  RollTypes(
    type: ROLL_NPC,
    name: 'NPC',
    icon: Icons.face
  ),
  RollTypes(
    type: ROLL_VERBS,
    name: 'Verbos',
    icon: Icons.chat_bubble_outline
  ),
  RollTypes(
    type: ROLL_DIRECTION,
    name: 'Dirección',
    icon: Icons.map
  ),
  RollTypes(
    type: ROLL_QUESTION,
    name: 'Pregunta',
    icon: Icons.question_mark
  ),
  RollTypes(
    type: ROLL_SCENE,
    name: 'Escena',
    icon: Icons.cyclone
  ),
  RollTypes(
    type: ROLL_CLUE,
    name: 'Pista',
    icon: Icons.search
  ),
];
