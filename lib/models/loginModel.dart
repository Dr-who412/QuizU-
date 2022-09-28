class LoginModel {
  bool? success;
  String? message;
  String? token;
  String? name;
  String? mobile;

  LoginModel({this.success, this.message, this.token, this.name, this.mobile});

  LoginModel.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    message = json['message'];
    token = json['token'];
    name = json['name'];
    mobile = json['mobile'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['success'] = this.success;
    data['message'] = this.message;
    data['token'] = this.token;
    data['name'] = this.name;
    data['mobile'] = this.mobile;
    return data;
  }
}