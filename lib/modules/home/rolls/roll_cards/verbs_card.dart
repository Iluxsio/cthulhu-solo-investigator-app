import 'package:cthulhu_solo_investigator_app/core/models/verbs.model.dart';
import 'package:flutter/material.dart';

class VerbsCard extends StatelessWidget {
  final VerbRoll verbRoll;
  VerbsCard(this.verbRoll);
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
          Text('2: ${verbRoll.verb1}'),
          Text('2: ${verbRoll.verb2}'),
          Text('3: ${verbRoll.verb3}'),
          Text('action: ${verbRoll.action}'),
          Text('subject: ${verbRoll.subject}'),
        ],
      ),
    );
  }
}