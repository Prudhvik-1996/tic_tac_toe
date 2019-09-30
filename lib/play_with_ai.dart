import 'package:flutter/material.dart';

void main() => runApp(PlayWithAI());

class PlayWithAI extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return MaterialApp(
      title: 'Tic Tac Toe',
      home: Scaffold(
        backgroundColor: Colors.black,
        body: (
            Center(
                child: Stack(
                    children: <Widget>[
                      Align (
                        alignment: FractionalOffset(0.5, 0.1),
                        child: Text(
                          "Tic Tac Toe",
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 40,
                          ),
                        ),
                      ),
                      Center(
                        child: Image.asset(
                          "assets/images/tic_tac_toe_home.png",
                          width: size.width,
                          height: size.width,
                          fit: BoxFit.fill,
                        ),
                      ),
                      Align (
                          alignment: FractionalOffset(0.5, 0.75),
                          child: SizedBox(
                            width: size.width,
                            child: RaisedButton(
                              padding: EdgeInsets.all(8.0),
                              child: Text(
                                "EASY",
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 20,
                                ),
                              ),
                              color: Colors.green,
                              disabledColor: Colors.green,
                              onPressed: () {
                                Navigator.pushNamed(context, "/game1onAIEasy");
                              },
                            ),
                          )
                      ),
                      Align (
                          alignment: FractionalOffset(0.5, 0.85),
                          child: SizedBox(
                            width: size.width,
                            child: RaisedButton(
                              padding: EdgeInsets.all(8.0),
                              child: Text(
                                "MEDIUM",
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 20,
                                ),
                              ),
                              color: Colors.blue,
                              disabledColor: Colors.blue,
                              onPressed: () {
                                Navigator.pushNamed(context, "/game1onAIMedium");
                              },
                            ),
                          )
                      ),
                      Align (
                          alignment: FractionalOffset(0.5, 0.95),
                          child: SizedBox(
                            width: size.width,
                            child: RaisedButton(
                              padding: EdgeInsets.all(8.0),
                              child: Text(
                                "HARD",
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 20,
                                ),
                              ),
                              color: Colors.red,
                              disabledColor: Colors.red,
                              onPressed: () {
                                Navigator.pushNamed(context, "/game1onAIHard");
                              },
                            ),
                          )
                      )

                    ]
                )
            )
        ),
      ),
      theme: ThemeData(primaryColor: Colors.black),
      debugShowCheckedModeBanner: false,
    );
  }
}