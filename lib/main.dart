import 'package:final_project_dicoding/games/tictactoe_play.dart';
import 'package:final_project_dicoding/menus_screen.dart';
import 'package:final_project_dicoding/tictactoe_screen.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Let's Play Games",
      theme: ThemeData(
        // This is the theme of your application.
        //
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or simply save your changes to "hot reload" in a Flutter IDE).
        // Notice that the counter didn't reset back to zero; the application
        // is not restarted.
        primarySwatch: Colors.red,
      ),
      initialRoute: MenusScreen.routeName,
      routes: {
        MenusScreen.routeName: (context) => const MenusScreen(),
        TicTacToeScreen.routeName: (context) => const TicTacToeScreen(),
        // TicTacToePlay.routeName: (context) => TicTacToePlay(level: ModalRoute.of(context)?.settings.arguments as String)
        TicTacToePlay.routeName: (context) => TicTacToePlay(level: 'impossible')
      }
      // home: const MyHomePage(title: "Let's Play Games"),
    );
  }
}
