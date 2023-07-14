import 'package:bussines_coach/services/database.dart';
import 'package:bussines_coach/utils/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

class ProjectTile extends StatefulWidget {
  const ProjectTile(
      {super.key,
      required this.title,
      required this.description,
      required this.color,
      required this.id,
      required this.onTapProject});
  final String id;
  final String title;
  final String description;
  final int color;
  final VoidCallback onTapProject;

  @override
  State<ProjectTile> createState() => _ProjectTileState();
}

class _ProjectTileState extends State<ProjectTile> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10.0),
      child: Slidable(
        endActionPane: ActionPane(motion: const ScrollMotion(), children: [
          SlidableAction(
            onPressed: (context) async {
              await Database.removeProject(projectID: widget.id);
            },
            backgroundColor: const Color(0xFFFE4A49),
            foregroundColor: Colors.white,
            icon: Icons.delete,
            label: 'Delete',
          ),
        ]),
        child: InkWell(
          onTap: widget.onTapProject,
          child: Container(
              padding: const EdgeInsets.symmetric(vertical: 24, horizontal: 24),
              width: double.infinity,
              height: 200,
              decoration: BoxDecoration(
                  color: Color(widget.color),
                  borderRadius: BorderRadius.circular(12)),
              child: Row(
                children: [
                  Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const CircleAvatar(
                        radius: 22,
                        backgroundColor: Colors.white,
                        child: CircleAvatar(
                          backgroundImage: NetworkImage(
                              'https://sun9-62.userapi.com/impg/pEZUaZroUZdKDvAAKLC5FP-uE1NecElO3DFNqA/1q7IzV-GA-A.jpg?size=1440x1800&quality=95&sign=12fe97984ed0f17c6769d548e8f811c3&type=album'),
                          radius: 20,
                        ),
                      ),
                      Text(
                        '12/12 tasks 100%',
                        style: kTaskNameFontStyle(
                            color: Colors.white,
                            fontSize: 17,
                            fontWeight: FontWeight.w400),
                      ),
                      Text(
                        widget.title,
                        style: kTaskNameFontStyle(
                            color: Colors.white,
                            fontSize: 28,
                            fontWeight: FontWeight.w600),
                      )
                    ],
                  ),
                  Flexible(
                    child: Image.asset(
                      'images/mentor.png',
                      scale: 3,
                    ),
                  )
                ],
              )),
        ),
      ),
    );
  }
}
