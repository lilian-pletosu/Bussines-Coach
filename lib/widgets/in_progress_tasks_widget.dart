import 'package:bussines_coach/utils/constants.dart';
import 'package:circle_progress_bar/circle_progress_bar.dart';
import 'package:flutter/material.dart';

class InProgressTasksWidget extends StatelessWidget {
  const InProgressTasksWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 18.0),
      child: Container(
        padding: const EdgeInsets.all(12),
        width: double.infinity,
        height: 110,
        decoration: BoxDecoration(boxShadow: [
          BoxShadow(
              color: Colors.grey.shade300,
              blurRadius: 4,
              offset: const Offset(1, 3))
        ], color: Colors.white, borderRadius: BorderRadius.circular(8)),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('Project', style: kProjectNameFontStyle),
                Text(
                  'Task name',
                  style: kTaskNameFontStyle(),
                ),
                Text(
                  '2 hours',
                  style: kProjectNameFontStyle,
                ),
              ],
            ),
            const SizedBox(
              width: 80,
              child: CircleProgressBar(
                foregroundColor: Colors.blue,
                backgroundColor: Colors.black12,
                value: 0.5,
                child: Center(
                  child: Text('test'),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
