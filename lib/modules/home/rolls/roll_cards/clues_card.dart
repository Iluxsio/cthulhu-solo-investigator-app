import 'package:cthulhu_solo_investigator_app/core/models/clues.model.dart';
import 'package:flutter/material.dart';

class CluesCard extends StatelessWidget {
  final CluesRoll cluesRoll;
  CluesCard(this.cluesRoll);
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
          Text('solo: ${cluesRoll.solo}'),
          Text('tome: ${cluesRoll.tome}'),
          Text('roomItem: ${cluesRoll.roomItem}'),
          Text('weirdClue1: ${cluesRoll.weirdClue1}'),
          Text('weirdClue2: ${cluesRoll.weirdClue2}'),
          Text('weirdClue3: ${cluesRoll.weirdClue3}'),
          Text('linkedClue1: ${cluesRoll.linkedClue1}'),
          Text('linkedClue2: ${cluesRoll.linkedClue2}'),
          Text('paranormalClue: ${cluesRoll.paranormalClue}'),
        ],
      ),
    );
  }
}