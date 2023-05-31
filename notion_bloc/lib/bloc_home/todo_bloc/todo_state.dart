import 'package:equatable/equatable.dart';

abstract class TodoState extends Equatable {
  const TodoState();

  @override
  List<Object> get props => [];
}

//Todo: InitTodoState
class InitTodoState extends TodoState {
  final int counter;

  const InitTodoState(this.counter);

  @override
  List<Object> get props => [counter];
}

//Todo: AddTodoState
class AddTodoState extends TodoState {}

//Todo: RemoveTodoState
class RemoveTodoState extends TodoState {}
