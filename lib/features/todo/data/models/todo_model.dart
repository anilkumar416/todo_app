import 'package:todo_app/features/todo/domain/entities/todo.dart';

class TodoModel extends Todo {
  TodoModel(
      {required super.id, required super.title, required super.isCompleted});

  factory TodoModel.fromJson(Map<String, dynamic> json) {
    return TodoModel(
      id: json['id'],
      title: json['title'],
      isCompleted: json['isCompleted'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'isCompleted': isCompleted,
    };
  }
}
