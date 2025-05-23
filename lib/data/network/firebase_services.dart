import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';

class FirebaseServices {



  final FirebaseFirestore _firestore = FirebaseFirestore.instance;



  /// Add new document to a collection (auto ID)
  Future<DocumentReference> addToCollection({
    required CollectionReference collRef,
    required Map<String, dynamic> data,
  }) async {
    try {
      debugPrint("✅ New document added to: ${collRef.path} \n Request $data");
      return await collRef.add(data);
    } catch (e) {
      debugPrint("❌ addToCollection error: $e");
      rethrow;
    }
  }

  /// Read collection documents
  Future<QuerySnapshot> getCollection({
    required CollectionReference collRef,
  }) async {
    try {
      final snapshot =
      await collRef.orderBy('marketDate', descending: true).get();
      debugPrint(

        "✅ New document added to: ${collRef.path}  response: $snapshot",);
      return snapshot;
    } catch (e) {
      debugPrint("❌ getCollection error: $e");
      rethrow;
    }
  }

  /// Update document
  Future<void> updateDocument({
    required CollectionReference docRef,
    required Map<String, dynamic> data,
    required String memberId
  }) async {
    try {
      await docRef.doc().update(data);
      debugPrint("🔄 Document updated: ${docRef.path}");
    } catch (e) {
      debugPrint("❌ updateDocument error: $e");
      rethrow;
    }
  }

  /// Delete document
  Future<void> deleteDocument({
    required DocumentReference docRef,
  }) async {
    try {
      await docRef.delete();
      debugPrint("🗑️ Document deleted: ${docRef.path}");
    } catch (e) {
      debugPrint("❌ deleteDocument error: $e");
      rethrow;
    }
  }
}