import 'dart:convert';
import 'package:todo_app/model/todo_model.dart';

import '../utils/api_endpoint.dart';
import 'package:http/http.dart' as http;

class ApiServices{
  static Future<List<TodoModel>> fetchTodo() async {
    final url = ApiEndPoints.allTodos;
    final uri = Uri.parse(url);
    final response = await http.get(uri);
    if (response.statusCode == 200) {
      final json = jsonDecode(response.body) as Map;
      final results = json['items'] as List;
      return results.map((todoJson)=>TodoModel.fromJson(todoJson)).toList();
      // setState(() {
      //   items = results;
      // });
    }else{
      throw Exception('Failed to load todos');
    }
    // setState(() {
    //   isLoading = false;
    // });
  }
}