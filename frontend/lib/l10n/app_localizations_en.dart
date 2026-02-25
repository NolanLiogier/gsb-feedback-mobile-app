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

  @override
  String get visitDetailsRatingLabel => 'Your rating';

  @override
  String get newVisitTitle => 'Create a Visit';

  @override
  String get newVisitStep1SelectCompany => 'Practitioner / Establishment';

  @override
  String get newVisitCompanyLabel => 'Company';

  @override
  String get newVisitSelectCompanyHint => 'Select a company';

  @override
  String get newVisitStep1SelectHint => 'Select a practitioner';

  @override
  String get newVisitCancel => 'Cancel';

  @override
  String get newVisitContinue => 'Continue';

  @override
  String get newRequestHeading => 'New Request';

  @override
  String get newRequestSubtitle =>
      'Please fill in the information regarding your next medical visit.';

  @override
  String get newVisitVisitDate => 'Date of the visit';

  @override
  String get newVisitObjective => 'Objective of the visit';

  @override
  String get newVisitObjectiveHint =>
      'Describe the main objective and the products to present...';

  @override
  String get newVisitSendRequest => 'Create visit';

  @override
  String get newVisitLoadCompaniesError => 'Failed to load companies';

  @override
  String get newVisitLoadDataError => 'Failed to load form data';

  @override
  String get newVisitCreateError => 'Failed to create visit';

  @override
  String get newVisitCreateSuccess => 'Visit created successfully';

  @override
  String get newVisitSelectCompanyFirst => 'Please select a company';

  @override
  String get newVisitTitleRequired => 'Title is required';

  @override
  String get newVisitVisitorRequired => 'Please select a GSB visitor';

  @override
  String get newVisitEmployeeRequired => 'Please select a client';

  @override
  String get newVisitSelectVisitor => 'Select a visitor';

  @override
  String get newVisitSelectProduct => 'Select a product';

  @override
  String get newVisitGsbVisitorLabel => 'GSB Visitor';

  @override
  String get newVisitEmployeeLabel => 'Client';

  @override
  String get newVisitSelectEmployee => 'Select a client';

  @override
  String get newVisitProductLabel => 'Product';

  @override
  String get newVisitFormTitleLabel => 'Visit title';

  @override
  String get visitDetailsFeedbackBtn => 'Feedback';

  @override
  String get visitDetailsDeleteBtn => 'Delete';

  @override
  String get visitDetailsDeleteConfirmTitle => 'Delete visit?';

  @override
  String get visitDetailsDeleteConfirmMessage =>
      'This visit will be permanently deleted.';

  @override
  String get visitDetailsDeleteSuccess => 'Visit deleted';

  @override
  String get visitDetailsDeleteError => 'Failed to delete visit';

  @override
  String get visitFeedbackTitle => 'Visit Report';

  @override
  String get visitFeedbackReportTitle => 'VISIT REPORT';

  @override
  String get visitFeedbackYourOpinion => 'YOUR OPINION';

  @override
  String get visitFeedbackRateLabel => 'RATE THIS CONSULTATION';

  @override
  String get visitFeedbackAdditionalComments => 'ADDITIONAL COMMENTS';

  @override
  String get visitFeedbackCommentHint => 'What did you think of this visit?';

  @override
  String get visitFeedbackSendBtn => 'Send Feedback';

  @override
  String get visitFeedbackLoadError => 'Failed to load visit';

  @override
  String get visitFeedbackSubmitError => 'Failed to send feedback';

  @override
  String get visitsFeedbackSuccess => 'Feedback sent';
}
