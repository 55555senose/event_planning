import 'package:cloud_firestore/cloud_firestore.dart';

class EventModel {
  static const String collectionName = 'Events';
  late final String id;
  final String title;
  final String description;
  final String imagePath;
  final DateTime date;
  final String type;
  bool isSaved;

  EventModel({
    this.id = '',
    required this.title,
    required this.description,
    required this.imagePath,
    required this.date,
    required this.type,
    this.isSaved = false,
  });

  /// ✅ من JSON فيه date كـ milliseconds
  factory EventModel.fromFirestore(Map<String, dynamic> data) {
    return EventModel(
      id: data['id'] ?? '',
      title: data['title'] ?? '',
      description: data['description'] ?? '',
      imagePath: data['imagePath'] ?? '',
      date: DateTime.fromMillisecondsSinceEpoch(data['date']), // ✅
      type: data['type'] ?? '',
      isSaved: data['isSaved'] ?? false,
    );
  }

  /// ✅ إلى JSON فيه date كـ milliseconds
  Map<String, dynamic> toFirestore() {
    return {
      'id': id,
      'title': title,
      'description': description,
      'imagePath': imagePath,
      'date': date.millisecondsSinceEpoch, // ✅
      'type': type,
      'isSaved': isSaved,
    };
  }
}
