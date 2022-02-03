import 'package:flutter/cupertino.dart';

class Task {
  String title;
  bool isCompleted;

  Task({required this.title, this.isCompleted = false});

  Task.fromJson(Map<String, dynamic> json)
      : title = json['title'],
        isCompleted = json['isCompleted'];

  Map<String, dynamic> toJson() => {
        'title': title,
        'isCompleted': isCompleted,
      };
}
