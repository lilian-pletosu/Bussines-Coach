import 'package:bussines_coach/routes/routes.dart';
import 'package:bussines_coach/services/database.dart';
import 'package:bussines_coach/utils/constants.dart';
import 'package:bussines_coach/widgets/bottom_navigation_bar.dart';
import 'package:bussines_coach/widgets/projects_tile.dart';
import 'package:flutter/material.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';
import 'package:go_router/go_router.dart';

class ChallengeScreen extends StatefulWidget {
  const ChallengeScreen({super.key});

  @override
  State<ChallengeScreen> createState() => _ChallengeScreenState();
}

class _ChallengeScreenState extends State<ChallengeScreen> {
  final _scaffoldKey = GlobalKey<ScaffoldState>();

  void _createNewProject(BuildContext context) async {
    _showFormAddProject(context);
    // ;
  }

  _opemBottomSheet(String docId) {
    context.goNamed(projectScreenPageName, queryParameters: {'docID': docId});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        elevation: 0,
        bottomOpacity: 100,
        scrolledUnderElevation: 100,
        surfaceTintColor: kPurpleColor,
        backgroundColor: Colors.transparent,
        titleSpacing: 32,
        title: Text(
          tasksScreenPageName,
          style: kTaskNameFontStyle(),
        ),
        automaticallyImplyLeading: false,
        actions: const [
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 32.0),
            child: Icon(Icons.search_rounded),
          )
        ],
      ),
      bottomNavigationBar: const CustomBottomNavigationBar(),
      floatingActionButton: FloatingActionButton(
        onPressed: () => _createNewProject(context),
        child: const Icon(Icons.add_rounded),
      ),
      body: SingleChildScrollView(
        physics: const PageScrollPhysics(),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 32.0, vertical: 42.0),
          child: Column(
            children: [
              StreamBuilder(
                stream: Database.readProjects(),
                builder: (context, snapshot) {
                  if (snapshot.hasError) {
                    const Text('Something was wrong');
                  } else if (snapshot.hasData || snapshot.data != null) {
                    return ListView.builder(
                      physics: const NeverScrollableScrollPhysics(),
                      shrinkWrap: true,
                      itemCount: snapshot.data?.docs.length,
                      itemBuilder: (context, index) {
                        var project = snapshot.data?.docs[index].data()
                            as Map<String, dynamic>;
                        String projectId = snapshot.data!.docs[index].id;
                        String projectTitle = project['title'];
                        String projectdescription = project['title'];
                        int projectColor = project['color'] ?? 0xfff778ba;
                        return ProjectTile(
                            title: projectTitle,
                            color: projectColor,
                            id: projectId,
                            onTapProject: () => _opemBottomSheet(projectId),
                            description: projectdescription);
                      },
                    );
                  }
                  return const Center(
                    child: CircularProgressIndicator(
                      valueColor: AlwaysStoppedAnimation<Color>(
                        Colors.blue,
                      ),
                    ),
                  );
                },
              )
            ],
          ),
        ),
      ),
    );
  }
}

Future<void> _showFormAddProject(BuildContext context) {
  final formkey = GlobalKey<FormState>();
  final TextEditingController name = TextEditingController();
  final TextEditingController description = TextEditingController();
  String projectName = '';
  String projectDescription = '';
  int projectColor = 0xff1eeee;

  return showDialog(
    context: context,
    builder: (context) {
      return AlertDialog(
        scrollable: true,
        title: const Text('Add new project'),
        content: Form(
          key: formkey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              TextFormField(
                controller: name,
                onChanged: (value) {
                  print(value);
                  projectName = value;
                },
                decoration: const InputDecoration(
                  labelText: 'Project name',
                ),
              ),
              TextFormField(
                controller: description,
                onChanged: (value) {
                  print(value);
                  projectDescription = value;
                },
                decoration:
                    const InputDecoration(labelText: 'Project description'),
              ),
              const Padding(
                padding: EdgeInsets.symmetric(vertical: 8.0),
                child: Text('Select color:', style: TextStyle(fontSize: 16)),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 8.0),
                child: SizedBox(
                  height: 130,
                  width: double.infinity,
                  child: BlockPicker(
                    pickerColor: Colors.red, //default color
                    onColorChanged: (Color color) {
                      //on color picked

                      projectColor = color.value;
                    },
                  ),
                ),
              )
            ],
          ),
        ),
        actions: [
          TextButton(
              onPressed: () async {
                await Database.addProject(
                        title: projectName,
                        description: projectDescription,
                        tasks: null,
                        color: projectColor)
                    .then((value) {
                  Navigator.of(context).pop();
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Project add successufuly')),
                  );
                });
              },
              child: const Text('Submit'))
        ],
      );
    },
  );
}





