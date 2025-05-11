import 'dart:io';

List<String> board = List.generate(9, (index) => (index + 1).toString());
String currentPlayer = 'X';

void main() {
  print('Welcome, (Tic-Tac-Toe Game)!');
  playGame();
}

void playGame() {
  bool gameEnded = false;

  while (!gameEnded) {
    printBoard();
    playerMove();
    gameEnded = checkWinner() || checkDraw();

    if (!gameEnded) {
      switchPlayer();
    }
  }

  print('do you want to play again? (y/n): ');
  String? again = stdin.readLineSync();
  if (again != null && again.toLowerCase() == 'y') {
    resetGame();
    playGame();
  } else {
    print('Thanks for play!');
  }
}

void printBoard() {
  print('-------------');
  for (int i = 0; i < 9; i += 3) {
    print('| ${board[i]} | ${board[i + 1]} | ${board[i + 2]} |');
    print('-------------');
  }
}

void playerMove() {
  int? move;
  bool valid = false;

  while (!valid) {
    print('Player $currentPlayer, choose number from 1-9: ');
    String? input = stdin.readLineSync();

    if (input != null) {
      move = int.tryParse(input);
      if (move != null && move >= 1 && move <= 9 && board[move - 1] != 'X' && board[move - 1] != 'O') {
        board[move - 1] = currentPlayer;
        valid = true;
      } else {
        print('Invalid move, please try again.');
      }
    }
  }
}

bool checkWinner() {
  List<List<int>> winPositions = [
    [0, 1, 2],
    [3, 4, 5],
    [6, 7, 8],
    [0, 3, 6],
    [1, 4, 7],
    [2, 5, 8],
    [0, 4, 8],
    [2, 4, 6],
  ];

  for (var pos in winPositions) {
    if (board[pos[0]] == currentPlayer &&
        board[pos[1]] == currentPlayer &&
        board[pos[2]] == currentPlayer) {
      printBoard();
      print('Player $currentPlayer Win!');
      return true;
    }
  }

  return false;
}

bool checkDraw() {
  if (board.every((cell) => cell == 'X' || cell == 'O')) {
    printBoard();
    print('Game over, no winner.');
    return true;
  }
  return false;
}

void switchPlayer() {
  currentPlayer = (currentPlayer == 'X') ? 'O' : 'X';
}

void resetGame() {
  board = List.generate(9, (index) => (index + 1).toString());
  currentPlayer = 'X';
}
