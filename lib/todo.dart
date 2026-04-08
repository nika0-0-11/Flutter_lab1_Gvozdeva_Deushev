import 'dart:io';

import 'package:todo_app/todo_repository.dart';
import 'package:ansicolor/ansicolor.dart';

final AnsiPen greenPen = AnsiPen()..green();
final AnsiPen redPen = AnsiPen()..red();
final AnsiPen bluePen = AnsiPen()..blue();
final AnsiPen yellowPen = AnsiPen()..yellow();

class Todo {
  final int id;
  String title;
  bool isDone;
  static int _counter = 0;

  Todo(this.title) : id = ++_counter, isDone = false;

  @override
  String toString() {
    String status;

    if (isDone) {
      status = "[x]";
    } else {
      status = "[ ]";
    }

    return "$status $id. $title";
  }
}

void printMenu() {
  print("Консольное приложение TODO");
  print("Команды: ");
  print(" add <текст>       - добавить задачу");
  print(" list              - показать список");
  print(" done <id>         - отметить выполненной");
  print(" delete <id>       - удалить задачу");
  print(" exit              - выход");
  print("");
}

void addCommand(TodoRepository repo, String input) {
  if (input.length <= 4) {
    print("Ошибка: введите текст задачи");
    return;
  }
  String title = input.substring(4).trim();
  repo.add(title);
  print("Задача добавлена");
}

void listCommand(TodoRepository repo) {
  List<Todo> todos = repo.getAll();
  if (todos.isEmpty) {
    print("Список задач пуст");
    return;
  }
  for (var todo in todos) {
    print(todo);
  }
}

void doneCommand(TodoRepository repo, List<String> parts) {
  if (parts.length < 2) {
    print("Ошибка: укажите id");
    return;
  }
  int id = int.parse(parts[1]);
  repo.complete(id);
  print("Задача отмечена выполненной");
}

void deleteCommand(TodoRepository repo, List<String> parts) {
  if (parts.length < 2) {
    print("Ошибка: укажите id");
  }
  int id = int.parse(parts[1]);
  repo.delete(id);
  print("Задача удалена");
}

bool handleCommand(TodoRepository repo, String input) {
  List<String> parts = input.split(" ");
  String command = parts[0].toLowerCase();
  try {
    switch (command) {
      case "add":
        addCommand(repo, input);
        break;
      case "list":
        listCommand(repo);
        break;
      case "done":
        doneCommand(repo, parts);
        break;
      case "delete":
        deleteCommand(repo, parts);
        break;
      case "exit":
        print("Выход из программы");
        return true;
      default:
        print("Неизвестная команда");
    }
  } catch (e) {
    print(redPen("Ошибка: $e"));
  }
  return false;
}
