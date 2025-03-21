import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:todo_app/utils/api_endpoint.dart';

class AddTodoPage extends StatefulWidget {
  const AddTodoPage({super.key});

  @override
  State<AddTodoPage> createState() => _AddTodoPageState();
}

class _AddTodoPageState extends State<AddTodoPage> {
  TextEditingController titleController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Add Todo"),
        centerTitle: true,
      ),
      body: ListView(
        padding: EdgeInsets.all(10),
        children: [
          TextField(
            controller: titleController,
            decoration: InputDecoration(hintText: "Title"),
          ),
          SizedBox(height: 20),
          TextField(
            controller: descriptionController,
            decoration: InputDecoration(hintText: "Description"),
            keyboardType: TextInputType.multiline,
            minLines: 5,
            maxLines: 8,
          ),
          SizedBox(height: 20),
          ElevatedButton(
              onPressed: submitData,
              style: ElevatedButton.styleFrom(backgroundColor: Colors.blue),
              child: Text("Submit"))
        ],
      ),
    );
  }

  void submitData() async {
    final title = titleController.text;
    final description = descriptionController.text;
    final body = {
      "title": title,
      "description": description,
      "is_completed": false
    };
    final url = ApiEndPoints.apiUrl;
    final uri = Uri.parse(url);
    final response = await http.post(
      uri,
      body: jsonEncode(body),
      headers: {'Content-Type': 'application/json'},
    );
    if (response.statusCode == 201) {
      titleController.text = '';
      descriptionController.text = '';
      showSuccessMessage("Post has been created successfully");
    } else {
      showErrorMessage("There is an Error!");
    }
  }

  void showSuccessMessage(String message) {
    final snackBar = SnackBar(
      content: Text(
        message,
        textAlign: TextAlign.center ,
        style: TextStyle(color: Colors.white,),
      ),
      backgroundColor: Colors.green,
    );
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }

  void showErrorMessage(String message) {
    final snackBar = SnackBar(
      content:  Text(
          message,
          textAlign: TextAlign.center ,
          style: TextStyle(color: Colors.black),
        ),
      backgroundColor: Colors.red,
    );
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }
}
