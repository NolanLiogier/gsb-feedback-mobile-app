import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/intl.dart' as intl;

import 'app_localizations_en.dart';
import 'app_localizations_fr.dart';

// ignore_for_file: type=lint

/// Callers can lookup localized strings with an instance of AppLocalizations
/// returned by `AppLocalizations.of(context)`.
///
/// Applications need to include `AppLocalizations.delegate()` in their app's
/// `localizationDelegates` list, and the locales they support in the app's
/// `supportedLocales` list. For example:
///
/// ```dart
/// import 'l10n/app_localizations.dart';
///
/// return MaterialApp(
///   localizationsDelegates: AppLocalizations.localizationsDelegates,
///   supportedLocales: AppLocalizations.supportedLocales,
///   home: MyApplicationHome(),
/// );
/// ```
///
/// ## Update pubspec.yaml
///
/// Please make sure to update your pubspec.yaml to include the following
/// packages:
///
/// ```yaml
/// dependencies:
///   # Internationalization support.
///   flutter_localizations:
///     sdk: flutter
///   intl: any # Use the pinned version from flutter_localizations
///
///   # Rest of dependencies
/// ```
///
/// ## iOS Applications
///
/// iOS applications define key application metadata, including supported
/// locales, in an Info.plist file that is built into the application bundle.
/// To configure the locales supported by your app, you’ll need to edit this
/// file.
///
/// First, open your project’s ios/Runner.xcworkspace Xcode workspace file.
/// Then, in the Project Navigator, open the Info.plist file under the Runner
/// project’s Runner folder.
///
/// Next, select the Information Property List item, select Add Item from the
/// Editor menu, then select Localizations from the pop-up menu.
///
/// Select and expand the newly-created Localizations item then, for each
/// locale your application supports, add a new item and select the locale
/// you wish to add from the pop-up menu in the Value field. This list should
/// be consistent with the languages listed in the AppLocalizations.supportedLocales
/// property.
abstract class AppLocalizations {
  AppLocalizations(String locale)
    : localeName = intl.Intl.canonicalizedLocale(locale.toString());

  final String localeName;

  static AppLocalizations? of(BuildContext context) {
    return Localizations.of<AppLocalizations>(context, AppLocalizations);
  }

  static const LocalizationsDelegate<AppLocalizations> delegate =
      _AppLocalizationsDelegate();

  /// A list of this localizations delegate along with the default localizations
  /// delegates.
  ///
  /// Returns a list of localizations delegates containing this delegate along with
  /// GlobalMaterialLocalizations.delegate, GlobalCupertinoLocalizations.delegate,
  /// and GlobalWidgetsLocalizations.delegate.
  ///
  /// Additional delegates can be added by appending to this list in
  /// MaterialApp. This list does not have to be used at all if a custom list
  /// of delegates is preferred or required.
  static const List<LocalizationsDelegate<dynamic>> localizationsDelegates =
      <LocalizationsDelegate<dynamic>>[
        delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
      ];

  /// A list of this localizations delegate's supported locales.
  static const List<Locale> supportedLocales = <Locale>[
    Locale('en'),
    Locale('fr'),
  ];

  /// Application title shown in app bar and launcher
  ///
  /// In en, this message translates to:
  /// **'GSB App'**
  String get appTitle;

  /// Generic welcome message
  ///
  /// In en, this message translates to:
  /// **'Welcome'**
  String get welcome;

  /// Heading for locale test screen
  ///
  /// In en, this message translates to:
  /// **'Locale test'**
  String get localeTest;

  /// Button label to switch UI to English
  ///
  /// In en, this message translates to:
  /// **'English'**
  String get switchToEnglish;

  /// Button label to switch UI to French
  ///
  /// In en, this message translates to:
  /// **'Français'**
  String get switchToFrench;

  /// No description provided for @currentLocale.
  ///
  /// In en, this message translates to:
  /// **'Current: {locale}'**
  String currentLocale(String locale);

  /// Title of the login screen
  ///
  /// In en, this message translates to:
  /// **'LOGIN'**
  String get loginTitle;

  /// Subtitle under the login title
  ///
  /// In en, this message translates to:
  /// **'Account given by GSB administrator'**
  String get loginSubtitle;

