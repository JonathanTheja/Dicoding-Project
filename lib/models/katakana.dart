import 'dart:convert';

class Katakana {
  final String katakana;
  final String pronounciation;

  Katakana({required this.katakana, required this.pronounciation});

  factory Katakana.fromJson(Map<String, dynamic> json) => Katakana(
      katakana: json['katakana'], pronounciation: json['pronounciation']);

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['katakana'] = this.katakana;
    data['pronounciation'] = this.pronounciation;
    return data;
  }
}

List<Katakana> parseKatakana(String? json) {
  if (json == null) {
    return [];
  }
  final List parsed = jsonDecode(json)["katakana"];
  return parsed
      .map((json) => Katakana.fromJson(json))
      .toList(); //dapat List of menus dari json
}
