import 'package:bussines_coach/services/auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

final FirebaseFirestore _database = FirebaseFirestore.instance;
final CollectionReference _reference = _database.collection('projects');

class Database {
  static String? userUid = Auth().currentUser?.uid;

// Add project in cloudstore
  static Future<void> addProject({
    required String title,
    required String description,
    required int color,
    required List<Map<String, dynamic>>? tasks,
  }) async {
    DocumentReference documentReference =
        _reference.doc(userUid).collection('projects').doc();

    Map<String, dynamic> data = <String, dynamic>{
      'title': title,
      'description': description,
      'color': color,
      'tasks': tasks
    };
    await documentReference
        .set(data)
        .whenComplete(() => print('succes'))
        .catchError((e) => print(e));
  }

  // Read projects in cloudstore
  static Stream<QuerySnapshot> readProjects() {
    CollectionReference projectsCollections =
        _reference.doc(userUid).collection('projects');
    return projectsCollections.snapshots();
  }

  static Future<dynamic> readProject({
    required String docId,
  }) async {
    DocumentReference documentReferencer =
        _reference.doc(userUid).collection('projects').doc(docId);

    DocumentSnapshot documentSnapshot = await documentReferencer.get();

    if (documentSnapshot.exists) {
      Map<String, dynamic>? project =
          documentSnapshot.data() as Map<String, dynamic>?;
      if (project != null) {
        // Aici poți folosi datele proiectului pentru a le afișa în altă pagină sau în altă parte a aplicației
        return project;
      } else {
        print('Project not found');
      }
    }
  }

  static Future<void> removeProject({required String projectID}) async {
    DocumentReference documentReference =
        _reference.doc(userUid).collection('projects').doc(projectID);

    await documentReference
        .delete()
        .whenComplete(() => print('Deleted'))
        .catchError((e) => print(e));
  }
}
