import 'dart:io';
import 'dart:math';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:notion_bloc/bloc_home/database_bloc/database_state.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

//Todo: DatabaseBloc
class DatabaseBloc extends Cubit<DatabaseState> {
  DatabaseBloc() : super(InitDatabaseState());

  Database? database;

  //todo: initDatabase
  Future<void> initDatabase() async {
    final databasePath = await getDatabasesPath();
    final path = join(databasePath, 'todo.db');
    if (await Directory(dirname(path)).exists()) {
      database = await openDatabase(
        path,
        version: 1,
        onCreate: (Database db, int version) async {
          await db
              .execute('CREATE TABLE todo (id INTEGER PRIMARY KEY, name TEXT)');
        },
      );
      emit(LoadDatabaseState());
    } else {
      try {
        await Directory(dirname(path)).create(recursive: true);
        database = await openDatabase(
          path,
          version: 1,
          onCreate: (Database db, int version) async {
            await db.execute(
              'CREATE TABLE todo (id INTEGER PRIMARY KEY, name TEXT)',
            );
          },
        );
        emit(LoadDatabaseState());
      } catch (e) {
        log(e.toString() as num);
      }
    }
  }
}
