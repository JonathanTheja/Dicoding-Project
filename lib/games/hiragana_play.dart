import 'dart:convert';
import 'dart:async' show Future;
import 'dart:math';
import 'package:final_project_dicoding/menus_screen.dart';
import 'package:final_project_dicoding/models/hiragana.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:flutter/services.dart' show rootBundle;

class HiraganaPlay extends StatefulWidget {
  static const routeName = '/hiragana';
  const HiraganaPlay({super.key});

  @override
  State<HiraganaPlay> createState() => _HiraganaPlayState();
}

class _HiraganaPlayState extends State<HiraganaPlay> {
  // double width = 400;
  // Hiragana hiragana = DefaultAssetBundle.of(context).loadString("assets/hiragana.json");
  List<Hiragana> hiragana = MenusScreen.hiragana;
  List<Hiragana> hiragana_questions = [];

  List<String> choices = [];
  void generateQuestion(answer) {
    for (var i = 0; i < 3; i++) {
      while (true) {
        bool isSame = false;
        int randomIndex = Random().nextInt(46);
        for (var j = 0; j < choices.length; j++) {
          if (choices[j] == hiragana[randomIndex].pronounciation) {
            isSame = true;
          }
        }
        if (!isSame) {
          if (hiragana[randomIndex].pronounciation != answer) {
            choices.add(hiragana[randomIndex].pronounciation);
            break;
          }
        }
      }
    }
    int randomIndex = Random().nextInt(4);
    if (randomIndex == 3) {
      choices.add(answer);
    } else {
      choices.insert(randomIndex, answer);
    }
  }

  Future<void> loadQuestions() async {
    if (hiragana_questions.length == 0) {
      for (int i = 0; i < 46; i++) {
        int randomIndex = Random().nextInt(46);
        bool isExist = false;
        while (true) {
          randomIndex = Random().nextInt(46);
          isExist = false;
          for (var questions in hiragana_questions) {
            if (hiragana[randomIndex] == questions.hiragana) {
              isExist = true;
            }
          }
          if (!isExist) {
            break;
          }
        }
        hiragana_questions.add(hiragana[randomIndex]);
        print(hiragana[randomIndex].hiragana);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    double fontSize;
    double margin;
    int crossAxisCount;
    double width;
    loadQuestions();
    generateQuestion(hiragana_questions[0].pronounciation);
    return Scaffold(
      appBar: AppBar(
        title: Text('Play Hiragana'),
      ),
      body: LayoutBuilder(
          builder: (BuildContext context, BoxConstraints constraints) {
        if (constraints.maxWidth <= 600) {
          fontSize = 20;
          crossAxisCount = 4;
          width = 100;
          margin = 2;
        } else if (constraints.maxWidth <= 900) {
          fontSize = 20;
          crossAxisCount = 7;
          width = 200;
          margin = 5;
        } else if (constraints.maxWidth <= 1200) {
          fontSize = 20;
          crossAxisCount = 10;
          width = 300;
          margin = 5;
        } else {
          fontSize = 30;
          crossAxisCount = 10;
          width = 300;
          margin = 5;
        }
        return SingleChildScrollView(
          child: Container(
            height: 800,
            child: Stack(
              children: [
                Align(
                    alignment: Alignment.topCenter,
                    child: Container(
                      // padding: EdgeInsets.fromLTRB(0, 20.0, 0, 0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Container(
                            margin: EdgeInsets.fromLTRB(0, 0, 20.0, 0),
                            child: Column(children: [
                              Text(
                                hiragana_questions[0].hiragana,
                                style: TextStyle(fontSize: 150),
                              ),
                            ]),
                          ),
                          Container(
                            child: Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  for (var choice in choices)
                                    ItemChoice(
                                        answer: hiragana_questions[0]
                                            .pronounciation,
                                        choice: choice, width: width)
                                ]),
                          ),
                        ],
                      ),
                    )),
                Container(
                  padding: EdgeInsets.fromLTRB(5, 5.0, 5, 5),
                  margin: EdgeInsets.fromLTRB(0, 250, 0, 0),
                  color: Colors.red[100],
                  child: GridView.count(
                    crossAxisCount: crossAxisCount,
                    // childAspectRatio: 0.75,
                    children: List.generate(
                        hiragana_questions.length,
                        (index) => gridViewItem(
                            context, hiragana_questions[index], fontSize, margin)),
                  ),
                )
              ],
            ),
          ),
        );
      }),
    );
  }
}

