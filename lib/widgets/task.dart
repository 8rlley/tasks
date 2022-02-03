import 'package:flutter/cupertino.dart';

class Task {
  String title;
  bool isCompleted;
  TextEditingController? taskController;
  FocusNode? taskFocusNode;

  Task(
      {this.title = '',
      this.isCompleted = false,
      this.taskController,
      this.taskFocusNode});

  Task.fromJson(Map<String, dynamic> json)
      : title = json['title'],
        isCompleted = json['isCompleted'];

  Map<String, dynamic> toJson() => {
        'title': title,
        'isCompleted': isCompleted,
      };
}
