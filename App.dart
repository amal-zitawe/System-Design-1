import 'dart:io';
import 'Home.dart';
import 'SignUp.dart';

// Coordinator
class App {
  // late Welcome welcome = Welcome();
  // late Login login = Login();
  late SignUp signUp = new SignUp();
  late Home home = new Home();

  void runHome(UserOptions x) {
    switch (x) {
      // exit app
      case UserOptions.exit:
        exit(0);
      // run signUp
      case UserOptions.signUp:
        break;
      // run login
      case UserOptions.login:
        break;
    }
  }

  void runSignUp(UserOptions x) {
    switch (x) {
      //run home
      case UserOptions.home:
        home.start();
        break;
      //run welcome
      case UserOptions.welcome:
        break;
    }
  }

  void runLogin(UserOptions x) {
    switch (x) {
      case UserOptions.home:
        {
          home.start();
        }
        break;
      case UserOptions.welcome:
        break;
    }
  }

  void runWelcome(UserOptions x) {
    switch (x) {
      case UserOptions.home:
        {
          home.start();
        }
        break;

      case UserOptions.exit:
        exit(0);
    }
  }
}

enum UserOptions { welcome, login, signUp, home, exit }
