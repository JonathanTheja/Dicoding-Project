import 'dart:convert';

class Hiragana {
  final String hiragana;
  final String pronounciation;

  Hiragana({required this.hiragana, required this.pronounciation});

  factory Hiragana.fromJson(Map<String, dynamic> json) => Hiragana(
      hiragana: json['hiragana'], pronounciation: json['pronounciation']);

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['hiragana'] = this.hiragana;
    data['pronounciation'] = this.pronounciation;
    return data;
  }
}

List<Hiragana> parseHiragana(String? json) {
  if (json == null) {
    return [];
  }
  final List parsed = jsonDecode(json)["hiragana"];
  return parsed
      .map((json) => Hiragana.fromJson(json))
      .toList(); //dapat List of menus dari json
}
