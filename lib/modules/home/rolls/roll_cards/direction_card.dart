import 'package:cthulhu_solo_investigator_app/core/models/direction.model.dart';
import 'package:flutter/material.dart';

class DirectionCard extends StatelessWidget {
  final DirectionRoll directionRoll;
  DirectionCard(this.directionRoll);
  late ValueNotifier<int> parentNotifier;

  @override
  Widget build(BuildContext context) {
    List<String> responsesArray = directionRoll.actionList.map((obj) => obj.response).toList();
    return Container(
      width: 200,
      margin: EdgeInsets.only(bottom:8),
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
          Text('Dirección de la historia:'),
          Text(directionRoll.directionType),
          if(directionRoll.directionType == "Evento") ...{
            Text('${directionRoll.directionSubType}'),
          },
          Text('${directionRoll.directionTypeInfo}'),
          Text('${directionRoll.directionSubTypeInfo}'),
          if (directionRoll.actionList.length >= 1) ... {
            Text('${responsesArray.join(', ')}'),
          }
        ],
      ),
    );
  }
}