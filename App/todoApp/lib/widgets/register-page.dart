import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:todoApp/widgets/my-home-page.dart';

import '../widgets/my-home-page.dart';

const SERVER_IP = 'http://192.168.43.55:3000';
const REGISTER_URL = '$SERVER_IP/api/register';

class RegisterPage extends StatelessWidget {
  final FlutterSecureStorage storage;
  RegisterPage(this.storage);

  final TextEditingController _firstNameController = TextEditingController();
  final TextEditingController _lastNameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  void displayDialog(context, title, text) => showDialog(
        context: context,
        builder: (context) =>
            AlertDialog(title: Text(title), content: Text(text)),
      );

  Future<Map<String, dynamic>> attemptRegister(
    String firstName,
    String lastName,
    String email,
    String password,
  ) async {
    var res = await http.post(REGISTER_URL,
        headers: {
          "Content-Type": "application/json",
        },
        body: jsonEncode({
          "firstName": firstName,
          "lastName": lastName,
          "email": email,
          "password": password,
        }));
    var result = {
      'statusCode': res.statusCode,
      'headers': res.headers,
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
                controller: _firstNameController,
                decoration: InputDecoration(labelText: 'First Name'),
              ),
              TextField(
                controller: _lastNameController,
                decoration: InputDecoration(labelText: 'Last Name'),
              ),
              TextField(
                controller: _emailController,
                decoration: InputDecoration(labelText: 'Email'),
              ),
              TextField(
                controller: _passwordController,
                obscureText: true,
                decoration: InputDecoration(labelText: 'Password'),
              ),
              FlatButton(
                  onPressed: () async {
                    var email = _emailController.text;
                    var password = _passwordController.text;
                    var firstName = _firstNameController.text;
                    var lastName = _lastNameController.text;
                    var res = await attemptRegister(firstName, lastName, email, password);
                    if (res['statusCode'] == 201) {
                      var headers = res['headers'];
                      var jwt = headers['x-auth-token'];
                      if (jwt != null) {
                        await storage.write(key: "jwt", value: jwt);
                        
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => MyHomePage(jwt)));
                      }
                    }
                    else if(res['statusCode'] == 404){
                      displayDialog(
                          context, "Error: ${res['statusCode']}", 'Unable to reach the server.');
                    } else {
                      displayDialog(
                          context, "Error: ${res['statusCode']}", res['msg']);
                    }
                  },
                  child: Text("Register")),
            ],
          ),
        ));
  }
}
