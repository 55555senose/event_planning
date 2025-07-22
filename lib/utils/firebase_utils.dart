import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:event_planning/models/event_model.dart';
import 'package:firebase_core/firebase_core.dart';

class FirebaseUtils {
  static CollectionReference<EventModel> getEventCollection() {
    return FirebaseFirestore.instance
        .collection(EventModel.collectionName)
        .withConverter<EventModel>(
          fromFirestore: (snapshot, options) =>
              EventModel.fromFirestore(snapshot.data()!),
          toFirestore: (event, options) => event.toFirestore(),
        );
  }

  static Future<void> addEventToFirebase(EventModel event) {
    var eventsCollection = getEventCollection();
    DocumentReference<EventModel> docRef = eventsCollection.doc();
    event.id = docRef.id;
    return docRef.set(event);
  }
}
