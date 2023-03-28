import 'dart:convert';
import 'dart:io';
import 'package:intl/intl.dart';
import 'Home.dart';
import 'Login.dart';
import 'SignUp.dart';

class Welcome {
  welcome() async {
    var user = Login.loginUser;
    var user2 = SingUp.loginUser;
    print("Welcome Page");
    print('.....................................');
    final datenow = DateTime.now();
    String path = './data.json';
    if ((await File(path).existsSync())) {
      String fileContents = await File(path).readAsString();
      List d = json.decode(fileContents);
      for (int i = 0; i < d.length; i++) {
        if (user == d[i]['email'] || user2 == d[i]['email']) {
          String val = d[i]['birthday'];
          final datenow2 = DateTime.parse(val);

          var currentDateTime =
              DateTime(datenow.year, datenow2.month, datenow2.day);
          var currentDate = DateFormat('yyyy-MM-dd').format(currentDateTime);
          final datenow22 = DateTime.parse(currentDate);

          final difference = datenow22.difference(datenow).inDays;
          if (difference > 0) {
            print('Your next birthday after $difference days');
          } else if (difference < 0) {
            final difference2 = 365 - (difference.abs());
            print('Your next birthday after $difference2 days');
          } else if (difference == 0) {
            String Name = d[i]['fullname'];
            print('happy birthday $Name ');
          }
        }
      }
      //7 day
      for (int k = 1; k < 8; k++) {
        final sevenDaysFromNow = datenow.add(Duration(days: k));
        String currentDate2 = DateFormat('MM-dd-yyyy').format(sevenDaysFromNow);
        final splitted3 = currentDate2.split('-');
        for (int i = 0; i < d.length; i++) {
          String val = d[i]['birthday'];
          //................
          final datenow2 = DateTime.parse(val);
          var currentDateTime =
              DateTime(datenow.year, datenow2.month, datenow2.day);
          var currentDate = DateFormat('yyyy-MM-dd').format(currentDateTime);
          //..............
          final splitted4 = val.split('-');
          if ((splitted3[0] == splitted4[1] && splitted3[1] == splitted4[2])) {
            String Name = d[i]['fullname'];
            print('your frinde $Name birthday on $currentDate ');
          }
        }
      }
    }
    print('.....................................');
    List options = ["1. Logout", "2.Exit "];
    options.forEach((element) {
      print(element);
    });
    String? number = stdin.readLineSync();
    if (number == '2') {
      exit(0);
    } else if (number == '1') {
      Home m = new Home();
      m.start();
    } else if (!(number == '1' || number == '2')) {
      print('the input is incorrect');
      stdin.readLineSync();
    }
  }
}
