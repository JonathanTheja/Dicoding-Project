import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';

class TicTacToePlay extends StatefulWidget {
  static const routeName = '/tictactoe/play';
  final String level;
  const TicTacToePlay({Key? key, required this.level}) : super(key: key);

  @override
  State<TicTacToePlay> createState() => _TicTacToePlayState();
}

class _TicTacToePlayState extends State<TicTacToePlay> {
  var boards = List.generate(3, (index) => List<String>.filled(3, ''));
  var isHovereds = List.generate(3, (index) => List<bool>.filled(3, false));
  void resetBoards() {
    boards = List.generate(3, (index) => List<String>.filled(3, ''));
    isHovereds = List.generate(3, (index) => List<bool>.filled(3, false));
  }

  var player = 'X';
  var bot = 'O';

  List<List<String>> cloneBoards() {
    List<List<String>> clonedBoards =
        List.generate(3, (index) => List<String>.filled(3, ''));
    for (int i = 0; i < 3; i++) {
      for (int j = 0; j < 3; j++) {
        clonedBoards[i][j] = boards[i][j];
      }
    }
    return clonedBoards;
  }

  int getBoardFilled() {
    int ctr = 0;
    for (int i = 0; i < 3; i++) {
      for (int j = 0; j < 3; j++) {
        if (boards[i][j] != '') {
          ctr++;
        }
      }
    }
    return ctr;
  }

  bool isBotBlockPlayer(bot) {
    for (int i = 0; i < 3; i++) {
      for (int j = 0; j < 3; j++) {
        List<List<String>> clonedBoards = cloneBoards();
        if (clonedBoards[i][j] == '') {
          clonedBoards[i][j] = player;
        }
        if (winChecker(player, clonedBoards)) {
          boards[i][j] = bot;
          return true;
        }
      }
    }
    return false;
  }

  bool isBotHasWinningMove(bot) {
    for (int i = 0; i < 3; i++) {
      for (int j = 0; j < 3; j++) {
        List<List<String>> clonedBoards = cloneBoards();
        if (clonedBoards[i][j] == '') {
          clonedBoards[i][j] = bot;
        }
        if (winChecker(bot, clonedBoards)) {
          boards[i][j] = bot;
          return true;
        }
      }
    }
    return false;
  }

  bool isSudutTerdapat2(bot) {
    // cek setiap ujung apabila ada 2 yg deket ujung maka ditutup
    if (boards[1][0] == player &&
        boards[0][1] == player &&
        boards[0][0] == '') {
      boards[0][0] = bot;
      return true;
    } else if (boards[1][2] == player &&
        boards[0][1] == player &&
        boards[0][2] == '') {
      boards[0][2] = bot;
      return true;
    } else if (boards[1][0] == player &&
        boards[2][1] == player &&
        boards[2][0] == '') {
      boards[2][0] = bot;
      return true;
    } else if (boards[1][2] == player &&
        boards[2][1] == player &&
        boards[2][2] == '') {
      boards[2][2] = bot;
      return true;
    }
    return false;
  }

  bool winChecker(String player, tempBoards) {
    bool isWon = false;
    for (var i = 0; i < 3; i++) {
      if (tempBoards[i][0] == player &&
          tempBoards[i][1] == player &&
          tempBoards[i][2] == player) {
        isWon = true;
      }
    }
    for (var i = 0; i < 3; i++) {
      if (tempBoards[0][i] == player &&
          tempBoards[1][i] == player &&
          tempBoards[2][i] == player) {
        isWon = true;
      }
    }
    if (tempBoards[0][0] == player &&
        tempBoards[1][1] == player &&
        tempBoards[2][2] == player) {
      isWon = true;
    }
    if (tempBoards[2][0] == player &&
        tempBoards[1][1] == player &&
        tempBoards[0][2] == player) {
      isWon = true;
    }
    return isWon;
  }

  Widget cupertinoAlertDialog(checker, isOver) {
    return CupertinoAlertDialog(
      title: Text(
          isOver ? 'Tie!' : ((checker == player ? 'You' : 'Bot') + ' Won!')),
      content: Text('Play Again?'),
      actions: <CupertinoDialogAction>[
        CupertinoDialogAction(
            isDefaultAction: true,
            onPressed: () {
              resetBoards();
              Navigator.pop(context);
              player = player == 'X' ? 'O' : 'X';
              bot = bot == 'X' ? 'O' : 'X';
              if (bot == 'X') {
                randomBotMove();
              }
            },
            child: Text('Yes')),
        CupertinoDialogAction(
            isDestructiveAction: true,
            onPressed: () {
              resetBoards();
              Navigator.pop(context);
              Navigator.pop(context);
            },
            child: Text('No')),
      ],
    );
  }

