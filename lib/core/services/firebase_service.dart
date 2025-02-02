import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../firebase_options.dart';

class FirebaseService {
  final FirebaseFirestore firestore;
  final FirebaseAuth auth;

  FirebaseService({required this.firestore, required this.auth});

  static Future<FirebaseService> initialize() async {
    try {
      if (kIsWeb) {
        await Firebase.initializeApp(
          options: DefaultFirebaseOptions.currentPlatform,
        );
      } else {
        await Firebase.initializeApp();
      }

      final firestore = FirebaseFirestore.instance;
      final auth = FirebaseAuth.instance;
      return FirebaseService(firestore: firestore, auth: auth);
    } catch (e) {
      rethrow;
    }
  }
}

final firebaseServiceProvider = Provider<FirebaseService>((ref) {
  throw UnimplementedError();
});
