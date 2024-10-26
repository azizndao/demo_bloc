import 'package:demo_bloc/todo/bloc/todo_state.dart';
import 'package:demo_bloc/todo/view/todo_item.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../bloc/todo_bloc.dart';

class TodoPage extends StatelessWidget {
  const TodoPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => TodoBloc()..add(TodoLoadEvent()),
      child: const _TodoListView(),
    );
  }
}

class _TodoListView extends StatelessWidget {
  const _TodoListView({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final todoBloc = context.watch<TodoBloc>();
    final state = todoBloc.state;

    if (state is TodoLoadingState) {
      return const Center(
        child: CircularProgressIndicator(),
      );
    } else if (state is TodoLoadedState) {
      return Scaffold(
        appBar: AppBar(
          title: const Text('Todo List'),
        ),
        body: TodoListView(todos: state.todos),
      );
    } else {
      return const SizedBox();
    }
  }
}

class TodoListView extends StatelessWidget {
  const TodoListView({required this.todos, super.key});

  final List<TodoItem> todos;

  @override
  Widget build(BuildContext context) {
    // final todoBloc = context.watch<TodoBloc>();
    return LayoutBuilder(builder: (context, constraints) {
      if (constraints.maxWidth > 640) {
        return GridView.builder(
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            // childAspectRatio: 3 / 9,
          ),
          itemBuilder: (context, index) => TodoItemView(todo: todos[index]),
          itemCount: todos.length,
        );
      }
      return ListView.separated(
        itemBuilder: (context, index) => TodoItemView(todo: todos[index]),
        separatorBuilder: (context, index) => const Divider(),
        itemCount: todos.length,
      );
    });
  }
}