  void randomBotMove() {
    List<List<int>> anyMoves = [
      [0, 0],
      [0, 1],
      [0, 2],
      [1, 0],
      [1, 1],
      [1, 2],
      [2, 0],
      [2, 1],
      [2, 2],
    ];
    String bot = player == 'X' ? 'O' : 'X';
    if (widget.level == 'easiest') {
      while (true) {
        int botx = Random().nextInt(3);
        int boty = Random().nextInt(3);
        if (boards[boty][botx] == '') {
          boards[boty][botx] = bot;
          break;
        }
        int ctr = getBoardFilled();
        if (ctr >= 9) {
          break;
        }
      }
    } else {
      int ctr = getBoardFilled();
      if (ctr == 0) {
        List<List<int>> randoms = [
          [0, 0],
          [0, 2],
          [2, 0],
          [2, 2],
          [1, 1],
        ];
        int index = Random().nextInt(5);
        boards[randoms[index][0]][randoms[index][1]] = bot;
      } else if (ctr == 1 || ctr == 2) {
        // bot O // bot X
        List<List<int>> randoms = [
          [0, 0],
          [0, 2],
          [2, 0],
          [2, 2],
        ];
        while (true) {
          int index = Random().nextInt(4);
          if (boards[1][1] == '') {
            boards[1][1] = bot;
            break;
          } else if (boards[randoms[index][0]][randoms[index][1]] == '') {
            boards[randoms[index][0]][randoms[index][1]] = bot;
            break;
          }
        }
      } else if (ctr == 3) {
        List<List<int>> randoms = [
          [0, 1],
          [1, 0],
          [1, 2],
          [2, 1],
        ];
        outerLoop:
        while (true) {
          int index = Random().nextInt(4);
          if (isBotHasWinningMove(bot)) {
            break;
          }
          if (isBotBlockPlayer(bot)) {
            break outerLoop;
          }
          if (isSudutTerdapat2(bot)) {
            break outerLoop;
          }
          if (boards[0][0] == '' &&
              (boards[0][2] != player || boards[2][0] != player)) {
            boards[0][0] = bot;
            break outerLoop;
          } else if (boards[0][2] == '' &&
              (boards[0][0] != player || boards[2][2] != player)) {
            boards[0][2] = bot;
            break outerLoop;
          } else if (boards[2][0] == '' &&
              (boards[0][0] != player || boards[2][2] != player)) {
            boards[2][0] = bot;
            break outerLoop;
          } else if (boards[2][2] == '' &&
              (boards[0][2] != player || boards[2][0] != player)) {
            boards[2][2] = bot;
            break outerLoop;
          }
          if (boards[randoms[index][0]][randoms[index][1]] == '') {
            boards[randoms[index][0]][randoms[index][1]] = bot;
            break;
          }
        }
      } else {
        while (true) {
          int index = Random().nextInt(9);
          if (isBotHasWinningMove(bot)) {
            break;
          }
          if (isBotBlockPlayer(bot)) {
            break;
          }
          if (ctr == 4) {
            if (boards[0][0] == bot &&
                boards[1][1] == bot &&
                boards[0][1] == '') {
              boards[0][1] = bot;
              break;
            } else if (boards[0][0] == bot &&
                boards[1][1] == bot &&
                boards[1][0] == '') {
              boards[1][0] = bot;
              break;
            } else if (boards[2][0] == bot &&
                boards[1][1] == bot &&
                boards[1][0] == '') {
              boards[1][0] = bot;
              break;
            } else if (boards[2][0] == bot &&
                boards[1][1] == bot &&
                boards[2][1] == '') {
              boards[2][1] = bot;
              break;
            } else if (boards[2][2] == bot &&
                boards[1][1] == bot &&
                boards[2][1] == '') {
              boards[2][1] = bot;
              break;
            } else if (boards[2][2] == bot &&
                boards[1][1] == bot &&
                boards[1][2] == '') {
              boards[1][2] = bot;
              break;
            } else if (boards[0][2] == bot &&
                boards[1][1] == bot &&
                boards[1][2] == '') {
              boards[1][2] = bot;
              break;
            } else if (boards[0][2] == bot &&
                boards[1][1] == bot &&
                boards[0][1] == '') {
              boards[0][1] = bot;
              break;
            }
          }
          if (isSudutTerdapat2(bot)) {
            break;
          }
          if (boards[anyMoves[index][0]][anyMoves[index][1]] == '') {
            boards[anyMoves[index][0]][anyMoves[index][1]] = bot;
            break;
          }
          if (ctr >= 9) {
            break;
          }
        }
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    if(winChecker(player, boards)){
      resetBoards();
    }
    if(winChecker(bot, boards)){
      resetBoards();
    }
    if(getBoardFilled() == 9){
      resetBoards();
    }
    double size = 100;
    double fontSize = 70;
    return Scaffold(
        appBar: AppBar(
            title: Text('Play Tic Tac Toe - ${widget.level.toUpperCase()}')),
        body: LayoutBuilder(
            builder: (BuildContext context, BoxConstraints constraints) {
          if (constraints.maxWidth <= 400) {
            size = 60;
            fontSize = 40;
          } else if (constraints.maxWidth <= 800) {
            size = 100;
            fontSize = 70;
          } else {
            size = 150;
            fontSize = 100;
          }
          return SingleChildScrollView(
            child: Container(
              height: constraints.maxHeight > size * 4 ? constraints.maxHeight : size * 6,
              color: Colors.red[200],
              child: Expanded(
                  child: Align(
                      alignment: Alignment.center,
                      child: Container(
                        padding: const EdgeInsets.fromLTRB(10.0, 0, 10.0, 0),
                        color: Colors.red[200],
                        width: size * 3 + 10 * 8,
                        child: Center(
                            child: Column(
                          children: [
                            Container(
                              padding: const EdgeInsets.fromLTRB(
                                  10.0, 10.0, 10.0, 10.0),
                              child: Row(
                                children: [
                                  Flexible(
                                      flex: 1,
                                      fit: FlexFit.tight,
                                      child: Text('You : ' + player,
                                          style: const TextStyle(
                                              fontWeight: FontWeight.bold,
                                              fontSize: 20))),
                                  Flexible(
                                      flex: 1,
                                      fit: FlexFit.tight,
                                      child: Text(
                                          'Bot : ' +
                                              (player == 'X' ? 'O' : 'X'),
                                          style: const TextStyle(
                                              fontWeight: FontWeight.bold,
                                              fontSize: 20))),
                                ],
                              ),
                            ),
                            for (int i = 0; i < 3; i++)
                              GestureDetector(
                                child: Row(
                                  children: [
                                    for (int j = 0; j < 3; j++)
                                      MouseRegion(
                                        cursor: boards[i][j] == ''
                                            ? SystemMouseCursors.click
                                            : SystemMouseCursors.basic,
                                        onEnter: (event) => {
                                          if (boards[i][j] == '')
                                            {
                                              setState(() =>
                                                  {isHovereds[i][j] = true})
                                            }
                                        },
                                        onExit: (event) => {
                                          setState(
                                              () => {isHovereds[i][j] = false})
                                        },
                                        child: GestureDetector(
                                          onTap: () => {
                                            if (boards[i][j] == '')
                                              {
                                                setState(
                                                  () => {
                                                    boards[i][j] = player,
                                                    if (winChecker(
                                                        player, boards))
                                                      {
                                                        showDialog(
                                                            context: context,
                                                            barrierDismissible:
                                                                false,
                                                            builder:
                                                                (BuildContext
                                                                    context) {
                                                              return cupertinoAlertDialog(
                                                                  player,
                                                                  false);
                                                            }),
                                                      }
                                                    else
                                                      {
                                                        randomBotMove(),
                                                        if (winChecker(
                                                            bot, boards))
                                                          {
                                                            showDialog(
                                                                context:
                                                                    context,
                                                                barrierDismissible:
                                                                    false,
                                                                builder:
                                                                    (BuildContext
                                                                        context) {
                                                                  return cupertinoAlertDialog(
                                                                      bot,
                                                                      false);
                                                                }),
                                                          }
                                                      },
                                                  },
                                                )
                                              },
                                            if (getBoardFilled() >= 9)
                                              {
                                                showDialog(
                                                    context: context,
                                                    barrierDismissible: false,
                                                    builder:
                                                        (BuildContext context) {
                                                      return cupertinoAlertDialog(
                                                          player, true);
                                                    }),
                                              }
                                          },
                                          child: Container(
                                            margin: const EdgeInsets.fromLTRB(
                                                10.0, 10.0, 10.0, 10.0),
                                            decoration: BoxDecoration(
                                                color: isHovereds[i][j]
                                                    ? Colors.red[600]
                                                    : Colors.red[400],
                                                borderRadius:
                                                    BorderRadius.circular(10)),
                                            height: size,
                                            width: size,
                                            child: Center(
                                                child: Text(
                                              boards[i][j],
                                              style:
                                                  TextStyle(fontSize: fontSize),
                                            )),
                                          ),
                                        ),
                                      ),
                                  ],
                                ),
                              ),
                          ],
                        )),
                      ))),
            ),
          );
        }));
  }
}
