import 'dart:io';
import 'package:todo_app/todo.dart';
import 'package:todo_app/todo_repository.dart';
import 'package:ansicolor/ansicolor.dart';

final AnsiPen greenPen = AnsiPen()..green();
final AnsiPen redPen = AnsiPen()..red();
final AnsiPen bluePen = AnsiPen()..blue();
final AnsiPen yellowPen = AnsiPen()..yellow();

// void main() {
//   print("Hello wolrd");

//   String name = "Nika";
//   String? nam2 = null;

//   var count = 0;
//   var title = "Hello";
//   var x = 5;
//   // x = "dsf";

//   final id;
//   id = 5;
//   const app = "Todo";

//   print("$app $id ${count + 5}");

//   List<String> test = ["язык", "уроки"];

//   Map<String, dynamic> data = {"key" : 13};

//   Set<int> id2 = {1, 2, 3};
// }

void main() {
  print(yellowPen("Консольное приложение TODO"));
  TodoRepository repo = TodoRepository();
  printMenu();
  while (true) {
    stdout.write("> ");
    String? input = stdin.readLineSync();
    if (input == null) {
      continue;
    }
    input = input.trim();
    bool shouldExit = handleCommand(repo, input);
    if (shouldExit) {
      break;
    }
  }
}
