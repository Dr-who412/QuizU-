class ProfileModel {
  String? userName;
  String? mobile;
  ProfileModel({this.userName, this.mobile});

  ProfileModel.fromJson(Map<String, dynamic> json) {
    userName = json['name'];
    mobile = json['mobile'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = this.userName;
    data['score'] = this.mobile;
    return data;
  }
}