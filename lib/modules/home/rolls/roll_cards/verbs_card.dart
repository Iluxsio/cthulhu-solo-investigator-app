import 'package:cthulhu_solo_investigator_app/core/models/verbs.model.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class VerbsCard extends StatelessWidget {
  final VerbRoll verbRoll;
  VerbsCard({required this.verbRoll});
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
        children: [
          Container(
            child: const Text(
              "Verbos:",
              style: TextStyle(
                fontSize: 16, 
                fontWeight: FontWeight.w600,
                color: Colors.white),
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text('${verbRoll.verb1} || ', style: TextStyle(color: Colors.white)),
              Text('${verbRoll.verb2} || ', style: TextStyle(color: Colors.white)),
              Text('${verbRoll.verb3}', style: TextStyle(color: Colors.white)),
            ],
          ),
          SizedBox(height: 8),
          Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
            Row(
              children: [
                const Text('Acción: ',
                    style:
                        TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.w600)),
                Text(verbRoll.action, style: TextStyle(color: Colors.white))
              ],
            ),
            Row(
              children: [
                const Text('Sujeto: ',
                    style:
                        TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.w600)),
                Text(verbRoll.subject, style: TextStyle(color: Colors.white))
              ],
            )
          ])
        ],
      ),
    );
  }
}
