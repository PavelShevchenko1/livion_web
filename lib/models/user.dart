import 'dart:convert';

LUser lUserFromJson(String str) => LUser.fromJson(json.decode(str));

String lUserToJson(LUser data) => json.encode(data.toJson());

class LUser {
  LUser({
    required this.name,
    required this.sex,
    required this.startw,
    required this.prefw,
    required this.birth,
  });

  String name;
  String sex;
  int startw;
  int prefw;
  String birth;

  factory LUser.fromJson(Map<String, dynamic> json) => LUser(
        name: json["name"],
        sex: json["sex"],
        startw: json["startw"],
        prefw: json["prefw"],
        birth: json["birth"],
      );

  Map<String, dynamic> toJson() => {
        "name": name,
        "sex": sex,
        "startw": startw,
        "prefw": prefw,
        "birth": birth,
      };
}
