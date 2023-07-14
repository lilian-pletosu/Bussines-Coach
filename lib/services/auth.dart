import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';

class Auth {
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

  User? get currentUser => _firebaseAuth.currentUser;

  Stream<User?> get authStateChanges => _firebaseAuth.authStateChanges();

  Future<void> signInWithEmailAndPassword({
    required String email,
    required String password,
  }) async {
    await _firebaseAuth.signInWithEmailAndPassword(
        email: email, password: password);
  }

  Future<void> createUserWithEmailAndPassword({
    required String email,
    required String password,
  }) async {
    await _firebaseAuth.createUserWithEmailAndPassword(
        email: email, password: password);
  }

  Future<void> updateDisplayName({required String name}) async {
    await _firebaseAuth.currentUser?.updateDisplayName(name);
  }

  Future<void> updatePhoto({required String photoUrl}) async {
    await _firebaseAuth.currentUser?.updatePhotoURL(photoUrl);
  }

  Future<String?> uploadProfilePhoto(File photo) async {
    final user = _firebaseAuth.currentUser;
    if (user != null) {
      final storageRef = FirebaseStorage.instance
          .ref()
          .child('profile_photos')
          .child(user.uid);
      final uploadTask = storageRef.putFile(photo);
      final snapshot = await uploadTask.whenComplete(() {});
      final photoUrl = await snapshot.ref.getDownloadURL();
      return photoUrl;
    }
    return null;
  }

  Future<void> signOut() async {
    await _firebaseAuth.signOut();
  }
}
