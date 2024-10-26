import 'package:demo_bloc/todo/bloc/todo_state.dart';
import 'package:flutter/material.dart';

class TodoItemView extends StatelessWidget {
  const TodoItemView({required this.todo, super.key});

  final TodoItem todo;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(todo.title),
      trailing: Checkbox(
        value: todo.completed,
        onChanged: (_) {},
      ),
    );
  }
}