  /// Label for the email field on login form
  ///
  /// In en, this message translates to:
  /// **'EMAIL'**
  String get loginEmailLabel;

  /// Placeholder hint for the email input on the login screen
  ///
  /// In en, this message translates to:
  /// **'name.surname@gsb.fr'**
  String get loginEmailHint;

  /// Label for the password field on login form
  ///
  /// In en, this message translates to:
  /// **'PASSWORD'**
  String get loginPasswordLabel;

  /// Placeholder hint for the password input on the login screen
  ///
  /// In en, this message translates to:
  /// **'Enter your password'**
  String get loginPasswordHint;

  /// Submit button label on login form
  ///
  /// In en, this message translates to:
  /// **'Log in'**
  String get loginButton;

  /// Link text for password recovery (removed from UI but kept for l10n)
  ///
  /// In en, this message translates to:
  /// **'Forgot password?'**
  String get loginForgotPassword;

  /// Company name in login footer
  ///
  /// In en, this message translates to:
  /// **'GALAXY SWISS BOURDIN'**
  String get loginFooterCompany;

  /// Version string in login footer
  ///
  /// In en, this message translates to:
  /// **'Version 2.4.0 - SIO BTS'**
  String get loginFooterVersion;

  /// Error when email or password is empty
  ///
  /// In en, this message translates to:
  /// **'Email and password are required'**
  String get loginErrorRequired;

  /// Default success message after login
  ///
  /// In en, this message translates to:
  /// **'Login successful'**
  String get loginSuccessDefault;

  /// Default error message when login request fails
  ///
  /// In en, this message translates to:
  /// **'Request failed'**
  String get loginErrorDefault;

  /// App bar logout button tooltip
  ///
  /// In en, this message translates to:
  /// **'Log out'**
  String get appBarLogout;

  /// Visits screen title
  ///
  /// In en, this message translates to:
  /// **'List of Visits'**
  String get visitsTitle;

  /// Search field placeholder on visits screen
  ///
  /// In en, this message translates to:
  /// **'Search for a visit...'**
  String get visitsSearchHint;

  /// Error when no user id in session
  ///
  /// In en, this message translates to:
  /// **'User not found'**
  String get visitsUserNotFound;

  /// Error when loading visits list fails
  ///
  /// In en, this message translates to:
  /// **'Failed to load visits'**
  String get visitsLoadError;

  /// Empty state when there are no visits
  ///
  /// In en, this message translates to:
  /// **'No visits'**
  String get visitsEmpty;

  /// Empty state when search has no results
  ///
  /// In en, this message translates to:
  /// **'No results'**
  String get visitsNoResults;

  /// Bottom nav label for Visits
  ///
  /// In en, this message translates to:
  /// **'Visits'**
  String get navVisits;

  /// Bottom nav label for Planning
  ///
  /// In en, this message translates to:
  /// **'Planning'**
  String get navPlanning;

  /// Visit details screen title
  ///
  /// In en, this message translates to:
  /// **'Visit Details'**
  String get visitDetailsTitle;

  /// Error when visit details payload is invalid
  ///
  /// In en, this message translates to:
  /// **'Invalid data'**
  String get visitDetailsInvalidData;

  /// Default error when loading visit details fails
  ///
  /// In en, this message translates to:
  /// **'Unable to load'**
  String get visitDetailsLoadError;

  /// Generic error fallback
  ///
  /// In en, this message translates to:
  /// **'Error'**
  String get visitDetailsError;

  /// Current status section label
  ///
  /// In en, this message translates to:
  /// **'CURRENT STATUS'**
  String get visitDetailsCurrentStatus;

  /// General information section label
  ///
  /// In en, this message translates to:
  /// **'GENERAL INFORMATION'**
  String get visitDetailsGeneralInfo;

  /// Label for visit date
  ///
  /// In en, this message translates to:
  /// **'Visit date'**
  String get visitDetailsVisitDate;

  /// Label for time slot
  ///
  /// In en, this message translates to:
  /// **'Time slot'**
  String get visitDetailsTimeSlot;

  /// Label for practice address
  ///
  /// In en, this message translates to:
  /// **'Practice location'**
  String get visitDetailsPracticeLocation;

