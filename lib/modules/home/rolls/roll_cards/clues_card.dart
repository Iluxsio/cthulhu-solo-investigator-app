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
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildTitle('Tomo de mitos:'),
          _buildText(cluesRoll.tome),
          SizedBox(height: 8),
          _buildTitle('Objeto en habitación:'),
          _buildText(cluesRoll.roomItem),
          SizedBox(height: 8),
          _buildTitle('Pista:'),
          _buildText(cluesRoll.solo),
          SizedBox(height: 8),
          _buildTitle('Pistas enlazadas:'),
          _buildText(cluesRoll.linkedClue1),
          _buildText(cluesRoll.linkedClue2),
          SizedBox(height: 8),
          _buildTitle('Pista rara 1:'),
          _buildText(cluesRoll.weirdClue1),
          SizedBox(height: 8),
          _buildTitle('Pista rara 2:'),
          _buildText(cluesRoll.weirdClue2),
          SizedBox(height: 8),
          _buildTitle('Pista rara 3:'),
          _buildText(cluesRoll.weirdClue3)
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
