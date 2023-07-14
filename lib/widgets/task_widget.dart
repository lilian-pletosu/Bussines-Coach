import 'package:bussines_coach/utils/constants.dart';
import 'package:flutter/material.dart';

class TaskWidget extends StatelessWidget {
  const TaskWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 8.0, bottom: 8.0, right: 8.0),
      child: Container(
        width: 170,
        height: 180,
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(30),
          color: const Color(0xffebe4ff).withOpacity(0.6),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text('Project name', style: kProjectNameFontStyle),
            Flexible(
              child: Text('Task name', style: kTaskNameFontStyle()),
            ),
            const Row(
              children: [
                Icon(
                  Icons.circle,
                  color: Colors.green,
                ),
                Text('till 10 May 2023'),
              ],
            )
          ],
        ),
      ),
    );
  }
}
