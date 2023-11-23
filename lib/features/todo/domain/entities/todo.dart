import 'package:equatable/equatable.dart';
import 'package:floor/floor.dart';
import 'package:flutter/scheduler.dart';

class TodoEntity extends Equatable {

  final int? id;
  final String? content;
  final String? title;
  final String? description;
  bool? done;
  final String? createdDate;
  final String? deadlineDate;

  TodoEntity(
      {this.id,
      this.content,
      this.title,
      this.description,
      this.done,
      this.createdDate,
      this.deadlineDate});

  @override
  List<Object?> get props {
    return [id, content, title, description, done, createdDate, deadlineDate];
  }
}

class TodoList {
  final List<TodoEntity> _mockDataTodo = [];

  List<TodoEntity> get mockDataTodo => _mockDataTodo;

  void addMockData() {
    mockDataTodo.add(TodoEntity(
        description: "Do laundry", title: "Clean your room", done: true));
    mockDataTodo.add(TodoEntity(
        description: "Cook dinner!", title: "Clean your room", done: true));
    mockDataTodo.add(TodoEntity(
        description: "Do laundry, clean carpet and wash windows.",
        title: "Clean your room",
        done: false));
    mockDataTodo.add(TodoEntity(
        description: "Do laundry, clean carpet and wash windows.",
        title: "Clean your room",
        done: false));
    mockDataTodo.add(TodoEntity(
        description: "Do laundry, .", title: "Clean your room", done: false));
    for (var todo in mockDataTodo) {
      print("inside TodoList class, mockdata. done = ${todo.done}");
    }
  }
  
}
