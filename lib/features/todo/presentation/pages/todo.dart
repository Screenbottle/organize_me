class Todo {
  final int? id;
  final String? content;
  final String? title;
  final String? description;
  final bool? done;
  final String? createdDate;
  final String? deadlineDate;

  const Todo(
      {this.id,
      this.content,
      this.title,
      this.description,
      this.done,
      this.createdDate,
      this.deadlineDate});
}

class TodoList {
  final List<Todo> _mockDataTodo = [];

  List<Todo> get mockDataTodo => _mockDataTodo;

  void addMockData() {
    mockDataTodo.add(const Todo(
        description: "Do laundry", title: "Clean your room", done: false));
    mockDataTodo.add(const Todo(
        description:
            "Do laundry, clean carpet and wash wdmswdswl.kwlkweäölwöäqelwö'äelwqä  läöeldäeöindows.",
        title: "Clean your room",
        done: false));
    mockDataTodo.add(const Todo(
        description: "Do laundry, clean carpet and wash windows.",
        title: "Clean your room",
        done: false));
    mockDataTodo.add(const Todo(
        description: "Do laundry, clean carpet and wash windows.",
        title: "Clean your room",
        done: false));
    mockDataTodo.add(const Todo(
        description: "Do laundry, .", title: "Clean your room", done: false));
  }
}
