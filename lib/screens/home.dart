import 'package:flutter/material.dart';
import 'package:task_app/widgets/todo_item.dart';
import '../constanst/colors.dart';
import '../model/todo.dart';

class Home extends StatefulWidget {
  Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final todoList = Todo.todoList();
  List<Todo> _foundTodo = [];
  final _todoController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _foundTodo = todoList;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: background,
      appBar: _buildAppBar(),
      body: Stack(
        children: [
          Container(
            padding: EdgeInsets.symmetric(
              horizontal: 20,
              vertical: 15
            ),
            child: Column(
              children: [
                searchBox(),
                Expanded(
                  child: ListView(
                    children: [
                      Container(
                        margin: EdgeInsets.only(top: 30, bottom: 20),
                        child: Text('All ToDos', style: TextStyle(fontSize: 20, fontWeight: FontWeight.w500),),
                      ),
                      for (Todo todo in _foundTodo.reversed) 
                        TodoItem(todo: todo,
                        onToDoChange: _handelToDoChange,
                        onDeleteItem: _deleteToDoItem,
                        ),
                    ],
                  ),
                )
              ],
            ),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Row(
              children: [
                Expanded(child: Container(
                  margin: EdgeInsets.only(bottom: 20, left: 20, right: 20),
                  padding: EdgeInsets.symmetric(horizontal: 20, vertical: 5),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    boxShadow: const [BoxShadow(
                      color: gray,
                      blurRadius: 10,
                      spreadRadius: 0,
                      offset: Offset(0, 0),
                    )],
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: TextField(
                    controller: _todoController,
                    decoration: InputDecoration(
                      border: InputBorder.none,
                      hintText: 'Add a new todo',
                      hintStyle: TextStyle(color: gray, fontSize: 16),
                    ),
                  ),
                ),
                ),
                Container(
                  margin: EdgeInsets.only(bottom: 20, right: 20),
                  padding: EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    color: blue,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: IconButton(
                    icon: Icon(Icons.add, color: Colors.white, size: 25),
                    onPressed: () {
                      _addToDoItem(_todoController.text);
                    },
                  ),
                )
              ],
            ),
          )
        ],
      ),
    );
  }

  void _handelToDoChange(Todo todo){
    setState(() {
      todo.isDone = !todo.isDone;
    });
  }

  void _deleteToDoItem(String id){
    setState(() {
      todoList.removeWhere((todo) => todo.id == id);
    });
  }

  void _addToDoItem(String todoText) {
    setState(() {
      todoList.add(Todo(id: DateTime.now().millisecondsSinceEpoch.toString(), todoText: todoText));
    });
    _todoController.clear();
  }

  void _runFilter(String enteredKeyword) {
    List<Todo> results = [];
    if (enteredKeyword.isEmpty) {
      results = todoList;
    } else {
      results = todoList.where((todo) => todo.todoText!.toLowerCase().contains(enteredKeyword.toLowerCase())).toList();
    }
    setState(() {
      _foundTodo = results;
    });
  }

  Container searchBox() {
    return Container(
            padding: EdgeInsets.symmetric(horizontal: 15),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(20),
            ),
            child: TextField(
              onChanged: (value) => _runFilter(value),
              decoration: InputDecoration(
                border: InputBorder.none,
                contentPadding: EdgeInsets.all(0),
                prefixIcon: Icon(Icons.search, color: gray, size: 20),
                prefixIconConstraints: BoxConstraints(
                  minWidth: 25,
                  minHeight: 20,
                ),
                hintText: 'Search',
                hintStyle: TextStyle(color: black, fontSize: 16),
              ),
            ),
          );
  }

  AppBar _buildAppBar() {
    return AppBar(
      backgroundColor: background,
      title: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Icon(
            Icons.menu,
            color: black,
          ),
          Text(
            'To Do App',
            style: TextStyle(color: black, fontSize: 20),
          ),
        ],
      ),
    );
  }
}