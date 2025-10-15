import 'package:cloud_firestore/cloud_firestore.dart';

class EventModel {
  static const String collectionName = 'events';

  final String id;
  final String title;
  final String description;
  final DateTime date;
  final String type;
  final String imagePath;
  final bool isSaved;
  final String ownerId;

  EventModel({
    required this.id,
    required this.title,
    required this.description,
    required this.date,
    required this.type,
    required this.imagePath,
    required this.isSaved,
    required this.ownerId,
  });

  factory EventModel.fromFirestore(Map<String, dynamic> data, String id) {
    return EventModel(
      id: id,
      title: data['title'] ?? '',
      description: data['description'] ?? '',
      date: (data['date'] as Timestamp).toDate(),
      type: data['type'] ?? '',
      imagePath: data['imagePath'] ?? '',
      isSaved: data['isSaved'] ?? false,
      ownerId: data['ownerId'] ?? '',
    );
  }

  Map<String, dynamic> toFirestore() {
    return {
      'title': title,
      'description': description,
      'date': Timestamp.fromDate(date),
      'type': type,
      'imagePath': imagePath,
      'isSaved': isSaved,
      'ownerId': ownerId,
    };
  }
}
