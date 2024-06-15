import 'package:cthulhu_solo_investigator_app/core/models/npc.model.dart';
import 'package:cthulhu_solo_investigator_app/core/models/scene.model.dart';
import 'package:flutter/material.dart';

class SceneCard extends StatelessWidget {
  final SceneRoll sceneRoll;
  SceneCard(this.sceneRoll);
  late ValueNotifier<int> parentNotifier;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
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
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Text('Escenario:',
              style: TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.w600)),
          Container(
            padding: EdgeInsets.only(left: 20),
            child: Text(sceneRoll.response, style: TextStyle(color: Colors.white))),
        ],
      ),
    );
  }
}