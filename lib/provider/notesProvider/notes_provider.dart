import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../auth/auth_provider.dart';

final notesCollectionProvider = Provider<CollectionReference<Map<String, dynamic>>>((ref) {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  if (_auth.currentUser == null) throw Exception("User not logged in");

  return FirebaseFirestore.instance
      .collection('users')
      .doc(_auth.currentUser?.uid)
      .collection('notes');
});

final notesStreamProvider = StreamProvider.autoDispose((ref) {
  final notesCollection = ref.watch(notesCollectionProvider);
  return notesCollection.orderBy('date', descending: true).snapshots();
});
