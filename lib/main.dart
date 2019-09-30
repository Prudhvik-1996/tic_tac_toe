import 'package:flutter/material.dart';
import 'package:tic_tac_toe/game_page.dart';
import 'package:tic_tac_toe/play_with_ai.dart';

import 'home_page.dart';

void main() => runApp(TicTacToe());

class TicTacToe extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Tic Tac Toe',
        home: HomePage(),
        theme: ThemeData(primaryColor: Colors.black),
        debugShowCheckedModeBanner: false,
        initialRoute: '/',
        routes: {
          "/game1on1": (context) => GamePage(isAI: false, level: -1,),
          "/playWithAI": (context) => PlayWithAI(),
          "/game1onAIEasy": (context) => GamePage(isAI: true, level: 1,),
          "/game1onAIMedium": (context) => GamePage(isAI: true, level: 2,),
          "/game1onAIHard": (context) => GamePage(isAI: true, level: 3,),
        }
    );
  }
}