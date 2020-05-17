import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

import '../widgets/my-home-page.dart';
import '../widgets/register-page.dart';

const SERVER_IP = 'http://192.168.43.55:3000';
const SIGNIN_URL = '$SERVER_IP/api/signin';

class LoginPage extends StatelessWidget {
  final FlutterSecureStorage storage;
  LoginPage(this.storage);

  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  void displayDialog(context, title, text) => showDialog(
        context: context,
        builder: (context) =>
            AlertDialog(title: Text(title), content: Text(text)),
      );

  Future<Map<String, Object>> attemptLogIn(
    String email,
    String password,
  ) async {
    var res = await http.post(SIGNIN_URL,
        headers: {
          "Content-Type": "application/json",
        },
        body: jsonEncode({
          "email": email,
          "password": password,
        }));
    var result = {
      'statusCode': res.statusCode,
      'msg': res.body,
    };
    print(result);
    return result;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Log In"),
        ),
        body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: <Widget>[
              TextField(
                controller: _emailController,
                decoration: InputDecoration(labelText: 'email'),
              ),
              TextField(
                controller: _passwordController,
                obscureText: true,
                decoration: InputDecoration(labelText: 'Password'),
              ),
              RaisedButton(
                onPressed: () async {
                  var email = _emailController.text;
                  var password = _passwordController.text;
                  var res = await attemptLogIn(email, password);
                  if (res['statusCode'] == 200) {
                    var jwt = res['msg'];
                    if (jwt != null) {
                      storage.write(key: "jwt", value: jwt);
                      Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                              builder: (context) => MyHomePage(jwt)));
                    }
                  } else {
                    displayDialog(
                        context, "Error: ${res['statusCode']}", res['msg']);
                  }
                },
                child: Text("Log In"),
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 20),
                child: Row(
                  children: <Widget>[
                    Text('If you are not registered, '),
                    FlatButton(
                      child: Text('Register Here'),
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => RegisterPage(storage),
                          ),
                        );
                      },
                    )
                  ],
                ),
              )
            ],
          ),
        ));
  }
}
