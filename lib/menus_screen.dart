import 'dart:convert';

import 'package:final_project_dicoding/models/hiragana.dart';
import 'package:final_project_dicoding/models/katakana.dart';
import 'package:final_project_dicoding/models/menus.dart';
import 'package:final_project_dicoding/tictactoe_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:flutter/src/widgets/framework.dart';

class MenusScreen extends StatefulWidget {
  static const routeName = '/menus';
  static List<Hiragana> hiragana = [];
  static List<Katakana> katakana = [];
  const MenusScreen({super.key});

  @override
  State<MenusScreen> createState() => _MenusScreenState();
}

class _MenusScreenState extends State<MenusScreen> {
  Future<void> loadHiragana() async {
    String jsonString = '';
    try {
      jsonString = await rootBundle.loadString('../assets/hiragana.json');
    } catch (e) {}
    try {
      jsonString = await rootBundle.loadString('assets/hiragana.json');
    } catch (e) {}
    List<dynamic> hiraganaJson = await jsonDecode(jsonString)['hiragana'];
    MenusScreen.hiragana = hiraganaJson
        .map((item) => Hiragana(
              hiragana: item['hiragana'],
              pronounciation: item['pronounciation'],
            ))
        .toList();
    // print(MenusScreen.hiragana[0].hiragana);
    // print(MenusScreen.hiragana[0].pronounciation);
    // print(MenusScreen.hiragana.length);
  }

  Future<void> loadKatakana() async {
    String jsonString = '';
    try {
      jsonString = await rootBundle.loadString('../assets/katakana.json');
    } catch (e) {}
    try {
      jsonString = await rootBundle.loadString('assets/katakana.json');
    } catch (e) {}
    List<dynamic> katakanaJson = await jsonDecode(jsonString)['katakana'];
    MenusScreen.katakana = katakanaJson
        .map((item) => Katakana(
              katakana: item['katakana'],
              pronounciation: item['pronounciation'],
            ))
        .toList();
    // print(MenusScreen.katakana[0].katakana);
    // print(MenusScreen.katakana[0].pronounciation);
    // print(MenusScreen.katakana.length);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: const Text("Let's play games")),
        body: FutureBuilder(
            future:
                DefaultAssetBundle.of(context).loadString("assets/menus.json"),
            builder: (context, snapshot) {
              final List<Menu> menus = parseMenus(snapshot.data);
              return FutureBuilder(
                  future: Future.wait([loadHiragana(), loadKatakana()]),
                  builder: (context, snapshot) {
                    return LayoutBuilder(builder:
                        (BuildContext context, BoxConstraints constraints) {
                      if (constraints.maxWidth <= 600) {
                        return ListView.builder(
                          itemCount: menus.length,
                          itemBuilder: (context, index) {
                            Widget listViewItem = ListViewItem(
                              menu: menus[index],
                              verticalPadding: 8.0,
                              fontSize: 20,
                              imageWidth: 100,
                            );
                            return listViewItem;
                            // return listViewItem(context, menus[index], 8.0, 15, 100);
                          },
                        );
                      } else if (constraints.maxWidth <= 1200) {
                        List<Widget> gridViewItemList = List.generate(
                            menus.length,
                            (index) => GridViewItem(
                                menu: menus[index],
                                fontSize: 30,
                                imageWidth: 150,
                                bottomPadding: 10));
                        return GridView.count(
                            crossAxisCount: 3,
                            childAspectRatio: 0.75,
                            children: gridViewItemList
                            // List.generate(
                            //     menus.length,
                            //     (index) =>
                            //         gridViewItem(context, menus[index], 30, 150, 10)),
                            );
                      }
                      List<Widget> gridViewItemList = List.generate(
                          menus.length,
                          (index) => GridViewItem(
                              menu: menus[index],
                              fontSize: 40,
                              imageWidth: 250,
                              bottomPadding: 30));
                      return GridView.count(
                          crossAxisCount: 3,
                          childAspectRatio: 0.75,
                          children: gridViewItemList
                          // List.generate(
                          //     menus.length,
                          //     (index) =>
                          //         gridViewItem(context, menus[index], 50, 300, 30)),
                          );
                    });
                  });
            }));
  }
}

class ListViewItem extends StatefulWidget {
  final Menu menu;
  final double verticalPadding;
  final double fontSize;
  final double imageWidth;

  ListViewItem(
      {required this.menu,
      required this.verticalPadding,
      required this.fontSize,
      required this.imageWidth});

  @override
  State<ListViewItem> createState() => ListViewItemState();
}

