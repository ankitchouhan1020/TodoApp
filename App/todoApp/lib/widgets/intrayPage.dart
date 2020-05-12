import 'package:flutter/material.dart';

import '../widgets/intray_page_todo.dart';
import '../models/global.dart';
import '../models/task.dart';

class IntrayPage extends StatefulWidget {
  final List<Task> todoList = () {
    List<Task> list = [];
    for (var i = 0; i < 10; i++) {
      var task =
          Task(title: 'Shopping', completed: false, taskId: i.toString());
      list.add(task);
    }
    return list;
  }();

  @override
  _IntrayPageState createState() => _IntrayPageState();
}

class _IntrayPageState extends State<IntrayPage> {
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
            widget.todoList.length,
            (index) {
              return IntrayTodo(
                item: widget.todoList[index],
                key: Key(widget.todoList[index].taskId),
              );
            },
          ),
          onReorder: (int oldIndex, int newIndex) {
            setState(
              () {
                if (newIndex > oldIndex) {
                  newIndex -= 1;
                }
                final Task item = widget.todoList.removeAt(oldIndex);
                widget.todoList.insert(newIndex, item);
              },
            );
          },
        ),
      ),
    );
  }
}
