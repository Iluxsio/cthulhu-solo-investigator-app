class Odds {
  final int odds;
  final String title;

  Odds({required this.odds, required this.title});

  factory Odds.fromJson(Map<dynamic, dynamic> json) {
    return Odds(
      odds: json['odds'],
      title: json['title'],
    );
  }
}

class QuestionRoll {
  final String question;
  final String likelihood;
  final int roll;
  final String answer;

  QuestionRoll({required this.question, required this.likelihood, required this.roll, required this.answer});
  
}