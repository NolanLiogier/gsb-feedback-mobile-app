import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:frontend/features/auth/presentation/login_screen.dart';
import 'package:frontend/features/visits/presentation/visits_screen.dart';
import 'package:frontend/features/visits/presentation/visit_details_screen.dart';

GoRouter createAppRouter() {
  return GoRouter(
    initialLocation: '/login',
    routes: <RouteBase>[
      GoRoute(
        path: '/login',
        builder: (BuildContext context, GoRouterState state) =>
            const LoginScreen(),
      ),
      GoRoute(
        path: '/visits',
        builder: (BuildContext context, GoRouterState state) =>
            const VisitsScreen(),
      ),
      GoRoute(
        path: '/visits/:id',
        builder: (BuildContext context, GoRouterState state) {
          final idStr = state.pathParameters['id'];
          final id = idStr != null ? int.tryParse(idStr) : null;
          if (id == null) {
            return const Scaffold(
              body: Center(child: Text('Invalid visit')),
            );
          }
          return VisitDetailsScreen(visitId: id);
        },
      ),
    ],
  );
}