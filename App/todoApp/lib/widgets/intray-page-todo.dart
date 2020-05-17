import 'package:flutter/material.dart';

import '../models/global.dart';
import '../models/task.dart';

class IntrayTodo extends StatefulWidget {
  final Task item;
  final Key key;
  IntrayTodo({this.item, this.key});

  @override
  _IntrayTodoState createState() => _IntrayTodoState();
}

class _IntrayTodoState extends State<IntrayTodo> {

  @override
  Widget build(BuildContext context) {
    return Container(        
        margin: EdgeInsets.symmetric(
          vertical: 5,
          horizontal: 10,
        ),
        decoration: BoxDecoration(
          color: redColor,
          borderRadius: BorderRadius.all(
            Radius.circular(10),
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.5),
              blurRadius: 10,
            ),
          ],
        ),
        height: 100,
        child: ListTile(
          key: widget.key,
          leading:
              Icon(widget.item.completed ? Icons.check_circle : Icons.check_circle_outline),
          title: Padding(
            padding: const EdgeInsets.symmetric(vertical: 8.0),
            child: Text(
              '${widget.item.title}',
              style: todoTitleStyle,
            ),
          ),
          trailing: Icon(Icons.drag_handle),
          
          onTap: () {
            setState(() {
              widget.item.completed = !widget.item.completed;
            });
          },
        ));
  }
}
