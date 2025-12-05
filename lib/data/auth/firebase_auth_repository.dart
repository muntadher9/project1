import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart' hide UserMetadata;

import '../../domain/auth/auth_repository.dart';
import '../../domain/models/app_user.dart';

class FirebaseAuthRepository implements AuthRepository {
  FirebaseAuthRepository(this._auth, this._firestore);

  final FirebaseAuth _auth;
  final FirebaseFirestore _firestore;

  @override
  Stream<AppUser?> authStateChanges() {
    return _auth.authStateChanges().asyncMap((user) async {
      if (user == null) return null;
      Map<String, dynamic>? data;
      try {
        final doc = await _firestore.collection('users').doc(user.uid).get();
        data = doc.data();
      } catch (_) {
        // Offline/unauthorized: proceed with minimal user info.
        data = null;
      }
      return AppUser(
        uid: user.uid,
        email: user.email ?? '',
        displayName: user.displayName,
        role: data?['role'] as String? ?? 'owner',
        branchIds: (data?['branchIds'] as List<dynamic>? ?? const [])
            .cast<String>(),
      );
    });
  }

  @override
  Future<void> signInWithEmail(String email, String password) async {
    await _auth.signInWithEmailAndPassword(email: email, password: password);
  }

  @override
  Future<void> signInAnonymously() {
    return _auth.signInAnonymously();
  }

  @override
  Future<void> createAccount(String email, String password) async {
    final credential = await _auth.createUserWithEmailAndPassword(
      email: email,
      password: password,
    );
    final user = credential.user;
    if (user != null) {
      await _firestore.collection('users').doc(user.uid).set({
        'uid': user.uid,
        'email': user.email,
        'role': 'owner',
        'branchIds': <String>[],
        'createdAt': FieldValue.serverTimestamp(),
      });
    }
  }

  @override
  Future<void> signOut() => _auth.signOut();
}
