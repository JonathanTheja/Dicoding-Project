import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';

class TicTacToeScreen extends StatefulWidget {
  static const routeName = '/tictactoe';
  const TicTacToeScreen({super.key});

  @override
  State<TicTacToeScreen> createState() => _TicTacToeScreenState();
}

class _TicTacToeScreenState extends State<TicTacToeScreen> {
  @override
  Widget build(BuildContext context) {
    return const Placeholder();
  }
}