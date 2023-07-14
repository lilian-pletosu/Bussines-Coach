import 'package:bussines_coach/services/database.dart';
import 'package:flutter/material.dart';

class SingleProject extends StatefulWidget {
  const SingleProject({super.key, required this.docId});
  final String docId;

  @override
  State<SingleProject> createState() => _SingleProjectState();
}

Widget buildProjectWidget(AsyncSnapshot snapshot) {
  if (snapshot.connectionState == ConnectionState.waiting) {
    return const CircularProgressIndicator();
  } else if (snapshot.hasError) {
    return Text('A apărut o eroare: ${snapshot.error}');
  } else if (!snapshot.hasData) {
    return const Text('Nu există date disponibile pentru acest proiect.');
  }

  Map<String, dynamic>? projectData = snapshot.data as Map<String, dynamic>?;

  if (projectData != null) {
    String title = projectData['title'];
    Map<String, dynamic> tasks = projectData['tasks'];
    print(projectData['tasks']);
    return Center(child: Text(title));
  } else {
    return const Text('Datele proiectului nu sunt disponibile.');
  }
}

class _SingleProjectState extends State<SingleProject> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SingleChildScrollView(
            child: FutureBuilder(
      future: Database.readProject(docId: widget.docId),
      builder: (context, snapshot) {
        return buildProjectWidget(snapshot);
      },
    )));
  }
}
