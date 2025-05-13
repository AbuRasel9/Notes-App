import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

//get all notes
final notesCollectionProvider = Provider<CollectionReference<Map<String, dynamic>>>((ref) {
  final userId = FirebaseAuth.instance.currentUser?.uid;
  if (userId == null) throw Exception('User not logged in');

  return FirebaseFirestore.instance
      .collection('users')
      .doc(userId)
      .collection('notes');
});

final notesStreamProvider = StreamProvider.autoDispose<QuerySnapshot<Map<String, dynamic>>>((ref) {
  final notesCollection = ref.watch(notesCollectionProvider);
  return notesCollection.orderBy('createdAt', descending: true).snapshots();
});

final noteServiceProvider = Provider<NoteService>((ref) {
  final notesCollection = ref.watch(notesCollectionProvider);
  return NoteService(notesCollection);
});

class NoteService {
  final CollectionReference<Map<String, dynamic>> _notesCollection;

  NoteService(this._notesCollection);

  // Create a new note
  Future<void> addNote({
    required String title,
    required String content,
  }) async {
    try {
      await _notesCollection.add({
        'title': title,
        'content': content,
        'createdAt': DateTime.now(),
        'updatedAt': DateTime.now(),
      });
    } catch (e) {
      throw Exception('Failed to add note: $e');
    }
  }

  // Update an existing note
  Future<void> updateNote({
    required String noteId,
    required String title,
    required String content,
  }) async {
    try {
      await _notesCollection.doc(noteId).update({
        'title': title,
        'content': content,
        'updatedAt': DateTime.now(),
      });
    } catch (e) {
      throw Exception('Failed to update note: $e');
    }
  }

  // Delete a note
  Future<void> deleteNote(String noteId) async {
    try {
      await _notesCollection.doc(noteId).delete();
    } catch (e) {
      throw Exception('Failed to delete note: $e');
    }
  }

  Future<DocumentSnapshot<Map<String, dynamic>>> getNote(String noteId) async {
    try {
      return await _notesCollection.doc(noteId).get();
    } catch (e) {
      throw Exception('Failed to get note: $e');
    }
  }
}

// 4. Helper extension for easier data access
extension DocumentSnapshotExt on DocumentSnapshot<Map<String, dynamic>> {
  String get docId => id;
  String get title => data()?['title'] ?? '';
  String get content => data()?['content'] ?? '';
  DateTime get createdAt => (data()?['createdAt'] as Timestamp).toDate();
  DateTime? get updatedAt => (data()?['updatedAt'] as Timestamp?)?.toDate();
}