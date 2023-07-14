import 'package:bussines_coach/routes/routes.dart';
import 'package:bussines_coach/utils/constants.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class CustomBottomNavigationBar extends StatefulWidget {
  const CustomBottomNavigationBar({
    super.key,
  });

  @override
  State<CustomBottomNavigationBar> createState() =>
      _CustomBottomNavigationBarState();
}

class _CustomBottomNavigationBarState extends State<CustomBottomNavigationBar> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8.0, left: 8.0, right: 8.0),
      child: Container(
          // margin: EdgeInsets.all(20),
          decoration: BoxDecoration(boxShadow: [
            BoxShadow(
                color: Colors.black.withOpacity(.15),
                blurRadius: 30,
                offset: const Offset(0, 10)),
          ], borderRadius: BorderRadius.circular(30), color: kPurpleColor),
          child: Container(
            height: MediaQuery.of(context).size.height * .100,
            padding:
                const EdgeInsets.symmetric(horizontal: 32.0, vertical: 5.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                InkWell(
                  onTap: () => context.goNamed(dashboardPageName),
                  child: const Icon(
                    Icons.home_rounded,
                    color: Color(0xff5f33e1),
                    size: 30,
                  ),
                ),
                InkWell(
                  onTap: () => context.goNamed(tasksScreenPageName),
                  child: const Icon(
                    Icons.task_rounded,
                    color: Color(0xff5f33e1),
                    size: 30,
                  ),
                ),
                const Icon(
                  Icons.chat_rounded,
                  color: Color(0xff5f33e1),
                  size: 30,
                ),
                const Icon(
                  Icons.document_scanner_rounded,
                  color: Color(0xff5f33e1),
                  size: 30,
                ),
              ],
            ),
            // color: Colors.black,
          )),
    );
  }
}