  /// Assigned visitor section label
  ///
  /// In en, this message translates to:
  /// **'ASSIGNED VISITOR'**
  String get visitDetailsAssignedVisitor;

  /// Client section label
  ///
  /// In en, this message translates to:
  /// **'CLIENT'**
  String get visitDetailsClient;

  /// Comment section label
  ///
  /// In en, this message translates to:
  /// **'COMMENT'**
  String get visitDetailsComment;

  /// Label for creation date and time
  ///
  /// In en, this message translates to:
  /// **'Creation date'**
  String get visitDetailsCreationDate;

  /// Label for displayed rating when status is completed
  ///
  /// In en, this message translates to:
  /// **'Your rating'**
  String get visitDetailsRatingLabel;

  /// New visit flow screen title
  ///
  /// In en, this message translates to:
  /// **'Create a Visit'**
  String get newVisitTitle;

  /// Label for company selector (form screen)
  ///
  /// In en, this message translates to:
  /// **'Practitioner / Establishment'**
  String get newVisitStep1SelectCompany;

  /// Label for company dropdown on company screen
  ///
  /// In en, this message translates to:
  /// **'Company'**
  String get newVisitCompanyLabel;

  /// Hint for company dropdown
  ///
  /// In en, this message translates to:
  /// **'Select a company'**
  String get newVisitSelectCompanyHint;

  /// Placeholder for company dropdown
  ///
  /// In en, this message translates to:
  /// **'Select a practitioner'**
  String get newVisitStep1SelectHint;

  /// Cancel button
  ///
  /// In en, this message translates to:
  /// **'Cancel'**
  String get newVisitCancel;

  /// Continue button
  ///
  /// In en, this message translates to:
  /// **'Continue'**
  String get newVisitContinue;

  /// Heading on new visit form
  ///
  /// In en, this message translates to:
  /// **'New Request'**
  String get newRequestHeading;

  /// Subtitle on new visit form
  ///
  /// In en, this message translates to:
  /// **'Please fill in the information regarding your next medical visit.'**
  String get newRequestSubtitle;

  /// Visit date label
  ///
  /// In en, this message translates to:
  /// **'Date of the visit'**
  String get newVisitVisitDate;

  /// Objective/comment label
  ///
  /// In en, this message translates to:
  /// **'Objective of the visit'**
  String get newVisitObjective;

  /// Placeholder for objective field
  ///
  /// In en, this message translates to:
  /// **'Describe the main objective and the products to present...'**
  String get newVisitObjectiveHint;

  /// Submit button
  ///
  /// In en, this message translates to:
  /// **'Create visit'**
  String get newVisitSendRequest;

  /// Error loading companies list
  ///
  /// In en, this message translates to:
  /// **'Failed to load companies'**
  String get newVisitLoadCompaniesError;

  /// Error loading new visit data
  ///
  /// In en, this message translates to:
  /// **'Failed to load form data'**
  String get newVisitLoadDataError;

  /// Error creating visit
  ///
  /// In en, this message translates to:
  /// **'Failed to create visit'**
  String get newVisitCreateError;

  /// Success message after creating a visit
  ///
  /// In en, this message translates to:
  /// **'Visit created successfully'**
  String get newVisitCreateSuccess;

  /// Validation when continuing without selection
  ///
  /// In en, this message translates to:
  /// **'Please select a company'**
  String get newVisitSelectCompanyFirst;

  /// Validation for empty title
  ///
  /// In en, this message translates to:
  /// **'Title is required'**
  String get newVisitTitleRequired;

  /// Validation when visitor not selected
  ///
  /// In en, this message translates to:
  /// **'Please select a GSB visitor'**
  String get newVisitVisitorRequired;

  /// Validation when client not selected
  ///
  /// In en, this message translates to:
  /// **'Please select a client'**
  String get newVisitEmployeeRequired;

  /// Visitor dropdown hint
  ///
  /// In en, this message translates to:
  /// **'Select a visitor'**
  String get newVisitSelectVisitor;

  /// Product dropdown hint
  ///
  /// In en, this message translates to:
  /// **'Select a product'**
  String get newVisitSelectProduct;

