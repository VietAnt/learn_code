// ignore_for_file: prefer_final_fields
import 'dart:math';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:notion_bloc/bloc_home/todo_bloc/todo_state.dart';
import 'package:notion_bloc/model/todo_model.dart';
import 'package:notion_bloc/repository/todo_repo.dart';
import 'package:sqflite/sqflite.dart';

//Todo: TodoBloc
class TodoBloc extends Cubit<TodoState> {
  final Database database;
  final todoRepo = TodoRepository();
  int _counter = 1;

  TodoBloc({required this.database}) : super(const InitTodoState(0));

  //*List-Danh_sach_Todo
  List<Todo> _todos = [];
  List<Todo> get todo => _todos;

  //Todo: getTodos
  Future<void> getTodos() async {
    try {
      _todos = await todoRepo.getTodos(database: database);
      emit(InitTodoState(_counter++));
    } catch (e) {
      log(e.toString() as num);
    }
  }

  //Todo: addTodo
  Future<void> addTodo(String text) async {
    try {
      await todoRepo.addTodo(database: database, text: text);
      emit(InitTodoState(_counter++));
      getTodos();
    } catch (e) {
      log(e.toString() as num);
    }
  }

  //Todo: RemoveTodo
  Future<void> removeTodo(int id) async {
    try {
      await todoRepo.removeTodo(database: database, id: id);
      emit(InitTodoState(_counter++));
      getTodos();
    } catch (e) {
      log(e.toString() as num);
    }
  }
}
