import 'package:floor/floor.dart';
import 'package:organize_me/features/todo/data/data_source/local/todo_dao.dart';
import 'package:organize_me/features/todo/data/models/todo.dart';
import 'package:sqflite/sqflite.dart' as sqflite;
import 'dart:async';
part 'app_database.g.dart';

@Database(version: 1, entities: [ToDoModel])
abstract class Appdatabase extends FloorDatabase {
  TodoDao get todoDAO;
}