  /// Label for GSB visitor dropdown
  ///
  /// In en, this message translates to:
  /// **'GSB Visitor'**
  String get newVisitGsbVisitorLabel;

  /// Label for client dropdown
  ///
  /// In en, this message translates to:
  /// **'Client'**
  String get newVisitEmployeeLabel;

  /// Hint for client dropdown
  ///
  /// In en, this message translates to:
  /// **'Select a client'**
  String get newVisitSelectEmployee;

  /// Label for product dropdown
  ///
  /// In en, this message translates to:
  /// **'Product'**
  String get newVisitProductLabel;

  /// Label for visit title field
  ///
  /// In en, this message translates to:
  /// **'Visit title'**
  String get newVisitFormTitleLabel;

  /// Button to open feedback screen
  ///
  /// In en, this message translates to:
  /// **'Feedback'**
  String get visitDetailsFeedbackBtn;

  /// Delete visit button
  ///
  /// In en, this message translates to:
  /// **'Delete'**
  String get visitDetailsDeleteBtn;

  /// Delete confirmation dialog title
  ///
  /// In en, this message translates to:
  /// **'Delete visit?'**
  String get visitDetailsDeleteConfirmTitle;

  /// Delete confirmation dialog message
  ///
  /// In en, this message translates to:
  /// **'This visit will be permanently deleted.'**
  String get visitDetailsDeleteConfirmMessage;

  /// Success message after deleting a visit
  ///
  /// In en, this message translates to:
  /// **'Visit deleted'**
  String get visitDetailsDeleteSuccess;

  /// Error when delete visit fails
  ///
  /// In en, this message translates to:
  /// **'Failed to delete visit'**
  String get visitDetailsDeleteError;

  /// Feedback screen title
  ///
  /// In en, this message translates to:
  /// **'Visit Report'**
  String get visitFeedbackTitle;

  /// Report section title
  ///
  /// In en, this message translates to:
  /// **'VISIT REPORT'**
  String get visitFeedbackReportTitle;

  /// Feedback section title
  ///
  /// In en, this message translates to:
  /// **'YOUR OPINION'**
  String get visitFeedbackYourOpinion;

  /// Rating label
  ///
  /// In en, this message translates to:
  /// **'RATE THIS CONSULTATION'**
  String get visitFeedbackRateLabel;

  /// Comment field section title
  ///
  /// In en, this message translates to:
  /// **'ADDITIONAL COMMENTS'**
  String get visitFeedbackAdditionalComments;

  /// Comment placeholder
  ///
  /// In en, this message translates to:
  /// **'What did you think of this visit?'**
  String get visitFeedbackCommentHint;

  /// Submit feedback button
  ///
  /// In en, this message translates to:
  /// **'Send Feedback'**
  String get visitFeedbackSendBtn;

  /// Error loading visit for feedback
  ///
  /// In en, this message translates to:
  /// **'Failed to load visit'**
  String get visitFeedbackLoadError;

  /// Error submitting feedback
  ///
  /// In en, this message translates to:
  /// **'Failed to send feedback'**
  String get visitFeedbackSubmitError;

  /// Success after sending feedback
  ///
  /// In en, this message translates to:
  /// **'Feedback sent'**
  String get visitsFeedbackSuccess;
}

class _AppLocalizationsDelegate
    extends LocalizationsDelegate<AppLocalizations> {
  const _AppLocalizationsDelegate();

  @override
  Future<AppLocalizations> load(Locale locale) {
    return SynchronousFuture<AppLocalizations>(lookupAppLocalizations(locale));
  }

  @override
  bool isSupported(Locale locale) =>
      <String>['en', 'fr'].contains(locale.languageCode);

  @override
  bool shouldReload(_AppLocalizationsDelegate old) => false;
}

AppLocalizations lookupAppLocalizations(Locale locale) {
  // Lookup logic when only language code is specified.
  switch (locale.languageCode) {
    case 'en':
      return AppLocalizationsEn();
    case 'fr':
      return AppLocalizationsFr();
  }

  throw FlutterError(
    'AppLocalizations.delegate failed to load unsupported locale "$locale". This is likely '
    'an issue with the localizations generation tool. Please file an issue '
    'on GitHub with a reproducible sample app and the gen-l10n configuration '
    'that was used.',
  );
}
