import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'add_page.dart';

class TodoListPage extends StatefulWidget {
  const TodoListPage({super.key});

  @override
  State<TodoListPage> createState() => _TodoListPageState();
}

class _TodoListPageState extends State<TodoListPage> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Todo App"),
        centerTitle: true,
        // backgroundColor: Colors.black12,
      ),
      floatingActionButton: FloatingActionButton.extended(onPressed: () {
        Navigator.push(context, MaterialPageRoute(builder: (context) => AddTodoPage(),));
      }, label: Text("Add Todo")),
    );
  }


}
