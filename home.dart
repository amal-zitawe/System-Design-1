import 'dart:io';
import 'Sing up.dart';

void main() {
  home main=new home();
}

class home {
  home() {
    print("Welcom at Home page");
    print("--------------------------");
    print("Choose one by entering its number:");
    List options = ["1.Sign up", "2.Login", "3.Exit"];
    options.forEach((element) {
      print(element);
    });
    String? number = stdin.readLineSync();
    if (number == '1') {
      Sing_up info = new Sing_up();
      info.Sing();
    } else if (number == '2') {
      print("num $number ddddddd");
    } else if (number == '3') {
      print("num $number hhhhh");
    }
  }
}
