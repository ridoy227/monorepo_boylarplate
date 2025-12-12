import '../../domain/entities/todo.dart';

class TodoModel extends Todo {
  const TodoModel({super.id, required super.title, required super.isCompleted});

  factory TodoModel.fromJson(Map<String, dynamic> json) {
    return TodoModel(
      id: json['id'],
      title: json['title'],
      isCompleted: json['isCompleted'] == 1,
    );
  }

  Map<String, dynamic> toJson() {
    return {'id': id, 'title': title, 'isCompleted': isCompleted ? 1 : 0};
  }
}
