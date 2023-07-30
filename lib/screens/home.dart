import 'package:flutter/material.dart';
import 'package:notesapp/constants/colors.dart';
import 'package:notesapp/widgets/todo_item.dart';

import '../model/todo.dart';

class Home extends StatefulWidget {
  Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();

}
class _HomeState extends State<Home>{
  final todoList = ToDo.todoList();
  List<ToDo> _foundToDos = [];
  final _todoController = TextEditingController();


  @override
  void initState() {
    super.initState();
    _foundToDos = todoList;
  }

  @override
  Widget build(BuildContext context){
    return Scaffold(
      backgroundColor: tdBGColor,
      appBar:_buildAppBar(),
      body: Stack(
        children: [
          Container(
              padding: const EdgeInsets.symmetric(horizontal: 20,vertical: 15),
              child: Column(
                children: [
                  searchBox(),
                  Expanded(
                      child: ListView(
                        children: [
                          Container(
                            margin: const EdgeInsets.symmetric(vertical: 30),
                            child: const Text(
                              'All Todos',
                              style: TextStyle(
                                  color: tdBlack,
                                  fontSize: 30,
                                  fontWeight: FontWeight.w500
                              ),
                            ),
                          ),

                          for (ToDo todo in _foundToDos.reversed)
                            TodoItem(
                              todo: todo,
                              onToDoChanged: _handleToDoChange,
                              onDeleteItem: _handleDeleteItem,
                            ),

                        ],
                      )

                  )

                ],
              )
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Row(children: [
              Expanded(child: Container(
                margin: const EdgeInsets.symmetric(horizontal: 20,vertical: 20),
                height: 50,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(10),
                  boxShadow: const [
                    BoxShadow(
                      color: Colors.black12,
                      offset: Offset(0.0, 0.0),
                      blurRadius: 10,
                      spreadRadius: 0.0,
                    )],

                ),
                child:  Center(
                  child: TextField(
                    controller: _todoController,
                    decoration: const InputDecoration(
                      contentPadding: EdgeInsets.symmetric(vertical: 15),
                      hintText: 'Add Todo',
                      border: InputBorder.none,
                      prefixIcon: Icon(Icons.add, color: Colors.white),
                      prefixIconConstraints: BoxConstraints(maxHeight: 20, minWidth:25 ),
                    ),
                  ),
                ),
              )
              ),
              Container(
                margin: const EdgeInsets.only(bottom: 10, right: 20),
                child: ElevatedButton(
                  onPressed: (){
                    _handleAddToDo(_todoController.text);
                  },
                  style: ElevatedButton.styleFrom(
                    shape: const CircleBorder(),
                    padding: const EdgeInsets.all(10),
                    minimumSize: Size(60, 60),
                    primary: tdBlue,
                    elevation: 10,
                  ),
                  child: const Icon(Icons.add, color: Colors.white),
                )
              )
            ],
            )
          )
        ],
      ),

    );
  }
  void _handleToDoChange(ToDo todo){
    setState(() {
      todo.isDone = !todo.isDone;
    });
  }

  void _handleDeleteItem(String id){
    setState(() {
      todoList.removeWhere((item) => item.id == id);
    });
  }

  void _handleAddToDo(String toDo){
    setState(() {
      todoList.add(ToDo(
        id: DateTime.now().toString(),
        todoText: toDo,
        isDone: false,
      ));
    });
    _todoController.clear();
  }

  void _handleSearch(String value){
    setState(() {
      if(value.isEmpty){
        _foundToDos = todoList;
      }else{
        _foundToDos = todoList.where((todo) => todo.todoText!.toLowerCase().contains(value.toLowerCase())).toList();
      }
    });

  }
  Container searchBox() {
    return Container(
            padding: const EdgeInsets.symmetric(horizontal: 15),
            decoration:  BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(20)
            ),
            child:  TextField(
              onChanged: (value) => _handleSearch(value),
              decoration: const InputDecoration(
                contentPadding: EdgeInsets.symmetric(vertical: 15),
                hintText: 'Search',
                border: InputBorder.none,
                prefixIcon: Icon(Icons.search, color: tdBlack),
                prefixIconConstraints: BoxConstraints(maxHeight: 20, minWidth:25 ),
              ),
            ),

          );
  }

  AppBar _buildAppBar() {
    return AppBar(
      backgroundColor: tdBGColor,
      elevation: 0,
      title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
        const Icon(Icons.menu,
            color: tdBlack,
            size: 30),
        SizedBox(
          height: 30,
          width: 30,
          child: ClipRRect(
            borderRadius: BorderRadius.circular(20),
            child: Image.asset('assets/images/sammy.png')
          ),
        )
      ]),
    );
  }

}