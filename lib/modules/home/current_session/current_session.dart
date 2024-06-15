import 'package:cthulhu_solo_investigator_app/core/models/clues.model.dart';
import 'package:cthulhu_solo_investigator_app/core/models/direction.model.dart';
import 'package:cthulhu_solo_investigator_app/core/models/npc.model.dart';
import 'package:cthulhu_solo_investigator_app/core/models/odds.model.dart';
import 'package:cthulhu_solo_investigator_app/core/models/roll.model.dart';
import 'package:cthulhu_solo_investigator_app/core/models/roll_types.dart';
import 'package:cthulhu_solo_investigator_app/core/models/scene.model.dart';
import 'package:cthulhu_solo_investigator_app/core/models/verbs.model.dart';
import 'package:cthulhu_solo_investigator_app/core/services/clues.service.dart';
import 'package:cthulhu_solo_investigator_app/core/services/direction.service.dart';
import 'package:cthulhu_solo_investigator_app/core/services/npc.service.dart';
import 'package:cthulhu_solo_investigator_app/core/services/question.service.dart';
import 'package:cthulhu_solo_investigator_app/core/services/scene.service.dart';
import 'package:cthulhu_solo_investigator_app/core/services/verbs.service.dart';
import 'package:cthulhu_solo_investigator_app/modules/home/rolls/roll_cards/clues_card.dart';
import 'package:cthulhu_solo_investigator_app/modules/home/rolls/roll_cards/direction_card.dart';
import 'package:cthulhu_solo_investigator_app/modules/home/rolls/roll_cards/npc_card.dart';
import 'package:cthulhu_solo_investigator_app/modules/home/rolls/roll_cards/question_card.dart';
import 'package:cthulhu_solo_investigator_app/modules/home/rolls/roll_cards/scene_card.dart';
import 'package:cthulhu_solo_investigator_app/modules/home/rolls/roll_cards/verbs_card.dart';
import 'package:flutter/material.dart';
import 'package:cthulhu_solo_investigator_app/core/constants/rollTypes.dart' as rollTypes;
import 'package:cthulhu_solo_investigator_app/core/objects/roll_types.dart' as rollTypesList;
import 'package:cthulhu_solo_investigator_app/core/models/myths_counter.model.dart';
import 'package:cthulhu_solo_investigator_app/core/objects/myths_counter.dart' as MythsCounterList;
import 'package:flutter_expandable_fab/flutter_expandable_fab.dart';

class CurrentSessionPage extends StatefulWidget {

  CurrentSessionPage();
  _CurrentSessionPageState createState() => _CurrentSessionPageState();
}
final scaffoldKey = GlobalKey<ScaffoldMessengerState>();

class _CurrentSessionPageState extends State<CurrentSessionPage> with SingleTickerProviderStateMixin{
  final NPCService _npcService = NPCService();
  final DirectionService _directionService = DirectionService();
  final VerbsService _verbsService = VerbsService();
  final CluesService _cluesService = CluesService();
  final QuestionService _questionService = QuestionService();
  final SceneService _sceneService = SceneService();
  late ValueNotifier<int> parentNotifier;
  List<Roll> rolls = [];
  List<NPC> npcs = [];
  List<MythsCounter> mythsCounterList = MythsCounterList.mythsCounterList;
  int mythsCounterCurrent = 0;
  final _key = GlobalKey<ExpandableFabState>();
  ScrollController _scrollController = ScrollController();
  String selectedOption = 'Posible';
  late TabController _controller;
  int _selectedIndex = 0;
  List<RollTypes> rollTypesButtonList = rollTypesList.list;

