import 'package:flutter/material.dart';

@immutable
class TodoState {
  const TodoState();
}

class TodoLoadingState extends TodoState {}

class TodoLoadedState extends TodoState {
  const TodoLoadedState(this.todos);

  final List<TodoItem> todos;
}

class TodoItem {
  TodoItem({required this.title, required this.completed});

  final String title;
  final bool completed;

  factory TodoItem.fromJson(Map<String, dynamic> json) {
    return TodoItem(
      title: json['title'] as String,
      completed: json['completed'] as bool,
    );
  }
}
