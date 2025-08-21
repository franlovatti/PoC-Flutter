import 'package:flutter/material.dart';
import 'package:task_app/constanst/colors.dart';
import 'package:task_app/model/todo.dart';

class TodoItem extends StatelessWidget{
  final Todo todo;
  final onToDoChange;
  final onDeleteItem;

  const TodoItem({Key? key, required this.todo, required this.onToDoChange, required this.onDeleteItem}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: 20),
      child: ListTile(
        onTap: () => {
          print('Todo item tapped'),
          onToDoChange(todo),
        },
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
        ),
        contentPadding: EdgeInsets.symmetric(horizontal: 20, vertical: 5),
        tileColor: Colors.white,
        leading: Icon(
          todo.isDone ? Icons.check_box : Icons.check_box_outline_blank,
          color: blue,
        ),
        title: Text(
          todo.todoText!,
          style: TextStyle(
            fontSize: 16,
            color: black,
            decoration: todo.isDone ? TextDecoration.lineThrough : null,
          ),
        ),
        trailing: Container(
          padding: EdgeInsets.all(0),
          //margin: EdgeInsets.symmetric(vertical: 12),
          height: 35,
          width: 35,
          decoration: BoxDecoration(
            color: red,
            borderRadius: BorderRadius.circular(5),
          ),
          child: IconButton(
            onPressed: () {
              print('Delete Todo');
              onDeleteItem(todo.id);
            },
            icon: Icon(
              Icons.delete, 
              size: 15,
              color: Colors.white,
              ),
          ),
        ),
      ),
    );
  }
}
