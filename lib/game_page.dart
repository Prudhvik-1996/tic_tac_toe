import 'dart:math';

import 'package:flutter/material.dart';
import 'package:tic_tac_toe/game_button.dart';

void main() => runApp(GamePage());

class GamePage extends StatefulWidget {

  final bool isAI;
  final int level;
  GamePage({
    this.isAI,
    this.level
  });

  @override
  _GamePageState createState() => new _GamePageState(isAI, level);
}

class _GamePageState extends State<GamePage> {

  bool isAI;
  int level;

  _GamePageState(
      this.isAI,
      this.level
      );

  List<GameButton> gameButtons;
  var player1;
  var player2;
  var activePlayer;
  var winner = -1;
  int player1WinsCount;
  int player2WinsCount;

  @override
  void initState() {
    super.initState();
    gameButtons = initialiseGridButtons();
  }

  List<GameButton> initialiseGridButtons() {
    player1 = List<int>();
    player2 = List<int>();
    player1WinsCount = 0;
    player2WinsCount = 0;
    activePlayer = 1;
    var gameButtons = <GameButton>[
      GameButton(id: 1),
      GameButton(id: 2),
      GameButton(id: 3),
      GameButton(id: 4),
      GameButton(id: 5),
      GameButton(id: 6),
      GameButton(id: 7),
      GameButton(id: 8),
      GameButton(id: 9),
    ];
    return gameButtons;
  }

  void playGame(GameButton gb) {
    setState(() {
      if (activePlayer == 1) {
        gb.text = "X";
        gb.bg = Colors.red;
        activePlayer = 2;
        player1.add(gb.id);
      } else if (activePlayer == 2) {
        gb.text = "O";
        gb.bg = Colors.green;
        activePlayer = 1;
        player2.add(gb.id);
      }
      gb.enabled = false;
    });

    List<int> winGrid = checkWinner(player1, player2);

    if (!winGrid.contains(-1)) {
      endGame(winGrid);
      return;
    }

    if (isAI && activePlayer == 2) {
      aiPlay();
    }
  }

  void aiPlay() {
    if (isAI && activePlayer == 2) {
      List<GameButton> unPlayedButtons = List<GameButton>();
      gameButtons.forEach((button) =>
      button.enabled ? unPlayedButtons.add(button) : null
      );

      switch (level) {
        case 1:
          if (makeRandomMove(unPlayedButtons)) return;

          break;

        case 2:
        // if the grid is empty, make a random move, just to make more user friendly
          if (isGridEmpty() && makeRandomMove(unPlayedButtons)) return;

          // If there is a move that makes a win.. make it..
          if (makeWinningMove(unPlayedButtons)) return;

          // If centre is empty, try and fill it.
          if (occupyCentre(unPlayedButtons)) return;

          // If there is no way to win, try and occupy a corner..
          if (occupyCorner(unPlayedButtons)) return;

          // else pick a random move as in level 1..
          if (makeRandomMove(unPlayedButtons)) return;

          break;

        case 3:
        // if the grid is empty, make a random move, just to make more user friendly
          if (isGridEmpty() && makeRandomMove(unPlayedButtons)) return;

          // If there is a move that makes a win.. make it..
          if (makeWinningMove(unPlayedButtons)) return;

          // if the next step is a winning move to the user, counter it..
          if (counterUsersWinningMove(unPlayedButtons)) return;

          // If centre is empty, try and fill it.
          if (occupyCentre(unPlayedButtons)) return;

          // If there is no way to win, try and occupy a corner..
          if (occupyCorner(unPlayedButtons)) return;

          // else pick a random move as in level 1..
          if (makeRandomMove(unPlayedButtons)) return;

          break;
      }
    }
  }

  bool isGridEmpty() {
    bool isGridEmpty = true;
    for (var i = 0; i < gameButtons.length; i++) {
      if (!gameButtons[i].enabled) {
        isGridEmpty = false;
        break;
      }
    }
    return isGridEmpty;
  }

  bool isGridFull() {
    bool isGridFull = true;
    for (var i = 0; i < gameButtons.length; i++) {
      if (gameButtons[i].enabled) {
        isGridFull = false;
        break;
      }
    }
    return isGridFull;
  }

