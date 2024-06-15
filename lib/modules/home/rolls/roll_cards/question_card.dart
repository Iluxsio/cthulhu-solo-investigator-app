import 'package:cthulhu_solo_investigator_app/core/models/npc.model.dart';
import 'package:cthulhu_solo_investigator_app/core/models/odds.model.dart';
import 'package:flutter/material.dart';

class QuestionCard extends StatelessWidget {
  final QuestionRoll questionRoll;
  QuestionCard(this.questionRoll);
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
          _buildTitle('Pregunta:'),
          _buildText(questionRoll.question),
          SizedBox(height: 8),
          _buildTitle('Probabilidad:'),
          _buildText(questionRoll.likelihood),
          SizedBox(height: 8),
          _buildTitle('Probabilidad:'),
          _buildText(questionRoll.answer),
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

// floatingActionButtonLocation: ExpandableFab.location,
//       floatingActionButton: ExpandableFab(
//         key: _key,
//         duration: const Duration(milliseconds: 500),
//         distance: 40.0,
//         type: ExpandableFabType.up,
//         pos: ExpandableFabPos.left,
//         childrenOffset: const Offset(0, 20),
//         fanAngle: 40,
//         openButtonBuilder: RotateFloatingActionButtonBuilder(
//           child: const Icon(Icons.abc),
//           fabSize: ExpandableFabSize.large,
//           foregroundColor: Colors.amber,
//           backgroundColor: Colors.green,
//           shape: const CircleBorder(),
//           angle: 3.14 * 2,
//         ),
//         closeButtonBuilder: FloatingActionButtonBuilder(
//           size: 56,
//           builder: (BuildContext context, void Function()? onPressed,
//               Animation<double> progress) {
//             return IconButton(
//               onPressed: onPressed,
//               icon: const Icon(
//                 Icons.check_circle_outline,
//                 size: 40,
//               ),
//             );
//           },
//         ),
//         overlayStyle: ExpandableFabOverlayStyle(
//           // color: Colors.black.withOpacity(0.5),
//           blur: 5,
//         ),
//         onOpen: () {
//           debugPrint('onOpen');
//         },
//         afterOpen: () {
//           debugPrint('afterOpen');
//         },
//         onClose: () {
//           debugPrint('onClose');
//         },
//         afterClose: () {
//           debugPrint('afterClose');
//         },
//         children: [
//           FloatingActionButton.small(
//             shape: const CircleBorder(),
//             heroTag: null,
//             child: const Icon(Icons.edit),
//             onPressed: () {
//               const SnackBar snackBar = SnackBar(
//                 content: Text("SnackBar"),
//               );
//               scaffoldKey.currentState?.showSnackBar(snackBar);
//             },
//           ),
//           FloatingActionButton.small(
//             shape: const CircleBorder(),
//             heroTag: null,
//             child: const Icon(Icons.search),
//             onPressed: () {
              
//             },
//           ),
//           FloatingActionButton.small(
//             shape: const CircleBorder(),
//             heroTag: null,
//             child: const Icon(Icons.share),
//             onPressed: () {
//               final state = _key.currentState;
//               if (state != null) {
//                 debugPrint('isOpen:${state.isOpen}');
//                 state.toggle();
//               }
//             },
//           ),
//         ],
//       ),