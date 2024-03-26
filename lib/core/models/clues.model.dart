class CluesRoll {
  String solo;
  String tome;
  String roomItem;
  String weirdClue1;
  String weirdClue2;
  String weirdClue3;
  String linkedClue1;
  String linkedClue2;
  String paranormalClue;

  CluesRoll({
    required this.solo,
    required this.tome,
    required this.roomItem,
    required this.weirdClue1,
    required this.weirdClue2,
    required this.weirdClue3,
    required this.linkedClue1,
    required this.linkedClue2,
    required this.paranormalClue,
  });
}

class Clues {
  List<String> solo;
  List<String> tome;
  List<String> roomItems;
  List<String> weirdClues1;
  List<String> weirdClues2;
  List<String> weirdClues3;
  List<String> linkedClues;
  List<String> paranormalClues;

  Clues({
    required this.solo,
    required this.tome,
    required this.roomItems,
    required this.weirdClues1,
    required this.weirdClues2,
    required this.weirdClues3,
    required this.linkedClues,
    required this.paranormalClues,
  });

  factory Clues.fromJson(List<Map<String, dynamic>> json) {
    return Clues(
      solo: List<String>.from(json[0]['solo']) ?? [],
      tome: List<String>.from(json[1]['tome']) ?? [],
      roomItems: List<String>.from(json[2]['room_items']) ?? [],
      weirdClues1: List<String>.from(json[3]['weird_clues_1']) ?? [],
      weirdClues2: List<String>.from(json[4]['weird_clues_2']) ?? [],
      weirdClues3: List<String>.from(json[5]['weird_clues_3']) ?? [],
      linkedClues: List<String>.from(json[6]['linked_clues']) ?? [],
      paranormalClues: List<String>.from(json[7]['paranormal_clues']) ?? [],
    );
  }
}
