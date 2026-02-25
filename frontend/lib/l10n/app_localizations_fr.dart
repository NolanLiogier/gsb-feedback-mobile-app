// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for French (`fr`).
class AppLocalizationsFr extends AppLocalizations {
  AppLocalizationsFr([String locale = 'fr']) : super(locale);

  @override
  String get appTitle => 'Application GSB';

  @override
  String get welcome => 'Bienvenue';

  @override
  String get localeTest => 'Test de langue';

  @override
  String get switchToEnglish => 'Anglais';

  @override
  String get switchToFrench => 'Français';

  @override
  String currentLocale(String locale) {
    return 'Actuel : $locale';
  }

  @override
  String get loginTitle => 'Connexion';

  @override
  String get loginSubtitle => 'Compte donné par l\'administrateur GSB';

  @override
  String get loginEmailLabel => 'EMAIL';

  @override
  String get loginEmailHint => 'nom.prenom@gsb.fr';

  @override
  String get loginPasswordLabel => 'MOT DE PASSE';

  @override
  String get loginPasswordHint => 'Mot de passe';

  @override
  String get loginButton => 'Se connecter';

  @override
  String get loginForgotPassword => 'Mot de passe oublié ?';

  @override
  String get loginFooterCompany => 'GALAXY SWISS BOURDIN';

  @override
  String get loginFooterVersion => 'Version 2.4.0 - SIO BTS';

  @override
  String get loginErrorRequired => 'Email et mot de passe requis';

  @override
  String get loginSuccessDefault => 'Connexion réussie';

  @override
  String get loginErrorDefault => 'Échec de la requête';

  @override
  String get appBarLogout => 'Déconnexion';

  @override
  String get visitsTitle => 'Liste des Visites';

  @override
  String get visitsSearchHint => 'Rechercher une visite...';

  @override
  String get visitsUserNotFound => 'Utilisateur introuvable';

  @override
  String get visitsLoadError => 'Échec du chargement des visites';

  @override
  String get visitsEmpty => 'Aucune visite';

  @override
  String get visitsNoResults => 'Aucun résultat';

  @override
  String get navVisits => 'Visites';

  @override
  String get navPlanning => 'Planning';

  @override
  String get visitDetailsTitle => 'Détails de la Visite';

  @override
  String get visitDetailsInvalidData => 'Données invalides';

  @override
  String get visitDetailsLoadError => 'Chargement impossible';

  @override
  String get visitDetailsError => 'Erreur';

  @override
  String get visitDetailsCurrentStatus => 'STATUT ACTUEL';

  @override
  String get visitDetailsGeneralInfo => 'INFORMATIONS GÉNÉRALES';

  @override
  String get visitDetailsVisitDate => 'Date de la visite';

  @override
  String get visitDetailsTimeSlot => 'Créneau horaire';

  @override
  String get visitDetailsPracticeLocation => 'Localisation du cabinet';

  @override
  String get visitDetailsAssignedVisitor => 'VISITEUR ASSIGNÉ';

  @override
  String get visitDetailsClient => 'CLIENT';

  @override
  String get visitDetailsComment => 'COMMENTAIRE';

  @override
  String get visitDetailsCreationDate => 'Date de création';

  @override
  String get visitDetailsRatingLabel => 'Votre note';

  @override
  String get newVisitTitle => 'Créer une Visite';

  @override
  String get newVisitStep1SelectCompany => 'Praticien / Établissement';

  @override
  String get newVisitCompanyLabel => 'Établissement';

  @override
  String get newVisitSelectCompanyHint => 'Sélectionner un établissement';

  @override
  String get newVisitStep1SelectHint => 'Sélectionner un praticien';

  @override
  String get newVisitCancel => 'Annuler';

  @override
  String get newVisitContinue => 'Continuer';

  @override
  String get newRequestHeading => 'Nouvelle Demande';

  @override
  String get newRequestSubtitle =>
      'Veuillez remplir les informations concernant votre prochaine visite médicale.';

  @override
  String get newVisitVisitDate => 'Date de la visite';

  @override
  String get newVisitObjective => 'Objectif de la visite';

  @override
  String get newVisitObjectiveHint =>
      'Décrivez l\'objectif principal et les produits à présenter...';

  @override
  String get newVisitSendRequest => 'Créer la visite';

  @override
  String get newVisitLoadCompaniesError =>
      'Échec du chargement des établissements';

  @override
  String get newVisitLoadDataError => 'Échec du chargement des données';

  @override
  String get newVisitCreateError => 'Échec de la création de la visite';

  @override
  String get newVisitCreateSuccess => 'Visite créée avec succès';

  @override
  String get newVisitSelectCompanyFirst =>
      'Veuillez sélectionner un établissement';

  @override
  String get newVisitTitleRequired => 'Le titre est requis';

  @override
  String get newVisitVisitorRequired => 'Veuillez sélectionner un visiteur GSB';

  @override
  String get newVisitEmployeeRequired => 'Veuillez sélectionner un client';

  @override
  String get newVisitSelectVisitor => 'Sélectionner un visiteur';

  @override
  String get newVisitSelectProduct => 'Sélectionner un produit';

  @override
  String get newVisitGsbVisitorLabel => 'Visiteur GSB';

  @override
  String get newVisitEmployeeLabel => 'Client';

  @override
  String get newVisitSelectEmployee => 'Sélectionner un client';

  @override
  String get newVisitProductLabel => 'Produit';

  @override
  String get newVisitFormTitleLabel => 'Titre de la visite';

  @override
  String get visitDetailsFeedbackBtn => 'Avis';

  @override
  String get visitDetailsDeleteBtn => 'Supprimer';

  @override
  String get visitDetailsDeleteConfirmTitle => 'Supprimer la visite ?';

  @override
  String get visitDetailsDeleteConfirmMessage =>
      'Cette visite sera définitivement supprimée.';

  @override
  String get visitDetailsDeleteSuccess => 'Visite supprimée';

  @override
  String get visitDetailsDeleteError => 'Échec de la suppression';

  @override
  String get visitFeedbackTitle => 'Compte-rendu de visite';

  @override
  String get visitFeedbackReportTitle => 'RAPPORT DE VISITE';

  @override
  String get visitFeedbackYourOpinion => 'VOTRE AVIS';

  @override
  String get visitFeedbackRateLabel => 'NOTEZ CETTE CONSULTATION';

  @override
  String get visitFeedbackAdditionalComments => 'COMMENTAIRES ADDITIONNELS';

  @override
  String get visitFeedbackCommentHint => 'Qu\'avez-vous pensé de cette visite?';

  @override
  String get visitFeedbackSendBtn => 'Envoyer l\'avis';

  @override
  String get visitFeedbackLoadError => 'Échec du chargement';

  @override
  String get visitFeedbackSubmitError => 'Échec de l\'envoi de l\'avis';

  @override
  String get visitsFeedbackSuccess => 'Avis envoyé';
}
