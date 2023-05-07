import 'dart:convert';
import 'dart:async' show Future;
import 'dart:math';
import 'package:final_project_dicoding/menus_screen.dart';
import 'package:final_project_dicoding/models/katakana.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:flutter/services.dart' show rootBundle;

class KatakanaPlay extends StatefulWidget {
  static const routeName = '/katakana';
  const KatakanaPlay({super.key});

  @override
  State<KatakanaPlay> createState() => _KatakanaPlayState();
}

class _KatakanaPlayState extends State<KatakanaPlay> {
  // double width = 400;
  // Katakana katakana = DefaultAssetBundle.of(context).loadString("assets/katakana.json");
  List<Katakana> katakana = MenusScreen.katakana;
  List<Katakana> katakana_questions = [];

  List<String> choices = [];
  void generateQuestion(answer) {
    choices.clear();
    for (var i = 0; i < 3; i++) {
      while (true) {
        bool isSame = false;
        int randomIndex = Random().nextInt(46);
        for (var j = 0; j < choices.length; j++) {
          if (choices[j] == katakana[randomIndex].pronounciation) {
            isSame = true;
          }
        }
        if (!isSame) {
          if (katakana[randomIndex].pronounciation != answer) {
            choices.add(katakana[randomIndex].pronounciation);
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
    if (katakana_questions.length == 0) {
      katakana_questions = [];
      for (int i = 0; i < 46; i++) {
        int randomIndex = Random().nextInt(46);
        bool isExist = false;
        while (true) {
          randomIndex = Random().nextInt(46);
          isExist = false;
          for (var questions in katakana_questions) {
            if (katakana[randomIndex].katakana == questions.katakana) {
              isExist = true;
            }
          }
          if (!isExist) {
            break;
          }
        }
        katakana_questions.add(katakana[randomIndex]);
        // print(katakana[randomIndex].katakana);
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
    generateQuestion(katakana_questions[0].pronounciation);
    return Scaffold(
      appBar: AppBar(
        title: Text('Play Katakana'),
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
            height: constraints.maxHeight > 600 ? constraints.maxHeight : 600,
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
                                katakana_questions[0].katakana,
                                style: TextStyle(fontSize: 150),
                              ),
                            ]),
                          ),
                          Container(
                            child: Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  for (var choice in choices)
                                    GestureDetector(
                                        onTap: () => {
                                              setState(() => {
                                                    if (choice ==
                                                        katakana_questions[0]
                                                            .pronounciation)
                                                      {
                                                        katakana_questions
                                                            .removeAt(0),
                                                      }
                                                  })
                                            },
                                        child: ItemChoice(
                                            answer: katakana_questions[0]
                                                .pronounciation,
                                            choice: choice,
                                            width: width))
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
                        katakana.length,
                        (index) => gridViewItem(context,
                            katakana[index], fontSize, margin)),
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

Widget listViewItem(BuildContext context, Katakana katakana,
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
      //   katakana.,
      //   width: imageWidth,
      // ),
      title: Text(
        katakana.katakana,
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

Widget gridViewItem(
    BuildContext context, Katakana katakana, double fontSize, double margin) {
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
              katakana.katakana,
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
              katakana.pronounciation,
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

// Widget gridViewItem(BuildContext context, Katakana katakana, double fontSize,
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