Widget listViewItem(BuildContext context, Hiragana hiragana,
    double verticalPadding, double fontSize, double imageWidth) {
  return Container(
    margin: const EdgeInsets.fromLTRB(10.0, 20.0, 10.0, 0),
    decoration: BoxDecoration(
      color: Colors.red[500],
      borderRadius: BorderRadius.circular(10),
    ),
    child: ListTile(
      contentPadding:
          EdgeInsets.symmetric(horizontal: 16.0, vertical: verticalPadding),
      // leading: Image.network(
      //   hiragana.,
      //   width: imageWidth,
      // ),
      title: Text(
        hiragana.hiragana,
        style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
            fontSize: fontSize),
      ),
      // subtitle: Text(article.author),
      onTap: () {
        //argument ini mau ngirim detailnya apa
        // Navigator.pushNamed(context, DetailNewsScreen.routeName,
        //     arguments: article);
      },
    ),
  );
}

Widget gridViewItem(BuildContext context, Hiragana hiragana, double fontSize, double margin) {
  return GestureDetector(
    onTap: () {},
    child: SizedBox.expand(
      child: Container(
        margin: EdgeInsets.fromLTRB(5.0, 10.0, 5.0, 0.0),
        decoration: BoxDecoration(
          color: Colors.red[600],
          borderRadius: BorderRadius.circular(10),
        ),
        child: Center(
            child:
                Column(mainAxisAlignment: MainAxisAlignment.center, children: [
          // Expanded(
          //     child: Image.network(
          //   menu.url,
          //   width: imageWidth,
          // )),
          Container(
            padding: EdgeInsets.fromLTRB(0, 0, 0, margin),
            child: Text(
              hiragana.hiragana,
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
                fontSize: fontSize,
              ),
            ),
          ),
          Container(
            padding: EdgeInsets.fromLTRB(0, margin, 0, 0),
            child: Text(
              hiragana.pronounciation,
              style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: fontSize),
            ),
          ),
        ])),
      ),
    ),
  );
}

// Widget gridViewItem(BuildContext context, Hiragana hiragana, double fontSize,
//     double imageWidth, double bottomPadding) {
//   return Container(
//     margin: const EdgeInsets.all(8),
//     color: Colors.blueGrey,
//     height: 100,
//   );
// }

class ItemChoice extends StatefulWidget {
  final String answer;
  final String choice;
  final double width;

  ItemChoice({required this.answer, required this.choice, required this.width});

  @override
  State<ItemChoice> createState() => ItemChoiceState();
}

class ItemChoiceState extends State<ItemChoice> {
  bool _isHovered = false;
  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      cursor: SystemMouseCursors.click,
      onEnter: (event) => {
        setState(() => {_isHovered = true})
      },
      onExit: (event) => {
        setState(() => {_isHovered = false})
      },
      child: Container(
          margin: const EdgeInsets.fromLTRB(5.0, 13.0, 5.0, 0),
          padding: const EdgeInsets.fromLTRB(0.0, 5.0, 0.0, 5.0),
          width: widget.width,
          decoration: BoxDecoration(
            color: _isHovered ? Colors.orangeAccent : Colors.red[500],
            borderRadius: BorderRadius.circular(10),
          ),
          child: Center(
            child: Text(
              widget.choice,
              style: TextStyle(fontSize: 30, color: Colors.white),
            ),
          )),
    );
  }
}

// Widget itemChoices(BuildContext context, answer, choice) {
//   return Container(
//       margin: const EdgeInsets.fromLTRB(5.0, 13.0, 5.0, 0),
//       padding: const EdgeInsets.fromLTRB(0.0, 5.0, 0.0, 5.0),
//       width: 300,
//       decoration: BoxDecoration(
//         color: Colors.red[500],
//         borderRadius: BorderRadius.circular(10),
//       ),
//       child: Center(
//         child: Text(
//           choice,
//           style: TextStyle(fontSize: 30, color: Colors.white),
//         ),
//       ));
// }
