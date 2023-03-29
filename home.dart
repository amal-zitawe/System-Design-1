import 'dart:io';
import 'App.dart';

void main() {
  Home().start();
}
class Home {
  start() {
    print("Welcome to the Home page");
    print("--------------------------");
    print("Choose one by entering its number:");
    List options = ["1.Sign up", "2.Login", "3.Exit"];
    options.forEach((element) {
      print(element);
    });
    String? number = stdin.readLineSync();
    if (number == '1') {
      App().runHome(UserOptions.signUp);
    } else if (number == '2') {
      App().runHome(UserOptions.login);
    } else if (number == '3') {
      exit(0);
    } else if (!(number == 1 || number == 2 || number == 3)) {
      print('the input is incorrect');
    }
  }
}
