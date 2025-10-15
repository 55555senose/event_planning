import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:event_planning/models/event_model.dart';

class FirebaseUtils {
  static CollectionReference<EventModel> getEventCollection() {
    return FirebaseFirestore.instance
        .collection(EventModel.collectionName)
        .withConverter<EventModel>(
      fromFirestore: (snapshot, options) =>
          EventModel.fromFirestore(snapshot.data()!, snapshot.id),
      toFirestore: (event, options) => event.toFirestore(),
    );
  }

  static Future<void> addEventToFirebase(EventModel event) {
    var eventsCollection = getEventCollection();
    DocumentReference<EventModel> docRef = eventsCollection.doc();
    // id هيتولد هنا
    final newEvent = EventModel(
      id: docRef.id,
      title: event.title,
      description: event.description,
      date: event.date,
      type: event.type,
      imagePath: event.imagePath,
      isSaved: event.isSaved,
      ownerId: event.ownerId,
    );
    return docRef.set(newEvent);
  }
}
