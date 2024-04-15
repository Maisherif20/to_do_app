import 'package:cloud_firestore/cloud_firestore.dart';

class Task {
  static const taskCollectionName = 'Tasks';
  String? id;
  String? title;
  String? description;
  Timestamp? datetime;
  Timestamp? updateTime;
  bool? isDone;
  // DateTime? date;
  Task(
      {this.id,
      this.title,
      this.description,
      this.datetime,
      this.isDone = false,
      this.updateTime});
  Task.fromFireSore(Map<String, dynamic>? data)
      : this(
            id: data?['id'],
            title: data?['title'],
            description: data?['description'],
            datetime: data?['datetime'],
            isDone: data?['isDone'],
            updateTime: data?['updateTime']);
  Map<String, dynamic> toFireSore() {
    return {
      'id': id,
      'title': title,
      'description': description,
      'datetime': datetime,
      'isDone': isDone,
      'updateTime': updateTime,
    };
  }
}
