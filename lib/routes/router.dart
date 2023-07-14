import 'package:bussines_coach/routes/routes.dart';
import 'package:bussines_coach/screens/dashboard.dart';
import 'package:bussines_coach/screens/challenges_screen.dart';
import 'package:bussines_coach/screens/single_project_screen.dart';
import 'package:bussines_coach/screens/widget_tree.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

final GoRouter router = GoRouter(routes: <RouteBase>[
  GoRoute(
      path: '/',
      builder: (BuildContext context, GoRouterState state) {
        return const WidgetTree();
      },
      routes: [
        GoRoute(
          path: dashboardPageRoute,
          name: dashboardPageName,
          builder: (BuildContext context, GoRouterState state) {
            return Dashboard();
          },
        ),
        GoRoute(
            path: tasksScreenPageRoute,
            name: tasksScreenPageName,
            builder: (BuildContext context, GoRouterState state) {
              return const ChallengeScreen();
            },
            routes: [
              GoRoute(
                path: projectScreenPageRoute,
                name: projectScreenPageName,
                builder: (context, state) {
                  return SingleProject(
                    docId: state.queryParameters['docID'] ?? '',
                  );
                },
              )
            ]),
      ]),
]);
