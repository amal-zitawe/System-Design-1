import 'dart:io';
import 'dart:convert';
import 'Welcome.dart';
import 'home.dart';
// ignore: unused_import
import 'package:crypt/crypt.dart';

class Sing_up {
  Sing() async {
    int count = 0;
    print("Welcom at Sing Up page");
    print("--------------------------");
    print("Please put your information");
    //..............................................
    stdout.write("a. FullName:");
    String? name = stdin.readLineSync();
    if (name!.isEmpty) {
      print("This field is required");
      count++;
    }
    if (count > 1) {
      home g = new home();
    }
//......................................................
    stdout.write("b. Birthdate (mm/dd/yyyy):");
    String? birthdate = stdin.readLineSync();
    if (birthdate!.isEmpty) {
      print("This field is required");
      count++;
    }
    if (count > 1) {
      home g = new home();
    } else if (birthdate.isNotEmpty) {
      String pattern =
          r'^(0[1-9]|1[012])[- /.](0[1-9]|[12][0-9]|3[01])[- /.](19|20)\d\d$';
      RegExp regExp = RegExp(pattern);
      if (!regExp.hasMatch(birthdate)) {
        print("the birthdate is not valid ");
        count++;
      }
    }
//.........................................................
    stdout.write("c. Email address:");
    String? email = stdin.readLineSync();
    if (email!.isNotEmpty) {
      String path =
          'C:/Users/s1181/Desktop/trainingASAL/SystemDesign(1)/data.json';
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
    if (email.isEmpty) {
      print("This field is required");
      count++;
    }
    if (count > 1) {
      home g = new home();
    } else if (email.isNotEmpty) {
      String pattern = r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$';
      RegExp regExp = RegExp(pattern);
      if (!regExp.hasMatch(email)) {
        print("the email is not valid");
        count++;
      }
    }
//...............................................................
    stdout.write("d. Password:");
    String? password = stdin.readLineSync();
    if (password!.isEmpty) {
      print("This field is required");
      count++;
    }
    if (count > 1) {
      home g = new home();
    } else if (password.isNotEmpty) {
      String pattern = r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9]).{6,}$';
      RegExp regExp = RegExp(pattern);
      if (!regExp.hasMatch(password)) {
        print("the password is not strong");
        count++;
      }
    }
    //hasing password
    final pHashing = Crypt.sha256('$password');
    //....................................................
    // Read the existing data from the file (if any)
    List<Map<String, dynamic>> data = [];
    String path =
        'C:/Users/s1181/Desktop/trainingASAL/SystemDesign(1)/data.json';
    String fileContents = await File(path).readAsString();
    List<Map<String, dynamic>>? v = (jsonDecode(fileContents) as List)
        .map((e) => e as Map<String, dynamic>)
        .toList();
    data = v;
    //create map
    Map<String, dynamic> newData = {
      'fullname': '$name',
      'email': '$email',
      'password': '$pHashing',
    };
    // Append the data object to the list
    data.add(newData);
    // Convert the Map object to a JSON string
    var jsonString = jsonEncode(data);
    // Create a new file and write the JSON string to the file
    File file = File('data.json');
    file.writeAsStringSync(jsonString);
    print('Successfully Registered');
    Welcome();
  }
}