  bool makeWinningMove(List<GameButton> unPlayedButtons) {
    for (int i = 0; i < unPlayedButtons.length; i++) {
      GameButton gb = unPlayedButtons[i];
      List<int> dummyPlayer2 = List.of(player2);
      dummyPlayer2.add(gb.id);
      if (!checkWinner(player1, dummyPlayer2).contains(-1)) {
        playGame(gb);
        return true;
      }
    }
    return false;
  }

  bool counterUsersWinningMove(List<GameButton> unPlayedButtons) {
    for (int i = 0; i < unPlayedButtons.length; i++) {
      GameButton gb = unPlayedButtons[i];
      List<int> dummyPlayer1 = List.of(player1);
      dummyPlayer1.add(gb.id);
      if (!checkWinner(dummyPlayer1, player2).contains(-1)) {
        playGame(gb);
        return true;
      }
    }
    return false;
  }

  bool occupyCentre(List<GameButton> unPlayedButtons) {
    for (var i = 0; i < unPlayedButtons.length; i++) {
      if (5 == (unPlayedButtons[i].id)) {
        playGame(unPlayedButtons[i]);
        return true;
      }
    }
    return false;
  }

  bool occupyCorner(List<GameButton> unPlayedButtons) {
    List<int> cornerButtonIds = [1,3,7,9];
    cornerButtonIds.shuffle();
    for (var i = 0; i < unPlayedButtons.length; i++) {
      if (cornerButtonIds.contains(unPlayedButtons[i].id)) {
        playGame(unPlayedButtons[i]);
        return true;
      }
    }
    return false;
  }

  bool makeRandomMove(List<GameButton> unPlayedButtons) {
    final _random = new Random();
    if (unPlayedButtons.length > 0) {
      GameButton aiPlay = unPlayedButtons[_random.nextInt(unPlayedButtons.length)];
      playGame(aiPlay);
      return true;
    }
    return false;
  }

  List<int> checkWinner(List<int> player1, List<int> player2) {
    winner = -1;

    if (player1.contains(1) && player1.contains(2) && player1.contains(3)) {
      winner = 1;
      return [1,2,3];
    }

    if (player1.contains(4) && player1.contains(5) && player1.contains(6)) {
      winner = 1;
      return [4,5,6];
    }

    if (player1.contains(7) && player1.contains(8) && player1.contains(9)) {
      winner = 1;
      return [7,8,9];
    }

    if (player1.contains(1) && player1.contains(5) && player1.contains(9)) {
      winner = 1;
      return [1,5,9];
    }

    if (player1.contains(3) && player1.contains(5) && player1.contains(7)) {
      winner = 1;
      return [3,5,7];
    }

    if (player1.contains(1) && player1.contains(4) && player1.contains(7)) {
      winner = 1;
      return [1,4,7];
    }

    if (player1.contains(2) && player1.contains(5) && player1.contains(8)) {
      winner = 1;
      return [2,5,8];
    }

    if (player1.contains(3) && player1.contains(6) && player1.contains(9)) {
      winner = 1;
      return [3,6,9];
    }

    if (player2.contains(1) && player2.contains(2) && player2.contains(3)) {
      winner = 2;
      return [1,2,3];
    }

    if (player2.contains(4) && player2.contains(5) && player2.contains(6)) {
      winner = 2;
      return [4,5,6];
    }

    if (player2.contains(7) && player2.contains(8) && player2.contains(9)) {
      winner = 2;
      return [7,8,9];
    }

    if (player2.contains(1) && player2.contains(5) && player2.contains(9)) {
      winner = 2;
      return [1,5,9];
    }

    if (player2.contains(3) && player2.contains(5) && player2.contains(7)) {
      winner = 2;
      return [3,5,7];
    }

    if (player2.contains(1) && player2.contains(4) && player2.contains(7)) {
      winner = 2;
      return [1,4,7];
    }

    if (player2.contains(2) && player2.contains(5) && player2.contains(8)) {
      winner = 2;
      return [2,5,8];
    }

    if (player2.contains(3) && player2.contains(6) && player2.contains(9)) {
      winner = 2;
      return [3,6,9];
    }

    return [-1,-1,-1];
  }

