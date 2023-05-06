import 'package:final_project_dicoding/games/tictactoe_play.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';

class TicTacToeScreen extends StatefulWidget {
  static const routeName = '/tictactoe';
  const TicTacToeScreen({super.key});

  @override
  State<TicTacToeScreen> createState() => _TicTacToeScreenState();
}

class _TicTacToeScreenState extends State<TicTacToeScreen> {
  bool isHoveredEasiest = false;
  bool isHoveredImpossible = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: const Text("Tic Tac Toe")),
        body: LayoutBuilder(
          builder: (BuildContext context, BoxConstraints constraints) {
            double fontSize = 80;
            if (constraints.maxWidth <= 600) {
              fontSize = 30;
            } else if (constraints.maxWidth <= 1200) {
              fontSize = 50;
            }
            return Column(children: [
                Flexible(
                    flex: 1,
                    fit: FlexFit.tight,
                    child: MouseRegion(
                        cursor: SystemMouseCursors.click,
                        onEnter: (event) => {
                              setState(() => {isHoveredEasiest = true})
                            },
                        onExit: (event) => {
                              setState(() => {isHoveredEasiest = false})
                            },
                        child: GestureDetector(
                            onTap: () => {
                              Navigator.pushNamed(context, TicTacToePlay.routeName, arguments: 'easiest')
                            },
                            child: Container(
                              color:
                                  isHoveredEasiest ? Colors.green[700] : Colors.green[800],
                              child: Center(
                                child: Text('Easiest',
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontWeight: FontWeight.bold,
                                        fontSize: fontSize)),
                              ),
                            )))),
                Flexible(
                    flex: 1,
                    fit: FlexFit.tight,
                    child: MouseRegion(
                        cursor: SystemMouseCursors.click,
                        onEnter: (event) => {
                              setState(() => {isHoveredImpossible = true})
                            },
                        onExit: (event) => {
                              setState(() => {isHoveredImpossible = false})
                            },
                        child: GestureDetector(
                            onTap: () => { 
                              Navigator.pushNamed(context, TicTacToePlay.routeName, arguments: 'impossible')
                            },
                            child: Container(
                              color:
                                  isHoveredImpossible ? Colors.deepPurple[800] : Colors.purple[900],
                              child: Center(
                                child: Text('Impossible',
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontWeight: FontWeight.bold,
                                        fontSize: fontSize)),
                              ),
                            )))),
              ]);
          },
        ));
  }
}
