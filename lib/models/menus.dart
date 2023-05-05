import 'dart:convert';

class Menus {
  List<Menu>? menu;

  Menus({this.menu});

  Menus.fromJson(Map<String, dynamic> json) {
    if (json['menu'] != null) {
      menu = <Menu>[];
      json['menu'].forEach((v) {
        menu!.add(new Menu.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.menu != null) {
      data['menu'] = this.menu!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Menu {
  final String title;
  final String route;
  final String url;

  Menu({required this.title, required this.route, required this.url});

  factory Menu.fromJson(Map<String, dynamic> json) => Menu(
      title: json["title"],
      route: json["route"],
      url: json["url"],);
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['title'] = this.title;
    data['route'] = this.route;
    data['url'] = this.url;
    return data;
  }
}

List<Menu> parseMenus(String? json) {
  if (json == null) {
    return [];
  }
  final List parsed = jsonDecode(json)["menus"];
  return parsed
      .map((json) => Menu.fromJson(json))
      .toList(); //dapat List of menus dari json
}
