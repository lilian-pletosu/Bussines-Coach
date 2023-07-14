import 'dart:io';
import 'dart:typed_data';

import 'package:bussines_coach/utils/constants.dart';
import 'package:bussines_coach/utils/helper.dart';
import 'package:bussines_coach/widgets/header_widget.dart';
import 'package:bussines_coach/widgets/in_progress_tasks_widget.dart';
import 'package:bussines_coach/widgets/task_widget.dart';
import 'package:bussines_coach/widgets/bottom_navigation_bar.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

import '../services/auth.dart';
import '../widgets/daily_tasks.dart';
import '../widgets/section_title.dart';

class Dashboard extends StatefulWidget {
  Dashboard({Key? key}) : super(key: key);

  final _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  State<Dashboard> createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  final User? user = Auth().currentUser;
  String userName = '';
  late Uint8List placeholderImage;
  final ImagePicker _picker = ImagePicker();
  Image? _file;

  Future<void> initializePlaceholderImage() async {
    placeholderImage = await createPlaceholderImage(200, 200, text: 'Lilian');
  }

  Future<void> signOut() async {
    await Auth().signOut();
  }

  Future<void> updateName(name) async {
    await Auth().updateDisplayName(name: name);
    setState(() {
      userName = user?.displayName ?? 'Wrong';
    });
  }

  void _closeBottomSheet() => Navigator.pop(context);

  void makePhoto(ImageSource imageSource) async {
    final pickedFile = await _picker.pickImage(source: imageSource);
    setState(() {
      _file = Image.file(File(pickedFile!.path));
      Auth().updatePhoto(photoUrl: pickedFile.path);
    });
  }

  void _openBottomSheet() {
    showModalBottomSheet(
        context: context,
        builder: (BuildContext context) {
          return Container(
            padding:
                const EdgeInsets.only(left: 32, right: 32, bottom: 32, top: 1),
            decoration: BoxDecoration(
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.5),
                  spreadRadius: 5,
                  blurRadius: 7,
                  offset: const Offset(0, 2),
                ),
              ],
              color: Colors.white,
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(20),
                topRight: Radius.circular(20),
              ),
            ),
            height: 500,
            width: double.infinity,
            child: Column(
              children: [
                const Padding(
                  padding: EdgeInsets.only(bottom: 8.0),
                  child: SizedBox(
                    width: 50,
                    child: Divider(
                      height: 30,
                      color: Colors.grey,
                    ),
                  ),
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    InkWell(
                        onTap: () {
                          setState(() {
                            makePhoto(ImageSource.gallery);
                          });
                        },
                        child: CircleAvatar(
                          radius: 64,
                          backgroundImage: _file != null
                              ? _file?.image
                              : MemoryImage(placeholderImage),
                        )),
                    Padding(
                      padding: const EdgeInsets.only(top: 32.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text('Name', style: kProjectNameFontStyle),
                          Text(
                            userName,
                            style: kProjectNameFontStyle,
                          )
                        ],
                      ),
                    ),
                    const Divider(
                      height: 20,
                      color: Colors.black,
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 8.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text('Email', style: kProjectNameFontStyle),
                          Text(
                            user?.email as String,
                            style: kProjectNameFontStyle,
                          )
                        ],
                      ),
                    ),
                    const Divider(
                      height: 20,
                      color: Colors.black,
                    ),
                    Padding(
                        padding: const EdgeInsets.only(top: 8.0),
                        child: InkWell(
                          onTap: () async {
                            _closeBottomSheet();
                            await signOut();
                          },
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                "Logout",
                                style: kProjectNameFontStyle,
                              ),
                              const Icon(
                                Icons.logout,
                              )
                            ],
                          ),
                        ))
                  ],
                )
              ],
            ),
          );
        });
  }

  @override
  void initState() {
    super.initState();
    userName = user?.displayName ?? 'Username';
    initializePlaceholderImage();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: widget._scaffoldKey,
      bottomNavigationBar: const CustomBottomNavigationBar(),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 32.0, vertical: 42.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              HeaderWidget(
                userName: userName,
                onTap: _openBottomSheet,
              ),
              const SizedBox(
                height: 32,
              ),
              const DailyTasks(),
              const SizedBox(
                height: 32,
              ),
              const SectionTitle(
                color: Color(0xfff778ba),
                numColor: Color(0xfff778ba),
                sectionTitle: 'To do',
                howMuch: 3,
              ),
              SizedBox(
                height: 182,
                width: double.infinity,
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: 5,
                  itemBuilder: (context, index) {
                    return const TaskWidget();
                  },
                ),
              ),
              const SizedBox(
                height: 32,
              ),
              const SectionTitle(
                sectionTitle: 'In progress',
                color: Color(0xffffe5a4),
                howMuch: 7,
                numColor: Color.fromARGB(255, 228, 171, 26),
              ),
              SizedBox(
                width: double.infinity,
                height: 265,
                child: ListView.builder(
                  shrinkWrap: true,
                  // physics: NeverScrollableScrollPhysics(),
                  itemCount: 7,
                  itemBuilder: (context, index) {
                    return const InProgressTasksWidget();
                  },
                ),
              ),
              const SectionTitle(
                sectionTitle: 'sectionTitle',
                color: Color(0x000ff12d),
                howMuch: 5,
                numColor: Color(0x000f1111),
              ),
              SizedBox(
                height: 182,
                width: double.infinity,
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: 5,
                  itemBuilder: (context, index) {
                    return const TaskWidget();
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}



// class BottomSheet extends StatefulWidget {
//   BottomSheet(this.onTap,
//       {super.key,
//       required this.username,
//       required this.image,
//       required this.changePhoto});
//   final VoidCallback onTap;
//   final String username;
//   var image;
//   final VoidCallback changePhoto;

//   @override
//   State<BottomSheet> createState() => _BottomSheetState();
// }

// class _BottomSheetState extends State<BottomSheet> {
//   @override
//   Widget build(BuildContext context) {
//     return 
  // }
// }
