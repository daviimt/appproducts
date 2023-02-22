
class User {
  int? id;
  String? username;
  String? password;
  bool? enabled;
  String? role;
  String? token;
  List<int>? listFavs;

  User(
      {this.id,
      this.username,
      this.password,
      this.enabled,
      this.role,
      this.token,
      this.listFavs});

  User.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    username = json['username'];
    password = json['password'];
    enabled = json['enabled'];
    role = json['role'];
    token = json['token'];
    listFavs = json['listFavs'].cast<int>();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['username'] = this.username;
    data['password'] = this.password;
    data['enabled'] = this.enabled;
    data['role'] = this.role;
    data['token'] = this.token;
    data['listFavs'] = this.listFavs;
    return data;
  }
}