  @override
  void initState() {
    super.initState();
    _controller = TabController(vsync: this, length: 2);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: EdgeInsets.all(8),
        child: DefaultTabController(
          length: 2,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              TabBar(
                controller: _controller,
                labelPadding: const EdgeInsets.only(right: 5),
                indicatorSize: TabBarIndicatorSize.tab,
                indicator: BoxDecoration(
                  color: Colors.transparent,
                  borderRadius: BorderRadius.circular(8.0),
                ),
                indicatorColor: const Color.fromARGB(255, 70, 6, 207),
                overlayColor: MaterialStateProperty.all(Colors.transparent),
                dividerColor: Colors.transparent,
                labelStyle: TextStyle(
                  fontSize: 14.0,
                  fontWeight: FontWeight.w600,
                  color: Color.fromARGB(255, 255, 255, 255),
                ),
                unselectedLabelStyle: TextStyle(
                  color: Color.fromARGB(255, 255, 255, 255),
                ),
                onTap: (index) {
                  setState(() {
                    _selectedIndex = index;
                  });
                },
                tabs: [
                  Center(child: Text('Eventos')),
                  Center(child: Text('Historial')),
                ],
              ),
              const SizedBox(height: 8),
              Expanded(
                child: TabBarView(
                  controller: _controller,
                  children: [
                    getButtons(context),
                    Column(
                      children: [
                        SizedBox(height: 8),       
                        Expanded(
                          child: ListView(
                            controller: _scrollController,
                            children: rolls.map((roll) => _buildRoll(roll)).toList(),
                          ),
                        ),
                      ],
                    )                  
                  ],
                ),
              ),
              SizedBox(
                height: 50,
                child: Center(child: Text('Contador de Mitos: ${mythsCounterCurrent}', style: TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.w600))),
              ),
            ],
          ),
        ),        
      ),
      floatingActionButtonLocation: ExpandableFab.location,
      floatingActionButton: ExpandableFab(
        key: _key,
        distance: 80.0,
        type: ExpandableFabType.up,
        closeButtonBuilder: FloatingActionButtonBuilder(
          size: 56,
          builder: (BuildContext context, void Function()? onPressed,
              Animation<double> progress) {
            return IconButton(
              onPressed: onPressed,
              icon: const Icon(
                Icons.check_circle_outline,
                size: 40,                
                color: Color.fromRGBO(88, 163, 153, 1),
              ),
            );
          },
        ),
        overlayStyle: ExpandableFabOverlayStyle(
          blur: 4,
        ),
        onOpen: () {
          debugPrint('onOpen');
        },
        afterOpen: () {
          debugPrint('afterOpen');
        },
        onClose: () {
          debugPrint('onClose');
        },
        afterClose: () {
          debugPrint('afterClose');
        },
        children: _buildMythsCounterButtons(),
      ),
    );
  }

  Widget getButtons(BuildContext context) {
    List<Widget> buttonList = [];
    rollTypesButtonList.forEach((rollType) {
      buttonList.add(createButtons(rollType));
    });
    return GridView.count(
      crossAxisCount: 2,
      childAspectRatio: 1.5,
      children: buttonList
    );
  }

  Widget createButtons(RollTypes rollType) {
    return GestureDetector(
      onTap: () {
        _buildButtonClick(rollType);
      },
      child: Container(
        margin: EdgeInsets.all(8),
        decoration: BoxDecoration(
          color: const Color.fromARGB(255, 85, 85, 85),
          borderRadius: BorderRadius.circular(10),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              rollType.icon,
              size: 24,
              color: Colors.white
            ),
            Text(
              rollType.name,
              style: TextStyle(
                color: Colors.white,
                fontSize: 16,
                fontWeight: FontWeight.w700,
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _buildButtonClick(RollTypes roll) {
    switch (roll.type) {
      case rollTypes.ROLL_VERBS:
        return addVerbs();
      case rollTypes.ROLL_NPC:
        return addNPC();
      case rollTypes.ROLL_DIRECTION:
        return addDirection();
      case rollTypes.ROLL_CLUE:
        return addClue();
      case rollTypes.ROLL_QUESTION:
        return addQuestion();
      case rollTypes.ROLL_SCENE:
        return addScene();
      default:
        return null;
    }
  }

  Widget _buildRoll(Roll roll) {
    switch (roll.type) {
      case rollTypes.ROLL_VERBS:
        return VerbsCard(verbRoll: roll.verbRoll!);
      case rollTypes.ROLL_NPC:
        return NPCCard(roll.npc!);
      case rollTypes.ROLL_DIRECTION:
        return DirectionCard(roll.directionRoll!);
      case rollTypes.ROLL_CLUE:
        return CluesCard(roll.cluesRoll!);
      case rollTypes.ROLL_QUESTION:
        return QuestionCard(roll.questionRoll!);
      case rollTypes.ROLL_SCENE:
        return SceneCard(roll.sceneRoll!);
      default:
        return Text("No hay una tirada seleccionada");
    }
  }

  void addClue() async {
    CluesRoll fetchedClues = await _cluesService.getCluesRoll();
    setState(() {
      Roll newRoll = Roll(type: rollTypes.ROLL_CLUE, cluesRoll: fetchedClues);
      rolls.add(newRoll);
      _buttonScroll();
      _showRollDialog(newRoll);
    });
  }

  void addVerbs() async {
    VerbRoll fetchedVerbs = await _verbsService.getVerbRoll();
    setState(() {
      Roll newRoll = Roll(type: rollTypes.ROLL_VERBS, verbRoll: fetchedVerbs);
      rolls.add(newRoll);
      _buttonScroll();
      _showRollDialog(newRoll);
    });
  }

  void addNPC() async {
    _showNPCDialog();
  }

  void addDirection() async {
    DirectionRoll directionRoll = await _directionService.getDirectionRoll(mythsCounterCurrent);
    setState(() {
      Roll newRoll = Roll(type: rollTypes.ROLL_DIRECTION, directionRoll: directionRoll);
      rolls.add(newRoll);
      _buttonScroll();
      _showRollDialog(newRoll);
    });
  }

  void addQuestion() async {
    _showQuestionDialog();
  }

  void addScene() async {
    SceneRoll sceneRoll = await _sceneService.getSceneRoll(mythsCounterCurrent);
    setState(() {
      Roll newRoll = Roll(type: rollTypes.ROLL_SCENE, sceneRoll: sceneRoll);
      rolls.add(newRoll);
      _buttonScroll();
      _showRollDialog(newRoll);
    });
  }

  List<Widget> _buildMythsCounterButtons() {
    List<Widget> buttonList = [];
    mythsCounterList.forEach((counter) {
      buttonList.add(
        FloatingActionButton.extended(
            heroTag: null,
            label: Text('${counter.event} (+${counter.counter})', style: TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.w600)),
            onPressed: () async {
            setState(() {
              final state = _key.currentState;
              mythsCounterCurrent = mythsCounterCurrent + counter.counter;
              state!.toggle();
            });
      }));
    });
    return buttonList;
  }

  void _buttonScroll() {
    // _scrollController.animateTo(
    //   _scrollController.position.maxScrollExtent + 100,
    //   duration: Duration(milliseconds: 100),
    //   curve: Curves.easeOut,
    // );
  }

  void _onSubmitQuestion(QuestionRoll qaRoll) {
    setState(() {
      Roll newRoll = Roll(type: rollTypes.ROLL_QUESTION, questionRoll: qaRoll);
      rolls.add(newRoll);
      _buttonScroll();
      _showRollDialog(newRoll);
    });
  }

  void _showQuestionDialog() {
    final TextEditingController questionInput = TextEditingController();
    showDialog<QuestionRoll>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: const Color.fromRGBO(19, 19, 19, 1),
          shape: RoundedRectangleBorder(
            side: BorderSide(color: Color.fromARGB(255, 255, 212, 21)),
            borderRadius:
                BorderRadius.circular(15.0),
          ),
          title: Text('Haz una pregunta', style: TextStyle(
            color: Colors.white, fontSize: 20, fontWeight: FontWeight.w600)),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              TextField(
                  controller: questionInput,
                  decoration: InputDecoration(
                    contentPadding: const EdgeInsets.only(left: 16.0),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(16),
                    ),
                    filled: true,
                    fillColor: Colors.white,
                    labelText: 'Escribe tu pregunta',
                  ),
                ),
              SizedBox(height: 20),
              Container(
                  padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),

                decoration: BoxDecoration(
      color: Colors.white, borderRadius: BorderRadius.circular(10)),
                child: DropdownButtonFormField<String>(
                  value: selectedOption,
                  onSaved : (String? newValue) {
                    setState(() {
                      selectedOption = newValue!;
                    });
                  },
                  onChanged : (String? newValue) {
                    setState(() {
                      selectedOption = newValue!;
                    });
                  },
                  items: <String>[
                    'Imposible',
                    'Improbable',
                    'Poco probable',
                    'Posible',
                    'Probable',
                    'Alto probable',
                    'Certeza'
                  ].map<DropdownMenuItem<String>>((String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text(value),
                    );
                  }).toList(),
                ),
              ),
            ],
          ),
          actions: <Widget>[
            ElevatedButton(
              onPressed: () async {
                String question = questionInput.text;
                QuestionRoll qaRoll = await _questionService.getQuestionRoll(question, selectedOption);
                //_onSubmitQuestion(qaRoll);
                Navigator.of(context).pop(qaRoll);
              },
              child: Text('Aceptar'),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text('Cancelar'),
            ),
          ],
        );
      },
    ).then((value) {
        if (value == null) {
          print('dialog closed with on barrier dismissal or android back button');
          return;
        }
        if (value !=null) {
          _onSubmitQuestion(value);
        }
      },
    );;
  }

  Future<void> _onSubmitNPC(String genderSelected) async {
    NPC fetchedNPC = await _npcService.getNPCRoll(genderSelected);
    setState(() {
      Roll newRoll = Roll(type: rollTypes.ROLL_NPC, npc: fetchedNPC);
      rolls.add(newRoll);
      npcs.add(fetchedNPC);
      _buttonScroll();
      _showRollDialog(newRoll);
    });
  }

  void _showNPCDialog() async {
    showDialog<String>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: const Color.fromRGBO(19, 19, 19, 1),
          shape: RoundedRectangleBorder(
            side: BorderSide(color: Color.fromARGB(255, 255, 212, 21)),
            borderRadius:
                BorderRadius.circular(15.0),
          ),
          title: Text('Elegir género', style: TextStyle(
            color: Colors.white, fontSize: 20, fontWeight: FontWeight.w600)),
          actions: [
            ElevatedButton(
              onPressed: () {
                _onSubmitNPC('Hombre');
                Navigator.of(context).pop();
              },
              child: Text('Hombre'),
            ),
            ElevatedButton(
              onPressed: () {
                _onSubmitNPC('Mujer');
                Navigator.of(context).pop();
              },
              child: Text('Mujer'),
            ),
            ElevatedButton(
              onPressed: () {
                _onSubmitNPC('Random');
                Navigator.of(context).pop();
              },
              child: Text('Random'),
            ),
          ],
        );
      },
    );
  }

 void _showRollDialog(Roll roll) async {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return Dialog(
          alignment: Alignment.bottomCenter,
          insetPadding: EdgeInsets.zero,
          backgroundColor: const Color.fromRGBO(19, 19, 19, 1),
          shape: RoundedRectangleBorder(
            borderRadius:
                BorderRadius.circular(15.0),
          ),
          child: Container(
            width: MediaQuery.of(context).size.width,
            padding: EdgeInsets.all(8),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(roll.type, style: TextStyle(
                  color: Colors.white, fontSize: 20, fontWeight: FontWeight.w600)),
                _buildRoll(roll)
              ],
            ),
          ),        
        );
      },
    );
  }

}