// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for English (`en`).
class AppLocalizationsEn extends AppLocalizations {
  AppLocalizationsEn([String locale = 'en']) : super(locale);

  @override
  String get appTitle => 'GSB App';

  @override
  String get welcome => 'Welcome';

  @override
  String get localeTest => 'Locale test';

  @override
  String get switchToEnglish => 'English';

  @override
  String get switchToFrench => 'Français';

  @override
  String currentLocale(String locale) {
    return 'Current: $locale';
  }

  @override
  String get loginTitle => 'LOGIN';

  @override
  String get loginSubtitle => 'Account given by GSB administrator';

  @override
  String get loginEmailLabel => 'EMAIL';

  @override
  String get loginEmailHint => 'name.surname@gsb.fr';

  @override
  String get loginPasswordLabel => 'PASSWORD';

  @override
  String get loginPasswordHint => 'Enter your password';

  @override
  String get loginButton => 'Log in';

  @override
  String get loginForgotPassword => 'Forgot password?';

  @override
  String get loginFooterCompany => 'GALAXY SWISS BOURDIN';

  @override
  String get loginFooterVersion => 'Version 2.4.0 - SIO BTS';

  @override
  String get loginErrorRequired => 'Email and password are required';

  @override
  String get loginSuccessDefault => 'Login successful';

  @override
  String get loginErrorDefault => 'Request failed';

  @override
  String get appBarLogout => 'Log out';

  @override
  String get visitsTitle => 'List of Visits';

  @override
  String get visitsSearchHint => 'Search for a visit...';

  @override
  String get visitsUserNotFound => 'User not found';

  @override
  String get visitsLoadError => 'Failed to load visits';

  @override
  String get visitsEmpty => 'No visits';

  @override
  String get visitsNoResults => 'No results';

  @override
  String get navVisits => 'Visits';

  @override
  String get navPlanning => 'Planning';

  @override
  String get visitDetailsTitle => 'Visit Details';

  @override
  String get visitDetailsInvalidData => 'Invalid data';

  @override
  String get visitDetailsLoadError => 'Unable to load';

  @override
  String get visitDetailsError => 'Error';

  @override
  String get visitDetailsCurrentStatus => 'CURRENT STATUS';

  @override
  String get visitDetailsGeneralInfo => 'GENERAL INFORMATION';

  @override
  String get visitDetailsVisitDate => 'Visit date';

  @override
  String get visitDetailsTimeSlot => 'Time slot';

  @override
  String get visitDetailsPracticeLocation => 'Practice location';

  @override
  String get visitDetailsAssignedVisitor => 'ASSIGNED VISITOR';

  @override
  String get visitDetailsClient => 'CLIENT';

  @override
  String get visitDetailsComment => 'COMMENT';

  @override
  String get visitDetailsCreationDate => 'Creation date';
}
