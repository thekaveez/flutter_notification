import 'package:cloud_firestore/cloud_firestore.dart';

class PayloadService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<void> savePayload({
    required List<dynamic> payload,
  }) async {
    try {
      await _firestore.collection('payload').doc('names').set({
        'payload': payload,
      }, SetOptions(merge: true));
    } catch (e) {
      throw 'Failed to save payload: $e';
    }
  }

  Future<List<dynamic>> getPayload() async {
    try {
      final DocumentSnapshot doc = await _firestore.collection('payload').doc('names').get();
      if(!doc.exists){
        throw 'Document does not exist';
      }
      final data = doc.data() as Map<String, dynamic>;
      if (!data.containsKey('payload')) {
        throw 'Payload does not exist';
      }

      return List<dynamic>.from(data['payload']);
    } catch (e) {
      throw 'Failed to get payload: $e';
    }
  }

  Stream<List<dynamic>> streamPayload() {
    return _firestore.collection('payload').doc('names').snapshots().map((doc) {
      if(!doc.exists){
        throw 'Document does not exist';
      }
      final data = doc.data() as Map<String, dynamic>;
      if (!data.containsKey('payload')) {
        throw 'Payload does not exist';
      }

      return List<dynamic>.from(data['payload']);
    });
  }
}
