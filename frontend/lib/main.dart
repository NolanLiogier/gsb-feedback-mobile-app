import 'package:flutter/material.dart';
import 'package:frontend/l10n/app_localizations.dart';
import 'package:frontend/routing/app_router.dart';

void main() {
  runApp(const GsbApp());
}

class GsbApp extends StatelessWidget {
  const GsbApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: 'GSB App',
      locale: const Locale('en'),
      localizationsDelegates: AppLocalizations.localizationsDelegates,
      supportedLocales: AppLocalizations.supportedLocales,
      routerConfig: createAppRouter(),
    );
  }
}
