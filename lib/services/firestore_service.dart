import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:event_planning/models/event_model.dart';
import 'package:firebase_auth/firebase_auth.dart';

class FirestoreService {
  static final _db = FirebaseFirestore.instance;
  static final _auth = FirebaseAuth.instance;

  /// إضافة حدث جديد
  static Future<void> addEvent(EventModel event) async {
    final uid = _auth.currentUser?.uid;
    if (uid == null) throw Exception('Not authenticated');

    await _db.collection(EventModel.collectionName).add({
      ...event.toFirestore(),
      'ownerId': uid,
    });
  }

  /// 📡 استريم للأحداث (للاستخدام مع StreamBuilder)
  static Stream<List<EventModel>> getEventsStream() {
    return _db
        .collection(EventModel.collectionName)
        .orderBy('date')
        .snapshots()
        .map((snapshot) {
      return snapshot.docs.map((doc) {
        return EventModel.fromFirestore(doc.data(), doc.id);
      }).toList();
    });
  }
}
