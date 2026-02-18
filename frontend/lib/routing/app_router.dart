import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:frontend/features/auth/presentation/login_screen.dart';
import 'package:frontend/features/visits/presentation/visits_screen.dart';

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
    ],
  );
}