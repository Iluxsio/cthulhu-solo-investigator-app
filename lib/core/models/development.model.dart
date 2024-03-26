class DevelopmentRoll {
  String type;
  String text;

  DevelopmentRoll({
    required this.type,
    required this.text
  });

  factory DevelopmentRoll.fromJson(Map<String, dynamic> json) {
    return DevelopmentRoll(
      type: json['type'],
      text: json['text'],
    );
  }
}