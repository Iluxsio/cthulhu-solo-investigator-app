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
        color: Color.fromRGBO(19, 19, 19, 1),
        borderRadius: BorderRadius.circular(16.0),
        border: Border.all(
          color: Color.fromARGB(255, 255, 212, 21),
          width: 2,
        ),
      ),
      padding: EdgeInsets.all(14),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildTitle('Dirección de la historia:'),
          _buildText(directionRoll.directionType),
          if (directionRoll.directionTypeInfo != "") ...{
            _buildText(directionRoll.directionTypeInfo),
            SizedBox(height: 8),
          },
          _buildTitle(directionRoll.directionSubType),

          if(directionRoll.directionSubTypeInfo != "") ...{
            _buildText(directionRoll.directionSubTypeInfo),
            SizedBox(height: 8),
          },
          if(directionRoll.directionSubSubType != "") ...{
            _buildText(directionRoll.directionSubSubType),
          },
          if (directionRoll.actionList.length >= 1) ... {
            _buildTitle('Verbos:'),
            _buildText('${responsesArray.join(', ')}'),
          }
        ],
      ),
    );
  }

  Widget _buildTitle(String title) {
    return Text(title,
        style: TextStyle(
            color: Colors.white, fontSize: 16, fontWeight: FontWeight.w600));
  }

  Widget _buildText(String text) {
    return Container(
        padding: EdgeInsets.only(left: 20),
        child: Text(text, style: TextStyle(color: Colors.white)));
  }
}