import 'package:todo_app/utils/config.dart';

class ApiEndPoints{
  static const String apiUrl = '${AppConfig.base_url}/v1/todos';
  static const String allTodos = '${apiUrl}?page=1&limit=20';
}