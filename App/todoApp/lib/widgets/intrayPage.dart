import 'package:flutter/material.dart';
import 'dart:convert' as convert;
import 'package:http/http.dart' as http;
import 'package:jaguar_jwt/jaguar_jwt.dart';

import '../widgets/intray_page_todo.dart';
import '../models/global.dart';
import '../models/task.dart';

const SERVER_IP = 'http://192.168.43.55:3000/api';

class IntrayPage extends StatefulWidget {
  final String jwt;
  final Map<String, dynamic> payload;
  final List<Task> _taskList = [];

  IntrayPage(this.jwt, this.payload);

  factory IntrayPage.fromBase64(String jwt) => IntrayPage(
        jwt,
        convert.jsonDecode(B64urlEncRfc7515.decodeUtf8(jwt.split('.')[1])),
      );

  @override
  _IntrayPageState createState() => _IntrayPageState();
}

class _IntrayPageState extends State<IntrayPage> {
  fetchTask(final String userId) async {
    final _url = '$SERVER_IP/task/$userId';
    final response = await http.get(
      _url,
      headers: {"Authorization": widget.jwt},
    );
    if (response.statusCode == 200) {
      var jsonResponse = convert.jsonDecode(response.body);
      setState(() {
        final int len = jsonResponse['len'];
        jsonResponse = jsonResponse['tasks'];
        for (int i = 0; i < len; i++) {
          widget._taskList.add(Task(
            taskId: jsonResponse[i]['_id'].toString(),
            title: jsonResponse[i]['title'].toString(),
            completed:
                ((jsonResponse[i]['completed']) == 'false' ? false : true),
            deadline: DateTime.parse(jsonResponse[i]['deadline']),
          ));
        }
      });
    } else {
      print('A network error occurred');
    }
  }

  @override
  void initState() {
    super.initState();
    fetchTask(widget.payload['_id']);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: darkGreyColor,
      child: Theme(
        data: ThemeData(
          canvasColor: Colors.transparent,
        ),
        child: ReorderableListView(
          padding: EdgeInsets.only(top: 300),
          children: List.generate(
            widget._taskList.length,
            (index) {
              return IntrayTodo(
                item: widget._taskList[index],
                key: Key(widget._taskList[index].taskId),
              );
            },
          ),
          onReorder: (int oldIndex, int newIndex) {
            setState(
              () {
                if (newIndex > oldIndex) {
                  newIndex -= 1;
                }
                final Task item = widget._taskList.removeAt(oldIndex);
                widget._taskList.insert(newIndex, item);
              },
            );
          },
        ),
      ),
    );
  }
}
