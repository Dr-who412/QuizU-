class ScoreModel {
  String? score;
  String? date;

  ScoreModel({
    this.score,

    this.date,
  });

  ScoreModel.fromjson(Map<String, dynamic> json) {
    score = json['score'];
    date = json['date'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['score'] = this.score;
    data['date'] = this.date;
    return data;
  }

  Map<String, dynamic> toMap() {
    return {
      'score': '$score',
      'date': '$date',
    };
  }

}