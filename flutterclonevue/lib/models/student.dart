import 'dart:convert';

List<Student> studentFromJson(String str) =>
    List<Student>.from(json.decode(str).map((x) => Student.fromJson(x)));

String studentToJson(List<Student> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Student {
  Student({
    required this.id,
    required this.name,
    required this.email,
    required this.teams,
    required this.gender,
  });

  late int id;
  late String name;
  late String email;
  late String teams;
  late String gender;

  factory Student.fromJson(Map<String, dynamic> json) => Student(
      id: json["id"],
      name: json["name"],
      email: json["email"],
      teams: json["teams"],
      gender: json["gender"]);

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "email": email,
        "teams": teams,
        "gender": gender
      };
}
