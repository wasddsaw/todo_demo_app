import 'package:cloud_firestore/cloud_firestore.dart';

class Todo {
  String? title;
  String? startDate;
  String? endDate;
  String? status;

  Todo({
    required this.title,
    required this.startDate,
    required this.endDate,
    required this.status,
  });

  toMap() {
    return {
      'title': title,
      'start_date': startDate,
      'end_date': endDate,
      'status': status,
    };
  }

  factory Todo.fromSnapshot(QueryDocumentSnapshot<Map<String, dynamic>> doc) {
    return Todo(
      title: doc.data()['title'],
      startDate: doc.data()['start_date'],
      endDate: doc.data()['end_date'],
      status: doc.data()['status'],
    );
  }
}
