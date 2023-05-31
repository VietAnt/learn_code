import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:notion_bloc/bloc_home/database_bloc/database_bloc.dart';
import 'package:notion_bloc/bloc_home/database_bloc/database_state.dart';
import 'package:notion_bloc/bloc_home/todo_bloc/todo_bloc.dart';
import 'package:notion_bloc/bloc_home/todo_bloc/todo_state.dart';

void main() {
  BlocOverrides.runZoned(
    () => runApp(
      MultiBlocProvider(
        providers: [
          BlocProvider<DatabaseBloc>(
            create: (context) => DatabaseBloc()..initDatabase(),
          ),
        ],
        child: const MyApp(),
      ),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primaryColor: Colors.blue,
      ),
      debugShowCheckedModeBanner: false,
      home: const MyHomePages(title: 'Flutter Todo App'),
    );
  }
}

class MyHomePages extends StatefulWidget {
  final String title;

  const MyHomePages({
    super.key,
    required this.title,
  });

  @override
  State<MyHomePages> createState() => _MyHomePagesState();
}

class _MyHomePagesState extends State<MyHomePages> {
  String _text = "";
  TodoBloc? todoBloc;

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: BlocConsumer<DatabaseBloc, DatabaseState>(
        listener: (context, state) {
          if (state is LoadDatabaseState) {
            todoBloc =
                TodoBloc(database: context.read<DatabaseBloc>().database!);
          }
        },
        builder: (context, state) {
          if (state is LoadDatabaseState) {
            return BlocProvider(
              create: (context) => todoBloc!..getTodos(),
              child: BlocConsumer<TodoBloc, TodoState>(
                listener: (context, todoState) {},
                builder: (context, todoState) {
                  if (todoState is InitTodoState) {
                    final todo = todoBloc!.todo;
                    return Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        children: [
                          TextFormField(
                            maxLines: 1,
                            onChanged: (value) {
                              setState(() {
                                _text = value;
                              });
                            },
                          ),
                          const SizedBox(height: 10),
                          Expanded(
                            child: ListView.separated(
                              shrinkWrap: true,
                              itemCount: todo.length,
                              separatorBuilder: (context, index) =>
                                  const SizedBox(height: 10),
                              itemBuilder: (context, index) {
                                return Row(
                                  children: [
                                    Expanded(
                                      child: Text(
                                        todo[index].text,
                                        style: const TextStyle(
                                          fontSize: 24,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ),
                                    IconButton(
                                      onPressed: () {
                                        todoBloc!.removeTodo(todo[index].id);
                                      },
                                      icon: const Icon(Icons.delete),
                                    ),
                                  ],
                                );
                              },
                            ),
                          ),
                        ],
                      ),
                    );
                  }
                  return Container();
                },
              ),
            );
          }
          return const Center(
            child: Text('Database not loaded'),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          if (todoBloc != null) {
            todoBloc!.addTodo(_text);
          }
        },
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ),
    );
  }
}
