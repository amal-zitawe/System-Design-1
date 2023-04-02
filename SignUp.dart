import 'dart:io';
import 'dart:convert';
import 'package:crypt/crypt.dart';
import 'App.dart';

class SignUp {
  static var loginUser;
  Sing() async {
    int count = 0;
    print("Welcom to Sing Up page");
    print("--------------------------");
    print("Please put your information");
    //..............................................
    stdout.write("a. FullName:");
    String? name = stdin.readLineSync();
    if (name != null && name.isEmpty) {
      print("This field is required");
      stdout.write("a. FullName (once again):");
      String? nameagain = stdin.readLineSync();
      name = nameagain;
      if (nameagain != null && nameagain.isEmpty) {
        print("This field is required");
        count++;
      }
    }
    if (count > 1) {
      App().runSignUp(UserOptions.home);
    }
//......................................................
    stdout.write("b. Birthdate (YYYY-MM-DD):");
    String? birthdate = stdin.readLineSync();
    if (birthdate != null && birthdate.isEmpty) {
      print("This field is required");
      stdout.write("b. Birthdate (once again):");
      String? birthdateagain = stdin.readLineSync();
      birthdate = birthdateagain;
      if (birthdateagain != null && birthdateagain.isEmpty) {
        print("This field is required");
        count++;
      }
    }
    if (count > 1) {
      App().runSignUp(UserOptions.home);
    } else if (birthdate != null && birthdate.isNotEmpty) {
      String pattern = r'^([1-2]\d{3})\-([0-1][1-9])\-([0-3][0-9])$';
      RegExp regExp = RegExp(pattern);
      if (!regExp.hasMatch(birthdate)) {
        print("the birthdate is not valid ");
        count++;
      }
    }
//.........................................................
    stdout.write("c. Email address:");
    String? email = stdin.readLineSync();
    if (email != null && email.isNotEmpty) {
      String path = './data.json';

      String pattern = r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$';
      RegExp regExp = RegExp(pattern);
      if (!regExp.hasMatch(email)) {
        print("the email is not valid");
        count++;
      }

      if ((await File(path).existsSync())) {
        String fileContents = await File(path).readAsString();
        List d = json.decode(fileContents);
        for (int i = 0; i < d.length; i++) {
          if (d[i]['email'] == email) {
            count++;
            print("This email already exists, enter another email");
            break;
          }
        }
      }
    }
    if (email != null && email.isEmpty) {
      print("This field is required");
      stdout.write("c. email (once again):");
      String? emailagain = stdin.readLineSync();
      birthdate = emailagain;
      if (emailagain != null && emailagain.isEmpty) {
        print("This field is required");
        count++;
      }
    }
    if (count > 1) {
      App().runSignUp(UserOptions.home);
    }
//...............................................................
    stdout.write("d. Password:");
    String? password = stdin.readLineSync();
    if (password != null && password.isEmpty) {
      print("This field is required");
      stdout.write("d. Password (once again):");
      String? passagain = stdin.readLineSync();
      birthdate = passagain;
      if (passagain != null && passagain.isEmpty) {
        print("This field is required");
        count++;
      }
    }
    if (count > 1) {
      App().runSignUp(UserOptions.home);
    } else if (password != null && password.isNotEmpty) {
      String pattern = r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9]).{6,}$';
      RegExp regExp = RegExp(pattern);
      if (!regExp.hasMatch(password)) {
        print("the password is not strong");
        count++;
      }
    }
    //hasing password
    final pHashing = Crypt.sha256('$password', salt: 'abcdefghijklmnop');
    //....................................................
    // Read the existing data from the file (if any)
    List<Map<String, dynamic>> data = [];
    String path = './data.json';
    String fileContents = await File(path).readAsString();
    List<Map<String, dynamic>>? v = (jsonDecode(fileContents) as List)
        .map((e) => e as Map<String, dynamic>)
        .toList();
    data = v;
    //create map
    Map<String, dynamic> newData = {
      'fullname': '$name',
      'email': '$email',
      'birthday': '$birthdate',
      'password': '$pHashing',
    };
    // Append the data object to the list
    data.add(newData);
    // Convert the Map object to a JSON string
    var jsonString = jsonEncode(data);
    // Create a new file and write the JSON string to the file
    File file = File('data.json');
    file.writeAsStringSync(jsonString);
    loginUser = email;
    print('Successfully Registered');
    App().runSignUp(UserOptions.welcome);
  }
}
