class DevelopmentRoll {
  String type;
  String text;
  int roll;

  DevelopmentRoll({
    required this.type,
    required this.text,
    required this.roll
  });

  factory DevelopmentRoll.fromJson(Map<String, dynamic> json) {
    return DevelopmentRoll(
      type: json['type'],
      text: json['text'],
      roll: json['roll'] ?? -1,
    );
  }
}