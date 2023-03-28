import 'dart:convert';
import 'dart:io';
import 'package:crypt/crypt.dart';
import 'Home.dart';
import 'Welcome.dart';

int count = 0;

class Login {
  static var loginUser;
  login() async {
    print("Welcom to the Login page");
    print("--------------------------");
    print("Please enter your details ");
    stdout.write("a. Email address:");
    String? email = stdin.readLineSync();
    if (email != null && email.isEmpty) {
      print("This field is required");
      count++;
    } else if (email != null && email.isNotEmpty) {
      String pattern = r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$';
      RegExp regExp = RegExp(pattern);
      if (!regExp.hasMatch(email)) {
        print("the email is not valid");
        count++;
      }
    }
    if (count == 2) {
      Home g = new Home();
      g.start();
    }
    //............................................
    stdout.write("b. Password:");
    String? password = stdin.readLineSync();
    if (password != null && password.isEmpty) {
      print("This field is required");
      count++;
    } else if (password !=null && password.isNotEmpty) {
      String pattern = r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9]).{6,}$';
      RegExp regExp = RegExp(pattern);
      if (!regExp.hasMatch(password)) {
        print("the password is not valid");
        count++;
      }
    }
    if (count == 2) {
      Home g = new Home();
    }
    //.........................................................
    else if (password!.isNotEmpty && email!.isNotEmpty) {
      String path = './data.json';
      if ((await File(path).existsSync())) {
        String fileContents = await File(path).readAsString();
        List d = json.decode(fileContents);
        final pHashing = Crypt.sha256('$password', salt: 'abcdefghijklmnop');
        for (int i = 0; i < d.length; i++) {
          if ((d[i]['email'] == '$email') &&
              (d[i]['password'] == '$pHashing')) {
            loginUser = d[i]['email'];
            Welcome w = new Welcome();
            w.welcome();
            break;
          }
        }
      }
    }
  }
}