class ListViewItemState extends State<ListViewItem> {
  bool _isHovered = false;
  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (event) => {
        setState(() => {_isHovered = true})
      },
      onExit: (_) {
        setState(() {
          _isHovered = false;
        });
      },
      child: Container(
        margin: const EdgeInsets.fromLTRB(10.0, 20.0, 10.0, 0),
        decoration: BoxDecoration(
          color: _isHovered ? Colors.orangeAccent : Colors.red[500],
          borderRadius: BorderRadius.circular(10),
        ),
        child: ListTile(
          contentPadding: EdgeInsets.symmetric(
              horizontal: 16.0, vertical: widget.verticalPadding),
          leading: Image.network(
            widget.menu.url,
            width: widget.imageWidth,
          ),
          title: Text(
            widget.menu.title,
            style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
                fontSize: widget.fontSize),
          ),
          // subtitle: Text(article.author),
          onTap: () {
            //argument ini mau ngirim detailnya apa
            Navigator.pushNamed(context, widget.menu.route);
          },
        ),
      ),
    );
  }
}

class GridViewItem extends StatefulWidget {
  final Menu menu;
  final double fontSize;
  final double imageWidth;
  final double bottomPadding;

  GridViewItem(
      {required this.menu,
      required this.fontSize,
      required this.imageWidth,
      required this.bottomPadding});

  @override
  State<GridViewItem> createState() => GridViewItemState();
}

class GridViewItemState extends State<GridViewItem> {
  bool _isHovered = false;
  @override
  Widget build(BuildContext context) {
    return MouseRegion(
        cursor: SystemMouseCursors.click,
        onEnter: (event) => {
              setState(() => {_isHovered = true})
            },
        onExit: (_) {
          setState(() {
            _isHovered = false;
          });
        },
        child: GestureDetector(
          child: Container(
            margin: const EdgeInsets.fromLTRB(10.0, 20.0, 10.0, 20.0),
            decoration: BoxDecoration(
              color: _isHovered ? Colors.orangeAccent : Colors.red[500],
              borderRadius: BorderRadius.circular(10),
            ),
            child: Column(children: [
              Expanded(
                  child: Image.network(
                widget.menu.url,
                width: widget.imageWidth,
              )),
              Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                  child: Padding(
                    padding: EdgeInsets.fromLTRB(0, 0, 0, widget.bottomPadding),
                    child: Text(
                      widget.menu.title,
                      style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: widget.fontSize),
                    ),
                  )),
            ]),
          ),
          onTap: () {
            Navigator.pushNamed(context, widget.menu.route);
          },
        ));
  }
}

// Widget listViewItem(BuildContext context, Menu menu, double verticalPadding,
//     double fontSize, double imageWidth) {
//   return Container(
//     margin: const EdgeInsets.fromLTRB(10.0, 20.0, 10.0, 0),
//     decoration: BoxDecoration(
//       color: Colors.red[500],
//       borderRadius: BorderRadius.circular(10),
//     ),
//     child: ListTile(
//       contentPadding:
//           EdgeInsets.symmetric(horizontal: 16.0, vertical: verticalPadding),
//       leading: Image.network(
//         menu.url,
//         width: imageWidth,
//       ),
//       title: Text(
//         menu.title,
//         style: TextStyle(
//             color: Colors.white,
//             fontWeight: FontWeight.bold,
//             fontSize: fontSize),
//       ),
//       // subtitle: Text(article.author),
//       onTap: () {
//         //argument ini mau ngirim detailnya apa
//         // Navigator.pushNamed(context, DetailNewsScreen.routeName,
//         //     arguments: article);
//       },
//     ),
//   );
// }

// Widget gridViewItem(BuildContext context, Menu menu, double fontSize,
//     double imageWidth, double bottomPadding) {
//   return GestureDetector(
//     onTap: () {},
//     child: Container(
//       margin: const EdgeInsets.fromLTRB(10.0, 20.0, 10.0, 20.0),
//       decoration: BoxDecoration(
//         color: Colors.red[500],
//         borderRadius: BorderRadius.circular(10),
//       ),
//       child: Column(children: [
//         Expanded(
//             child: Image.network(
//           menu.url,
//           width: imageWidth,
//         )),
//         Padding(
//             padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
//             child: Padding(
//               padding: EdgeInsets.fromLTRB(0, 0, 0, bottomPadding),
//               child: Text(
//                 menu.title,
//                 style: TextStyle(
//                     color: Colors.white,
//                     fontWeight: FontWeight.bold,
//                     fontSize: fontSize),
//               ),
//             )),
//       ]),
//     ),
//   );
// }
