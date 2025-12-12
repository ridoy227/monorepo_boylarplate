import 'package:equatable/equatable.dart';

class Todo extends Equatable {
  final int? id;
  final String title;
  final bool isCompleted;

  const Todo({this.id, required this.title, required this.isCompleted});

  @override
  List<Object?> get props => [id, title, isCompleted];
}
