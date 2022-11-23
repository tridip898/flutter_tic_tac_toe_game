import 'dart:async';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  bool onTurn = true;
  List displayXO = ['', '', '', '', '', '', '', '', ''];
  List<int> matchedIndex = [];
  String resultDeclaration = '';
  int oScore = 0;
  int xScore = 0;
  int filledBoxes = 0;
  bool winnerFound = false;
  int attempts = 0;

  Timer? timer;
  static const maxSeconds = 30;
  int seconds = maxSeconds;

  static var customeFontWhite = GoogleFonts.coiny(
      textStyle: TextStyle(
          color: Colors.white,
          letterSpacing: 3,
          fontSize: 28)
  );

  void startTimer() {
    timer = Timer.periodic(Duration(seconds: 1), (_) {
      setState(() {
        if (seconds > 0) {
          seconds--;
        } else {
          stopTimer();
        }
      });
    });
  }

  void stopTimer() {
    resetTimer();
    timer?.cancel();
  }

  void resetTimer() => seconds = maxSeconds;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.purple,
        body: Padding(
          padding: EdgeInsets.all(20.0),
          child: Column(
            children: [
              Expanded(
                  flex: 1,
                  child: Container(
                    padding: EdgeInsets.only(bottom: 10),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Column(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            Text('Player 0', style: customeFontWhite),
                            Text(oScore.toString(), style: customeFontWhite)
                          ],
                        ),
                        SizedBox(
                          width: 30,
                        ),
                        Column(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            Text('Player X', style: customeFontWhite),
                            Text(xScore.toString(), style: customeFontWhite)
                          ],
                        ),
                      ],
                    ),
                  )),
              Expanded(
                  flex: 5,
                  child: GridView.builder(
                      itemCount: 9,
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 3),
                      itemBuilder: (BuildContext context, int index) {
                        return GestureDetector(
                          onTap: () {
                            _tapped(index);
                          },
                          child: Container(
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(15),
                                border: Border.all(color: Colors.purple, width: 5),
                                color: matchedIndex.contains(index)
                                    ? Colors.red
                                    : Colors.brown),
                            child: Center(
                              child: Text(
                                displayXO[index],
                                style: GoogleFonts.coiny(
                                    textStyle: TextStyle(
                                        fontSize: 60, color: matchedIndex.contains(index) ? Colors.brown : Colors.white)),
                              ),
                            ),
                          ),
                        );
                      })),
              Expanded(
                  flex: 2,
                  child: Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          resultDeclaration,
                          style: customeFontWhite,
                        ),
                        SizedBox(
                          height: 15,
                        ),
                        _buildTimer()
                      ],
                    ),
                  ))
            ],
          ),
        ),
      ),
    );
  }

  void _tapped(int index) {
    final isRunning = timer == null ? false : timer!.isActive;
    if (isRunning) {
      setState(() {
        if (onTurn && displayXO[index] == '') {
          displayXO[index] = 'O';
          filledBoxes++;
        } else if (!onTurn && displayXO[index] == '') {
          displayXO[index] = 'X';
          filledBoxes++;
        }
        onTurn = !onTurn;
        _checkWinner();
      });
    }
  }

  void _checkWinner() {
    //1st row
    if (displayXO[0] == displayXO[1] &&
        displayXO[0] == displayXO[2] &&
        displayXO[0] != '') {
      setState(() {
        resultDeclaration = 'Player ' + displayXO[0] + ' wins';
        matchedIndex.addAll([0, 1, 2]);
        stopTimer();
        _updateScore(displayXO[0]);
      });
    }
    //2nd row
    if (displayXO[3] == displayXO[4] &&
        displayXO[3] == displayXO[5] &&
        displayXO[3] != '') {
      setState(() {
        resultDeclaration = 'Player ' + displayXO[3] + ' wins';
        matchedIndex.addAll([3, 4, 5]);
        stopTimer();
        _updateScore(displayXO[3]);
      });
    }
    //3rd row
    if (displayXO[6] == displayXO[7] &&
        displayXO[6] == displayXO[8] &&
        displayXO[6] != '') {
      setState(() {
        resultDeclaration = 'Player ' + displayXO[6] + ' wins';
        matchedIndex.addAll([6, 7, 8]);
        stopTimer();
        _updateScore(displayXO[6]);
      });
    }
    //1st column
    if (displayXO[0] == displayXO[3] &&
        displayXO[0] == displayXO[6] &&
        displayXO[0] != '') {
      setState(() {
        resultDeclaration = 'Player ' + displayXO[0] + ' wins';
        matchedIndex.addAll([0, 3, 6]);
        stopTimer();
        _updateScore(displayXO[0]);
      });
    }
    //2nd column
    if (displayXO[1] == displayXO[4] &&
        displayXO[1] == displayXO[7] &&
        displayXO[1] != '') {
      setState(() {
        resultDeclaration = 'Player ' + displayXO[1] + ' wins';
        matchedIndex.addAll([1, 4, 7]);
        stopTimer();
        _updateScore(displayXO[1]);
      });
    }
    //3rd column
    if (displayXO[2] == displayXO[5] &&
        displayXO[2] == displayXO[8] &&
        displayXO[2] != '') {
      setState(() {
        resultDeclaration = 'Player ' + displayXO[2] + ' wins';
        matchedIndex.addAll([2, 5, 8]);
        stopTimer();
        _updateScore(displayXO[2]);
      });
    }
    //main diagonal
    if (displayXO[0] == displayXO[4] &&
        displayXO[0] == displayXO[8] &&
        displayXO[0] != '') {
      setState(() {
        resultDeclaration = 'Player ' + displayXO[0] + ' wins';
        matchedIndex.addAll([0, 4, 8]);
        stopTimer();
        _updateScore(displayXO[0]);
      });
    }
    //second diagonal
    if (displayXO[6] == displayXO[4] &&
        displayXO[6] == displayXO[2] &&
        displayXO[6] != '') {
      setState(() {
        resultDeclaration = 'Player ' + displayXO[6] + ' wins';
        matchedIndex.addAll([6, 4, 2]);
        stopTimer();
        _updateScore(displayXO[6]);
      });
    }
    if (!winnerFound && filledBoxes == 9) {
      setState(() {
        resultDeclaration = 'Nobody wins';
      });
    }
  }

  void _updateScore(String winner) {
    if (winner == '0') {
      oScore++;
    } else if (winner == 'X') {
      xScore++;
    }
    winnerFound = true;
  }

  void _clearBoard() {
    setState(() {
      for (int i = 0; i < 9; i++) {
        displayXO[i] = '';
      }
      resultDeclaration = '';
      matchedIndex=[];
    });
    filledBoxes = 0;
  }

  Widget _buildTimer() {
    final isRunning = timer == null ? false : timer!.isActive;

    return isRunning
        ? SizedBox(
            height: 100,
            width: 100,
            child: Stack(
              fit: StackFit.expand,
              children: [
                CircularProgressIndicator(
                  value: 1 - seconds / maxSeconds,
                  valueColor: AlwaysStoppedAnimation(Colors.white),
                  strokeWidth: 8,
                  backgroundColor: Colors.orange,
                ),
                Center(
                  child: Text(
                    '$seconds',
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                        fontSize: 50),
                  ),
                )
              ],
            ),
          )
        : ElevatedButton(
            style: ElevatedButton.styleFrom(
                backgroundColor: Colors.white,
                padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10)),
            onPressed: () {
              startTimer();
              _clearBoard();
              attempts++;
            },
            child: Text(
              attempts == 0 ? "Start Game" : "Play Again!",
              style: TextStyle(color: Colors.black, fontSize: 20),
            ));
  }
}
