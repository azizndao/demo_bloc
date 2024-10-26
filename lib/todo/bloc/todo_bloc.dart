import 'package:demo_bloc/todo/bloc/todo_state.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class TodoBloc extends Bloc<TodoEvent, TodoState> {
  TodoBloc() : super(TodoLoadingState()) {
    on<TodoLoadEvent>(_loadTodos);
  }

  final httpClient = Dio();

  Future<void> _loadTodos(TodoLoadEvent event, Emitter<TodoState> emit) async {
    final response =
        await httpClient.get('https://jsonplaceholder.typicode.com/todos');
    final List<TodoItem> todos = (response.data as List)
        .map((dynamic json) => TodoItem.fromJson(json as Map<String, dynamic>))
        .toList();
    emit(TodoLoadedState(todos));
  }
}

@immutable
sealed class TodoEvent {}

final class TodoLoadEvent extends TodoEvent {}
