import 'dart:convert';
import 'dart:io';
// ignore: unused_import
import 'package:crypt/crypt.dart';
import 'home.dart';

int count = 0;

class Login {
  login() async {
    print("Welcom at Login page");
    print("--------------------------");
    print("Please enter your details ");
    stdout.write("a. Email address:");
    String? email = stdin.readLineSync();
    if (email!.isEmpty) {
      print("This field is required");
      count++;
    } else if (email.isNotEmpty) {
      String pattern = r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$';
      RegExp regExp = RegExp(pattern);
      if (!regExp.hasMatch(email)) {
        print("the email is not valid");
        count++;
      }
    }
    if (count == 2) {
      home g = new home();
    }
    //............................................
    stdout.write("b. Password:");
    String? password = stdin.readLineSync();
    if (password!.isEmpty) {
      print("This field is required");
      count++;
    } else if (password.isNotEmpty) {
      String pattern = r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9]).{6,}$';
      RegExp regExp = RegExp(pattern);
      if (!regExp.hasMatch(password)) {
        print("the password is not valid");
        count++;
      }
    }
    if (count == 2) {
      home g = new home();
    }
    //.........................................................
    else if (password.isNotEmpty && email.isNotEmpty) {
      String path =
          'C:/Users/s1181/Desktop/trainingASAL/SystemDesign(1)/data.json';
      if ((await File(path).existsSync())) {
        String fileContents = await File(path).readAsString();
        List d = json.decode(fileContents);
        final pHashing = Crypt.sha256('$password', salt: 'abcdefghijklmnop');
        // print(pHashing);
        for (int i = 0; i < d.length; i++) {
          if ((d[i]['email'] == '$email') &&
              (d[i]['password'] == '$pHashing')) {
            //TODO
            // Welcome w = new Welcome();
            // w.welcome();
            break;
          }
        }
      }
    }
  }
}