// return StreamBuilder<QuerySnapshot>(
//       stream: Database.readProjects(),
//       builder: (context, snapshot) {
//         if (snapshot.hasError) {
//           return Text('Something is wrong');
//         } else if (snapshot.hasData || snapshot.data != null) {
//           return Scaffold(
//               floatingActionButton:
//                   FloatingActionButton(onPressed: _createNewProject),
//               body: ListView.builder(
//                   itemCount: snapshot.data?.docs.length,
//                   itemBuilder: (context, index) {
//                     var noteInfo = snapshot.data!.docs[index].data()
//                         as Map<String, dynamic>;
//                     String docID = snapshot.data!.docs[index].id;
//                     String title = noteInfo['title'];
//                     String description = noteInfo['description'];
//                     return Padding(
//                       padding: const EdgeInsets.symmetric(vertical: 10.0),
//                       child: Container(
//                           padding: const EdgeInsets.symmetric(
//                               vertical: 24, horizontal: 24),
//                           width: double.infinity,
//                           height: 200,
//                           decoration: BoxDecoration(
//                               color: kRoseColor,
//                               borderRadius: BorderRadius.circular(12)),
//                           child: Row(
//                             children: [
//                               Column(
//                                 mainAxisAlignment:
//                                     MainAxisAlignment.spaceBetween,
//                                 crossAxisAlignment: CrossAxisAlignment.start,
//                                 children: [
//                                   const CircleAvatar(
//                                     radius: 22,
//                                     backgroundColor: Colors.white,
//                                     child: CircleAvatar(
//                                       backgroundImage: NetworkImage(
//                                           'https://scontent.fkiv8-1.fna.fbcdn.net/v/t39.30808-6/348582670_238581202122084_3298866821462901663_n.jpg?stp=cp6_dst-jpg&_nc_cat=105&ccb=1-7&_nc_sid=09cbfe&_nc_ohc=7Rd17R8A4O0AX8-Bj0v&_nc_ht=scontent.fkiv8-1.fna&oh=00_AfCrjWwr1N0jNmkALNJs6o8XOprdc-liQTs-sI-5rRNv3w&oe=64B1BA65'),
//                                       radius: 20,
//                                     ),
//                                   ),
//                                   Text(
//                                     '12/12 tasks 100%',
//                                     style: kTaskNameFontStyle(
//                                         color: Colors.white,
//                                         fontSize: 17,
//                                         fontWeight: FontWeight.w400),
//                                   ),
//                                   Text(
//                                     title,
//                                     style: kTaskNameFontStyle(
//                                         color: Colors.white,
//                                         fontSize: 28,
//                                         fontWeight: FontWeight.w600),
//                                   )
//                                 ],
//                               ),
//                               Flexible(
//                                 child: Image.asset(
//                                   'images/mentor.png',
//                                   scale: 3,
//                                 ),
//                               )
//                             ],
//                           )),
//                     );
//                   }));
//         }
//         return const Center(
//           child: CircularProgressIndicator(
//             valueColor: AlwaysStoppedAnimation<Color>(
//               Colors.red,
//             ),
//           ),
//         );
//       },
//     );


