class ToDo{
  String? id;
  String? todoText;
  bool isDone;

  ToDo({
    required this.id,
    required this.todoText,
    this.isDone  = false,
  });

  static List<ToDo> todoList(){
    return [
      ToDo(
        id: '1',
        todoText: 'Buy Milk',
        isDone: false,
      ),
      ToDo(
        id: '2',
        todoText: 'Buy Eggs',
        isDone: true,
      ),
      ToDo(
        id: '3',
        todoText: 'Buy Bread',
        isDone: true,
      ),
    ];
  }

}