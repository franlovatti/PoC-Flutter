class Todo {
  String? id;
  String? todoText;
  bool isDone;

  Todo({
    required this.id,
    required this.todoText, 
    this.isDone = false
  });

  static List<Todo> todoList() {
    return [
      Todo(id: '01', todoText: 'Buy groceries', isDone: false),
      Todo(id: '02', todoText: 'Walk the dog', isDone: true),
      Todo(id: '03', todoText: 'Complete Flutter project', isDone: false),
      Todo(id: '04', todoText: 'Read a book', isDone: true),
      Todo(id: '05', todoText: 'Exercise for 30 minutes', isDone: false),
    ];
  }
}