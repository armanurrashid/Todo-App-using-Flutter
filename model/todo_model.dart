class TodoModel{
  final String title;
  final String description;
  String? id;

  TodoModel({
      required this.title,
      required this.description,
      this.id,
});

  factory TodoModel.fromJson(Map<String,dynamic>json){
    return TodoModel(
        title: json['title'],
        description: json['description'],
        id: json['_id'],
    );
  }
}