import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:frontend/core/navigation/route_observer.dart';
import 'package:frontend/features/auth/presentation/login_screen.dart';
import 'package:frontend/features/visits/presentation/visits_screen.dart';
import 'package:frontend/features/visits/presentation/visit_details_screen.dart';
import 'package:frontend/features/visits/presentation/visit_feedback_screen.dart';
import 'package:frontend/features/visits/presentation/new_visit_company_screen.dart';
import 'package:frontend/features/visits/presentation/new_visit_form_screen.dart';

GoRouter createAppRouter() {
  return GoRouter(
    initialLocation: '/login',
    observers: [appRouteObserver],
    routes: <RouteBase>[
      GoRoute(
        path: '/login',
        builder: (BuildContext context, GoRouterState state) =>
            const LoginScreen(),
      ),
      GoRoute(
        path: '/visits',
        builder: (BuildContext context, GoRouterState state) {
          final extra = state.extra;
          return VisitsScreen(
            key: ValueKey('visits_$extra'),
            showCreateSuccess: extra == true,
            showFeedbackSuccess: extra == 'feedback_success',
            showDeleteSuccess: extra == 'delete_success',
          );
        },
      ),
      GoRoute(
        path: '/visits/new',
        builder: (BuildContext context, GoRouterState state) =>
            const NewVisitCompanyScreen(),
      ),
      GoRoute(
        path: '/visits/new/form',
        builder: (BuildContext context, GoRouterState state) {
          final companyId = state.extra as int?;
          if (companyId == null) {
            return const Scaffold(
              body: Center(child: Text('Invalid data')),
            );
          }
          return NewVisitFormScreen(companyId: companyId);
        },
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
        routes: <RouteBase>[
          GoRoute(
            path: 'feedback',
            builder: (BuildContext context, GoRouterState state) {
              final idStr = state.pathParameters['id'];
              final id = idStr != null ? int.tryParse(idStr) : null;
              if (id == null) {
                return const Scaffold(
                  body: Center(child: Text('Invalid visit')),
                );
              }
              return VisitFeedbackScreen(visitId: id);
            },
          ),
        ],
      ),
    ],
  );
}