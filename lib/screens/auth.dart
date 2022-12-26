import 'package:flutter/material.dart';
import 'package:livionweb/screens/testacccees.dart';
import '../firebase/auth.dart';

class Auth extends StatefulWidget {
  const Auth({Key? key}) : super(key: key);
  static const route = "/auth";

  @override
  State<Auth> createState() => _AuthState();
}

class _AuthState extends State<Auth> {
  TextEditingController mailReg = TextEditingController();
  TextEditingController passReg = TextEditingController();
  TextEditingController mailLog = TextEditingController();
  TextEditingController passLog = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Authorization"),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              width: 500,
              //height: 500,
              color: Colors.pink.withOpacity(0.2),
              child: Column(
                children: [
                  Text("Регистрация"),
                  TextField(
                    controller: mailReg,
                  ), //email registration
                  TextField(
                    controller: passReg,
                  ), // email password
                  ElevatedButton.icon(
                      onPressed: () async {
                        String e = await auth(mailReg.text, passReg.text);
                        switch (e) {
                          case "email-already-in-use":
                            print("Мыло уже используется");
                            break;
                          case "invalid-email":
                            print("неправильное мыло");
                            break;
                          case "operation-not-allowed":
                            print("недоступно");
                            break;
                          case "weak-password":
                            print("слабый пароль");
                            break;
                          default:
                            Navigator.pushNamed(context, Access.route);
                        }
                      },
                      icon: Icon(Icons.app_registration),
                      label: Text("Регистрация"))
                ],
              ),
            ),
            Container(
              margin: EdgeInsets.only(top: 50),
              width: 500,
              //height: 500,
              color: Colors.pink.withOpacity(0.2),
              child: Column(
                children: [
                  Text("Вход"),
                  TextField(
                    controller: mailLog,
                  ), //email registration
                  TextField(
                    controller: passLog,
                  ), // email password
                  ElevatedButton.icon(
                      onPressed: () async {
                        String e = await signin(mailLog.text, passLog.text);
                        switch (e) {
                          case "invalid-email":
                            print("неправильное мыло");
                            break;
                          case "user-disabled":
                            print("пользователь отключен");
                            break;
                          case "user-not-found":
                            print("пользователь не найден");
                            break;
                          case "wrong-password":
                            print("неправильный пароль");
                            break;
                          default:
                            Navigator.pushNamed(context, Access.route);
                        }
                      },
                      icon: Icon(Icons.app_registration),
                      label: Text("Вход"))
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