  void endGame(List<int> winButtons) {
    if (gameButtons[winButtons[0] - 1].bg == Colors.red) {
      player1WinsCount++;
    } else {
      player2WinsCount++;
    }
    gameButtons[winButtons[0] - 1].bg = Colors.blue;
    gameButtons[winButtons[1] - 1].bg = Colors.blue;
    gameButtons[winButtons[2] - 1].bg = Colors.blue;
    for (int i = 0; i < gameButtons.length; i++) {
      gameButtons[i].enabled = false;
    }
  }

  void resetGrid() {
    setState(() {
      for (int i = 0; i < gameButtons.length; i++) {
        gameButtons[i].bg = Colors.grey;
        gameButtons[i].enabled = true;
        gameButtons[i].text = "";
      }
      player1 = List<int>();
      player2 = List<int>();
      winner = -1;

      if (isAI) {
        if (activePlayer == 1) {
          activePlayer = 1;
        } else {
          activePlayer = 2;
          if (isAI) {
            aiPlay();
          }
        }
      }
      else {
        if (activePlayer == 2) {
          activePlayer = 1;
        } else {
          activePlayer = 2;
          if (isAI) {
            aiPlay();
          }
        }
      }
      
    });
  }

  @override
  Widget build(BuildContext context) {
    bool isGridFilled = isGridFull();
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        title: Text("Tic Tac Toe"),
      ),
      body: Center(
          child: Stack (
            children: <Widget>[
              GridView.builder(
                gridDelegate : SliverGridDelegateWithFixedCrossAxisCount (
                  crossAxisCount: 3,
                  childAspectRatio: 1.0,
                  crossAxisSpacing: 9.0,
                  mainAxisSpacing: 9.0,
                ),
                padding: EdgeInsets.all(10.0),
                itemCount: gameButtons.length,
                itemBuilder: (context, i) => SizedBox(
                  child: RaisedButton(
                    padding: EdgeInsets.all(8.0),
                    onPressed: gameButtons[i].enabled ? () => playGame(gameButtons[i]) : null,
                    child: Text(
                      gameButtons[i].text,
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 40
                      ),
                    ),
                    color: gameButtons[i].bg,
                    disabledColor: gameButtons[i].bg,
                  ),
                ),
              ),
              Align (
                  alignment: FractionalOffset(0.5, 0.8),
                  child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        RaisedButton(
                          padding: EdgeInsets.all(8.0),
                          child: Text(
                              player1WinsCount.toString(),
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 20,
                              )
                          ),
                          color: Colors.red,
                          disabledColor: Colors.black,
                          onPressed: () => null,
                        ),
                        RaisedButton(
                          padding: EdgeInsets.all(8.0),
                          child: Text(
                            winner == -1 ? (isGridFilled ? "TIE" :"TO PLAY") : "WON",
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 20,
                            ),
                          ),
                          color: winner == -1 ? (isGridFilled ? Colors.blue : (activePlayer == 1 ? Colors.red : Colors.green)) : (activePlayer == 2 ? Colors.red : Colors.green),
                          disabledColor: Colors.black,
                          onPressed: () => null,
                        ),
                        RaisedButton(
                          padding: EdgeInsets.all(8.0),
                          child: Text(
                              player2WinsCount.toString(),
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 20,
                              )
                          ),
                          color: Colors.green,
                          disabledColor: Colors.black,
                          onPressed: () => null,
                        ),

                      ]
                  )
              )
            ],
          )
      ),
      persistentFooterButtons: <Widget>[
        RaisedButton(
          padding: EdgeInsets.all(8.0),
          child: Text(
            "RESET",
            style: TextStyle(
                color: Colors.black,
                fontSize: 20
            ),
          ),
          color: winner != -1 || isGridFilled ? Colors.blue : Colors.white,
          disabledColor: Colors.white,
          onPressed: () => resetGrid(),
        )
      ],
    );
  }
}