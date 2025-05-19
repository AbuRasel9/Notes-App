import 'package:cloud_firestore/cloud_firestore.dart';

class NotesModel {
  final String? id;
  final String title;
  final String content;
  final DateTime createdAt;
  final DateTime updatedAt;
  final bool isPinned;
  final List<String>? tags;

  NotesModel({
    this.id,
    required this.title,
    required this.content,
    DateTime? createdAt,
    DateTime? updatedAt,
    this.isPinned = false,
    this.tags,
  })  : createdAt = createdAt ?? DateTime.now(),
        updatedAt = updatedAt ?? DateTime.now();

  // Convert Firestore Document to NotesModel
  factory NotesModel.fromFirestore(
      DocumentSnapshot<Map<String, dynamic>> snapshot,
      SnapshotOptions? options,
      ) {
    final data = snapshot.data()!;
    return NotesModel(
      id: snapshot.id,
      title: data['title'] ?? '',
      content: data['content'] ?? '',
      createdAt: (data['createdAt'] as Timestamp).toDate(),
      updatedAt: (data['updatedAt'] as Timestamp).toDate(),
      isPinned: data['isPinned'] ?? false,
      tags: data['tags'] != null ? List<String>.from(data['tags']) : null,
    );
  }

  // Convert NotesModel to Firestore Document
  Map<String, dynamic> toFirestore() {
    return {
      'title': title,
      'content': content,
      'createdAt': Timestamp.fromDate(createdAt),
      'updatedAt': Timestamp.fromDate(updatedAt),
      'isPinned': isPinned,
      if (tags != null) 'tags': tags,
    };
  }



}