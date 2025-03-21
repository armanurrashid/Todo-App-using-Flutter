import 'package:flutter/material.dart';
import 'package:todo_app/services/api_services.dart';
import 'package:todo_app/model/todo_model.dart';
import 'add_page.dart';

class TodoListPage extends StatefulWidget {
  const TodoListPage({super.key});

  @override
  State<TodoListPage> createState() => _TodoListPageState();
}

class _TodoListPageState extends State<TodoListPage> {
  late Future<List<TodoModel>> todoList;

  @override
  void initState() {
    super.initState();
    todoList = ApiServices.fetchTodo();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Todo List"),
        centerTitle: true,
      ),
      body: FutureBuilder<List<TodoModel>>(
        future: todoList,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text("Error: ${snapshot.error}"));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return Center(child: Text("No Todos Available"));
          } else {
            return RefreshIndicator(
              onRefresh: () async {
                setState(() {
                  todoList = ApiServices.fetchTodo(); // Refresh data
                });
              },
              child: Scrollbar(
                thumbVisibility: true,
                trackVisibility: true,
                thickness: 15,
                radius: Radius.circular(20),
                interactive: true,
                child: ListView.builder(
                  itemCount: snapshot.data!.length,
                  itemBuilder: (context, index) {
                    final item = snapshot.data![index];
                    return ListTile(
                      leading: CircleAvatar(child: Text('${index + 1}')),
                      title: Text(item.title),
                      subtitle: Text(item.description),
                    );
                  },
                ),
              ),
            );
          }
        },
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => AddTodoPage(),
            ),
          );
        },
        label: Text("Add Todo"),
      ),
    );
  }
}
