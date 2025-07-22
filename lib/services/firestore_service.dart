import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:event_planning/models/event_model.dart';

class FirestoreService {
  static Stream<List<EventModel>> getEventsStream() {
    return FirebaseFirestore.instance
        .collection(EventModel.collectionName)
        .orderBy('date')
        .snapshots()
        .map((snapshot) {
      return snapshot.docs.map((doc) {
        return EventModel.fromFirestore(doc.data());
      }).toList();
    });
  }
}
