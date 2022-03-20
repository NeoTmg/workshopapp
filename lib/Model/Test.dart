
import 'dart:convert';

List<Test> testFromJson(String str) => List<Test>.from(json.decode(str).map((x) => Test.fromJson(x)));

String testToJson(List<Test> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Test {
  Test({
    required this.id,
    required this.title,
  });

  int id;
  String title;

  factory Test.fromJson(Map<String, dynamic> json) => Test(
    id: json["id"],
    title: json["title"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "title": title,
  };
}
