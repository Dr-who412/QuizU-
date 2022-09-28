class LeaderBoardModel {
  String? name;
  int? score;
  LeaderBoardModel({this.name, this.score});

  LeaderBoardModel.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    score = json['score'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = this.name;
    data['score'] = this.score;
    return data;
  }
}