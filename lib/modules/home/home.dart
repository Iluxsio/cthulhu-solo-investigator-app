import 'package:cthulhu_solo_investigator_app/modules/home/current_session/current_session.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  String buttonText = 'Not Pressed';

  HomePage();
  _ParentWidgetState createState() => _ParentWidgetState();
}

class _ParentWidgetState extends State<HomePage> {
  late ValueNotifier<int> parentNotifier;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        CurrentSessionPage()
      ],
    );
  }
}