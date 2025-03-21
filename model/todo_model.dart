class TodoModel{
  final String title;
  final String description;

  TodoModel({
      required this.title,
      required this.description,
});

  factory TodoModel.fromJson(Map<String,dynamic>json){
    return TodoModel(
        title: json['title'],
        description: json['description']
    );
  }
}